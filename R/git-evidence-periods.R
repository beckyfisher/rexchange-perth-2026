# ---------------------------------------------------------------------------
# Files changed on a working day, before and since the speaker stopped writing
# code by hand, for the slide "The change since June".
#
#   & "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/git-evidence-periods.R
#
# Clones the seven public repositories of R/git-evidence.R, classifies every
# file changed in every commit she authored, and writes two CSVs to data/. Those
# CSVs are committed, so R/figures.R builds the figure offline.
#
# R/git-evidence.R is the first measurement, made on 2026-07-28, and is left as
# it was run: the published abstract quotes it (1,340 commits; tests tripled as
# a share). This script measures the same repositories to 2026-10-13, with two
# changes of method that the later work required:
#
#   * Every branch except gh-pages is read, merges excluded, and a commit seen
#     on several branches or in both FSSgam repositories is counted once. The
#     July run read only the default branch, and the bayesnec work since July is
#     on dev and predev; its default branch has not changed since August 2025.
#     gh-pages is excluded because its commits are pkgdown deploys.
#   * Commits are split by date, not by a Co-Authored-By: Claude trailer. Claude
#     Code and Codex commit as the speaker, and not all of that work carries the
#     trailer. She stopped writing code by hand on 20 June 2026, so everything
#     from that day is work done with an AI assistant. The period after it is
#     split at 28 July, the date of the first measurement.
#
# A working day is a day with at least one of her commits in these
# repositories. Files changed on a working day is a measure of volume, not of
# useful work. The file categories are those of R/git-evidence.R.
#
# Commits after the cutoff are excluded by both commit and author date, so a
# re-run gives the same answer unless a branch is deleted or rewritten.
# ---------------------------------------------------------------------------

suppressMessages({
  library(dplyr)
  library(stringr)
})

repos <- c(
  "open-AIMS/bayesnec",
  "beckyfisher/FSSgam_package",
  "beckyfisher/FSSgam",
  "beckyfisher/toxval",
  "open-AIMS/NEC-estimation",
  "beckyfisher/ElicitN",
  "bcgov/ssdtools"
)

me <- c("rebeccafisher76@gmail.com",
        "r.fisher@aims.gov.au",
        "beckyfisher@users.noreply.github.com")

ai_start <- as.Date("2026-06-20")
first_measure <- as.Date("2026-07-28")
cutoff <- as.Date("2026-10-13")

work <- file.path(tempdir(), "git-evidence-periods")
dir.create(work, showWarnings = FALSE, recursive = TRUE)

read_repo <- function(r) {
  dest <- file.path(work, basename(r))
  if (!dir.exists(dest)) {
    message("cloning ", r)
    system2("git", c("clone", "-q", paste0("https://github.com/", r, ".git"),
                     shQuote(dest)))
  }
  # With --remotes, --exclude takes the name without refs/remotes/; the full
  # ref name matches nothing and gh-pages would be read.
  fmt <- "@@@%H|%ae|%ad|%(trailers:key=Co-Authored-By,valueonly,separator=%x2C)"
  out <- system2("git", c("-C", shQuote(dest), "log",
                          "--exclude=origin/gh-pages", "--remotes", "--no-merges",
                          paste0("--before=", cutoff + 1, "T00:00:00"),
                          "--date=short",
                          # quoted for the Linux shell; on Windows git removes them
                          shQuote(paste0("--pretty=format:", fmt)), "--numstat"),
                 stdout = TRUE)

  sha <- email <- date <- co <- NA_character_
  rows <- vector("list", length(out))
  k <- 0L
  for (ln in out) {
    if (startsWith(ln, "@@@")) {
      f <- strsplit(substring(ln, 4), "|", fixed = TRUE)[[1]]
      sha <- f[1]; email <- tolower(f[2]); date <- f[3]
      co <- if (length(f) > 3) paste(f[-(1:3)], collapse = "|") else ""
    } else if (nzchar(ln)) {
      p <- strsplit(ln, "\t", fixed = TRUE)[[1]]
      if (length(p) == 3) {
        k <- k + 1L
        rows[[k]] <- c(basename(r), sha, email, date, co, p[3])
      }
    }
  }
  m <- do.call(rbind, rows[seq_len(k)])
  tibble(repo = m[, 1], sha = m[, 2], email = m[, 3], date = as.Date(m[, 4]),
         co = m[, 5], file = m[, 6])
}

all <- bind_rows(lapply(repos, read_repo)) |>
  filter(email %in% me, date <= cutoff) |>
  distinct(sha, file, .keep_all = TRUE) |>
  mutate(
    trailer = str_detect(co, regex("claude", ignore_case = TRUE)),
    period = case_when(
      date < ai_start       ~ "Before 20 June",
      date <= first_measure ~ "20 June to 28 July",
      TRUE                  ~ "29 July to 13 October"
    ),
    category = case_when(
      str_detect(file, "^tests/|testthat")   ~ "Tests",
      str_detect(file, "^man/")               ~ "Documentation (generated)",
      str_detect(file, paste0("^vignettes/|^README|^NEWS|\\.Rmd$|\\.qmd$|",
                              "^prompts/|CLAUDE|AGENTS")) ~ "Documentation (written)",
      str_detect(file, paste0("^\\.github/|^DESCRIPTION|^NAMESPACE|^_pkgdown|",
                              "^cran-comments|^\\.Rbuildignore|^codemeta")) ~ "Packaging, CI, CRAN",
      str_detect(file, "^R/|\\.R$|\\.stan$")  ~ "Source code",
      TRUE                                    ~ "Other"
    )
  )

stopifnot(nrow(all) > 0)

periods <- all |>
  group_by(period) |>
  summarise(working_days = n_distinct(date),
            commits = n_distinct(sha),
            first_day = min(date),
            last_day = max(date),
            .groups = "drop")

by_category <- all |>
  count(period, category, name = "files") |>
  left_join(select(periods, period, working_days), by = "period") |>
  group_by(period) |>
  mutate(share = 100 * files / sum(files),
         per_day = files / working_days) |>
  ungroup()

write.csv(by_category, file.path("data", "git-evidence-periods.csv"),
          row.names = FALSE)

since <- all |> filter(date > first_measure)
facts <- tibble::tribble(
  ~key, ~value,
  "repos_analysed",        paste(repos, collapse = "; "),
  "cutoff",                format(cutoff),
  "commits_total",         as.character(n_distinct(all$sha)),
  "commits_since_ai_start", as.character(n_distinct(all$sha[all$date >= ai_start])),
  "commits_since_ai_start_with_trailer",
    as.character(n_distinct(all$sha[all$date >= ai_start & all$trailer])),
  "bayesnec_share_commits_since_july",
    sprintf("%.0f", 100 * n_distinct(since$sha[since$repo == "bayesnec"]) /
              n_distinct(since$sha)),
  "bayesnec_share_files_since_july",
    sprintf("%.0f", 100 * mean(since$repo == "bayesnec")),
  "generated_on",          format(Sys.Date())
) |>
  bind_rows(periods |>
              transmute(key = paste0("working_days: ", period),
                        value = as.character(working_days)),
            periods |>
              transmute(key = paste0("commits: ", period),
                        value = as.character(commits)))

write.csv(facts, file.path("data", "git-evidence-periods-facts.csv"),
          row.names = FALSE)

print(as.data.frame(periods), row.names = FALSE)
print(as.data.frame(facts), row.names = FALSE)
message("\nwrote data/git-evidence-periods.csv and data/git-evidence-periods-facts.csv")
