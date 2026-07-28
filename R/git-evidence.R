# ---------------------------------------------------------------------------
# Derive the evidence behind the "where the work goes" slide from the actual
# commit history of Rebecca's R packages.
#
#   & "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/git-evidence.R
#
# Clones the public repos to a temp directory, classifies every file touched in
# every commit she authored, and writes two small CSVs to data/. Those CSVs are
# committed, so R/figures.R can build the figure offline and anyone can check
# the numbers without re-cloning.
#
# Method notes, because this is presented as evidence and needs to survive
# scrutiny from the audience:
#
#   * "AI-assisted" is defined narrowly and verifiably: the commit carries a
#     `Co-Authored-By: Claude ...` trailer. That is conservative — it misses
#     AI-assisted commits made before the trailer convention was adopted, so if
#     anything it understates the contrast.
#   * The unit is a *file touch* (one file changed in one commit), not lines and
#     not commits. Lines are dominated by generated `man/` output; commits hide
#     the fact that one commit often spans categories.
#   * Only public repos are included. Work in private repos is invisible here.
#   * `man/` is roxygen-generated, so it is reported separately from written docs.
# ---------------------------------------------------------------------------

suppressMessages({
  library(dplyr)
  library(stringr)
  library(tidyr)
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

# Rebecca's git identities across those repos.
me <- c("rebeccafisher76@gmail.com",
        "r.fisher@aims.gov.au",
        "beckyfisher@users.noreply.github.com")

work <- file.path(tempdir(), "git-evidence")
dir.create(work, showWarnings = FALSE, recursive = TRUE)

for (r in repos) {
  dest <- file.path(work, basename(r))
  if (!dir.exists(dest)) {
    message("cloning ", r)
    system2("git", c("clone", "-q", paste0("https://github.com/", r, ".git"),
                     shQuote(dest)))
  }
}

read_repo <- function(path) {
  fmt <- paste0("@@@%H|%ae|%ad|",
                "%(trailers:key=Co-Authored-By,valueonly,separator=%x2C)")
  out <- system2("git", c("-C", shQuote(path), "log", "--no-merges",
                          "--date=short", paste0("--pretty=format:", fmt),
                          "--numstat"),
                 stdout = TRUE, stderr = FALSE)
  if (!length(out)) return(NULL)

  sha <- email <- date <- co <- NA_character_
  rows <- list()
  for (ln in out) {
    if (startsWith(ln, "@@@")) {
      f <- strsplit(substring(ln, 4), "|", fixed = TRUE)[[1]]
      sha <- f[1]; email <- tolower(f[2]); date <- f[3]
      co <- if (length(f) > 3) paste(f[-(1:3)], collapse = "|") else ""
    } else if (nzchar(ln)) {
      p <- strsplit(ln, "\t", fixed = TRUE)[[1]]
      if (length(p) == 3) {
        rows[[length(rows) + 1L]] <- data.frame(
          repo = basename(path), sha = sha, email = email, date = date,
          co = co, file = p[3], stringsAsFactors = FALSE
        )
      }
    }
  }
  bind_rows(rows)
}

all <- bind_rows(lapply(file.path(work, basename(repos)), read_repo)) |>
  filter(email %in% me) |>
  mutate(
    date = as.Date(date),
    ai = str_detect(coalesce(co, ""), regex("claude", ignore_case = TRUE)),
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

# --- 1. share of file touches by category, AI-assisted vs not ---------------
shares <- all |>
  mutate(era = ifelse(ai, "With an AI assistant", "Before")) |>
  count(era, category, name = "touches") |>
  group_by(era) |>
  mutate(share = 100 * touches / sum(touches)) |>
  ungroup()

dir.create("data", showWarnings = FALSE)
write.csv(shares, file.path("data", "git-evidence-shares.csv"), row.names = FALSE)

# --- 2. headline facts, so the slide text is reproducible too ---------------
ai_commits <- all |> filter(ai) |> distinct(sha, date)

fss <- all |> filter(repo == "FSSgam_package")
fss_first     <- min(fss$date)
fss_first_test <- suppressWarnings(min(fss$date[fss$category == "Tests"]))
fss_first_ci   <- suppressWarnings(
  min(fss$date[str_detect(fss$file, "^\\.github/workflows/")]))

busiest_pre_ai <- all |>
  filter(!ai) |>
  distinct(sha, date) |>
  count(date, sort = TRUE) |>
  slice(1)

# The busiest pre-AI day *in 2026*, i.e. same year and same packages, so it is a
# fair comparator rather than a comparison with 2018-era working habits. In
# practice this is the day spent fighting a pkgdown GitHub Actions workflow.
busiest_2026_pre_ai <- all |>
  filter(!ai, format(date, "%Y") == "2026") |>
  distinct(sha, date) |>
  count(date, sort = TRUE) |>
  slice(1)

facts <- tibble::tribble(
  ~key, ~value,
  "repos_analysed",            paste(repos, collapse = "; "),
  "commits_total",             as.character(n_distinct(all$sha)),
  "commits_ai_trailer",        as.character(nrow(ai_commits)),
  "ai_active_days",            as.character(n_distinct(ai_commits$date)),
  "ai_first_date",             format(min(ai_commits$date)),
  "ai_last_date",              format(max(ai_commits$date)),
  "fssgam_created",            format(fss_first),
  "fssgam_first_test",         format(fss_first_test),
  "fssgam_first_ci",           format(fss_first_ci),
  "fssgam_years_without_tests",
    sprintf("%.1f", as.numeric(fss_first_test - fss_first) / 365.25),
  "fssgam_test_files_now",
    as.character(n_distinct(fss$file[fss$category == "Tests"])),
  "busiest_pre_ai_day",        format(busiest_pre_ai$date),
  "busiest_pre_ai_day_commits", as.character(busiest_pre_ai$n),
  "busiest_2026_pre_ai_day",   format(busiest_2026_pre_ai$date),
  "busiest_2026_pre_ai_day_commits", as.character(busiest_2026_pre_ai$n),
  "generated_on",              format(Sys.Date())
)

write.csv(facts, file.path("data", "git-evidence-facts.csv"), row.names = FALSE)

message("\n--- headline facts ---")
print(as.data.frame(facts), row.names = FALSE)
message("\nwrote data/git-evidence-shares.csv and data/git-evidence-facts.csv")
