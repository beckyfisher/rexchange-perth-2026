# ---------------------------------------------------------------------------
# Count the working days behind the "where the work goes" figure.
#
#   & "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/git-evidence-days.R
#
# R/git-evidence.R measured, on 2026-07-28, the files changed in each category
# before and with an AI assistant. Its CSVs are left as that run wrote them,
# because the published abstract quotes them (1,340 commits; tests tripled as a
# share), and a re-run today would include later work. This script adds the one
# number that run did not record: the working days in each period, a working
# day being a day with at least one of her commits in the seven repositories.
# R/figures.R divides the files changed by it, so the figure shows how much
# changed on a working day as well as the shares.
#
# Each repository is read as its default branch stood at the end of 2026-07-28
# (the last first-parent commit before 29 July), so a re-run gives the same
# answer. That reconstruction holds nine commits more than the July run, all in
# toxval on 24 and 26 June (51 file changes, 23 of them tests); why the July run
# lacked them is not known. They fall in "Before", because they have no
# Co-Authored-By trailer. Counting or dropping those two days gives 302 or 300
# working days before, and 12.06 or 12.14 files changed a working day, so the
# figure is the same either way. The days are counted with them.
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

cutoff <- as.Date("2026-07-28")

work <- file.path(tempdir(), "git-evidence-days")
dir.create(work, showWarnings = FALSE, recursive = TRUE)

read_days <- function(r) {
  dest <- file.path(work, basename(r))
  if (!dir.exists(dest)) {
    message("cloning ", r)
    system2("git", c("clone", "-q", paste0("https://github.com/", r, ".git"),
                     shQuote(dest)))
  }
  tip <- system2("git", c("-C", shQuote(dest), "rev-list", "-1", "--first-parent",
                          paste0("--before=", cutoff + 1, "T00:00:00"), "HEAD"),
                 stdout = TRUE)
  # The format holds "|", so it is quoted for the Linux shell that system2()
  # goes through there; on Windows the quotes are passed to git and removed.
  fmt <- "%H|%ae|%ad|%(trailers:key=Co-Authored-By,valueonly,separator=%x2C)"
  out <- system2("git", c("-C", shQuote(dest), "log", tip, "--no-merges",
                          "--date=short", shQuote(paste0("--pretty=format:", fmt))),
                 stdout = TRUE)
  f <- strsplit(out, "|", fixed = TRUE)
  tibble(
    repo = basename(r),
    sha = vapply(f, `[`, "", 1),
    email = tolower(vapply(f, `[`, "", 2)),
    date = as.Date(vapply(f, `[`, "", 3)),
    co = vapply(f, function(x) paste(x[-(1:3)], collapse = "|"), "")
  )
}

commits <- bind_rows(lapply(repos, read_days)) |>
  filter(email %in% me, date <= cutoff) |>
  mutate(era = ifelse(str_detect(co, regex("claude", ignore_case = TRUE)),
                      "With an AI assistant", "Before"))

stopifnot(nrow(commits) > 0)

days <- commits |>
  group_by(era) |>
  summarise(working_days = n_distinct(date),
            first_day = min(date),
            last_day = max(date),
            .groups = "drop") |>
  mutate(branches_as_of = format(cutoff),
         generated_on = format(Sys.Date()))

write.csv(days, file.path("data", "git-evidence-days.csv"), row.names = FALSE)
print(as.data.frame(days), row.names = FALSE)
message("\nwrote data/git-evidence-days.csv")
