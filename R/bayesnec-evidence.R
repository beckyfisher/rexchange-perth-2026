# ---------------------------------------------------------------------------
# Derive the evidence behind the bayesnec slide: what the package's public
# history shows from June to October 2026.
#
#   Rscript R/bayesnec-evidence.R
#
# Needs git and an authenticated GitHub CLI (`gh`), so it is run in WSL and not
# on CI. It clones open-AIMS/bayesnec to a temp directory, reads the issues and
# pull requests through `gh api`, and writes two small CSVs to data/. Those are
# committed, so R/figures.R can draw the figure offline.
#
# This is the third period of the AI section. R/git-evidence.R, which measured
# the first weeks on 2026-07-28, is left as it was run.
#
# Method notes:
#   * Every branch except gh-pages (pkgdown deploys) is read, and merges are
#     excluded. R/git-evidence.R read the default branch only; here that would
#     find nothing, because bayesnec's default branch is master, the CRAN
#     release line, unchanged since August 2025. The work since June is on dev,
#     predev and the issue branches.
#   * Claude Code and Codex CLI commit, open issues and open pull requests
#     through the speaker's own git identity and GitHub account, and not all of
#     that work carries a Co-Authored-By trailer. So the date separates the
#     periods here, not the trailer: from 20 June 2026 she did not write code by
#     hand.
#   * Where a commit sits now is read from the branches: merged into dev, only
#     on predev (the branch she parked unreviewed work on), or only on branches
#     never merged.
#   * Issue counts include every issue, whoever opened it; the facts file gives
#     the counts for issues opened from her account.
# ---------------------------------------------------------------------------

suppressMessages(library(dplyr))

repo <- "open-AIMS/bayesnec"
me <- c("rebeccafisher76@gmail.com",
        "r.fisher@aims.gov.au",
        "beckyfisher@users.noreply.github.com")
ai_start <- as.Date("2026-06-20")
first_week <- as.Date("2026-06-01")  # a Monday

work <- file.path(tempdir(), "bayesnec-evidence")
if (!dir.exists(work)) {
  message("cloning ", repo)
  system2("git", c("clone", "-q", paste0("https://github.com/", repo, ".git"),
                   shQuote(work)))
}
git <- function(...) {
  system2("git", c("-C", shQuote(work), ...), stdout = TRUE, stderr = FALSE)
}
gh_tsv <- function(path, jq, cols) {
  out <- system2("gh", c("api", "--paginate", shQuote(path), "--jq", shQuote(jq)),
                 stdout = TRUE)
  parts <- strsplit(out, "\t", fixed = TRUE)
  parts <- lapply(parts, function(p) c(p, rep("", length(cols) - length(p))))
  setNames(as_tibble(do.call(rbind, parts), .name_repair = "minimal"), cols)
}

# --- commits -----------------------------------------------------------------
log <- git("log", shQuote("--exclude=origin/gh-pages"), "--remotes",
           "--no-merges", "--date=short", shQuote("--pretty=format:%H|%ae|%ad"))
commits <- setNames(as_tibble(do.call(rbind, strsplit(log, "|", fixed = TRUE)),
                              .name_repair = "minimal"), c("sha", "email", "date")) |>
  mutate(email = tolower(email), date = as.Date(date)) |>
  filter(email %in% me)

on_dev <- git("rev-list", "origin/dev")
on_predev <- git("rev-list", "origin/predev")
commits <- commits |>
  mutate(where = case_when(sha %in% on_dev ~ "dev",
                           sha %in% on_predev ~ "predev",
                           TRUE ~ "other"))
stopifnot(nrow(commits) > 0)

# --- issues and pull requests ---------------------------------------------------
# All issues, not only those updated recently, so that the number open in any
# week counts issues nobody touched.
issues <- gh_tsv(
  paste0("repos/", repo, "/issues?state=all&per_page=100"),
  paste('.[] | [.number, .user.login, .created_at[0:10], (.closed_at // "")[0:10],',
        '(if .pull_request then "pr" else "issue" end)] | @tsv'),
  c("number", "user", "created", "closed", "kind")) |>
  filter(kind == "issue") |>
  mutate(created = as.Date(created), closed = as.Date(na_if(closed, "")))

pulls <- gh_tsv(
  paste0("repos/", repo, "/pulls?state=all&per_page=100"),
  '.[] | [.number, .base.ref, (.merged_at // "")[0:10]] | @tsv',
  c("number", "base", "merged")) |>
  mutate(merged = as.Date(na_if(merged, "")))

# --- 1. weekly series for the figure ------------------------------------------------
week_of <- function(d) as.Date(cut(d, "week", start.on.monday = TRUE))
weeks <- seq(first_week, week_of(Sys.Date()), by = "week")
in_week <- function(d) vapply(weeks, function(w) sum(!is.na(d) & d >= w & d < w + 7), 0L)
open_at_end <- vapply(weeks, function(w) {
  sum(issues$created < w + 7 & (is.na(issues$closed) | issues$closed >= w + 7))
}, 0L)

weekly <- tibble(
  week = weeks,
  commits_dev = in_week(commits$date[commits$where == "dev"]),
  commits_predev = in_week(commits$date[commits$where == "predev"]),
  commits_other = in_week(commits$date[commits$where == "other"]),
  issues_opened = in_week(issues$created),
  issues_closed = in_week(issues$closed),
  issues_open_at_end = open_at_end,
  prs_merged_dev = in_week(pulls$merged[pulls$base == "dev"]),
  prs_merged_predev = in_week(pulls$merged[pulls$base == "predev"])
)
dir.create("data", showWarnings = FALSE)
write.csv(weekly, file.path("data", "bayesnec-weekly.csv"), row.names = FALSE)

# --- 2. headline facts, so the slide text is reproducible too -------------------
since <- commits |> filter(date >= ai_start)
mine <- issues |> filter(user == "beckyfisher", created >= ai_start)
old_closed <- issues |>
  filter(created < as.Date("2026-01-01"), !is.na(closed), closed >= ai_start)
peak <- weekly |>
  mutate(n = commits_dev + commits_predev + commits_other) |>
  slice_max(n, n = 1, with_ties = FALSE)
open_on <- function(d) sum(issues$created < d & (is.na(issues$closed) | issues$closed >= d))
open_then <- issues |>
  filter(created < ai_start, is.na(closed) | closed >= ai_start)

facts <- tibble::tribble(
  ~key, ~value,
  "repo",                         repo,
  "ai_start",                     format(ai_start),
  "last_commit_before_june",      format(max(commits$date[commits$date < first_week])),
  "commits_since_ai_start",       as.character(nrow(since)),
  "commits_since_in_dev",         as.character(sum(since$where == "dev")),
  "commits_since_predev_only",    as.character(sum(since$where == "predev")),
  "commits_since_never_merged",   as.character(sum(since$where == "other")),
  "peak_week",                    format(peak$week),
  "peak_week_commits",            as.character(peak$n),
  "issues_opened_by_her_since",   as.character(nrow(mine)),
  "issues_opened_by_her_closed",  as.character(sum(!is.na(mine$closed))),
  "issues_opened_by_her_open",    as.character(sum(is.na(mine$closed))),
  "issues_pre2026_closed_since",  as.character(nrow(old_closed)),
  "issues_pre2026_oldest_closed", format(min(old_closed$created)),
  "issues_open_on_2026_06_01",    as.character(open_on(first_week)),
  "issues_open_on_ai_start",      as.character(open_on(ai_start)),
  "issues_open_on_ai_start_pre2026", as.character(sum(open_then$created < as.Date("2026-01-01"))),
  "issues_open_on_ai_start_closed_now", as.character(sum(!is.na(open_then$closed))),
  "issues_closed_since_ai_start", as.character(sum(!is.na(issues$closed) & issues$closed >= ai_start)),
  "issues_open_max_weekly",       as.character(max(weekly$issues_open_at_end)),
  "issues_open_now",              as.character(sum(is.na(issues$closed))),
  "prs_merged_dev_since",         as.character(sum(pulls$merged >= ai_start & pulls$base == "dev", na.rm = TRUE)),
  "prs_merged_predev",            as.character(sum(!is.na(pulls$merged) & pulls$base == "predev")),
  "first_predev_merge",           format(min(pulls$merged[pulls$base == "predev"], na.rm = TRUE)),
  "predev_ahead_of_dev",          git("rev-list", "--count", "--no-merges", "origin/dev..origin/predev"),
  "dev_ahead_of_master",          git("rev-list", "--count", "--no-merges", "origin/master..origin/dev"),
  "generated_on",                 format(Sys.Date())
)
write.csv(facts, file.path("data", "bayesnec-facts.csv"), row.names = FALSE)

message("\n--- headline facts ---")
print(as.data.frame(facts), row.names = FALSE)
message("\nwrote data/bayesnec-weekly.csv and data/bayesnec-facts.csv")
