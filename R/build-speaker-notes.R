# ---------------------------------------------------------------------------
# Regenerate the narration section of notes/speaker-notes.md from the
# ::: {.notes} blocks in talk/index.qmd.
#
#   & "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/build-speaker-notes.R
#
# The deck is the single source of truth for the notes: maintaining the same
# prose in two files guarantees they drift apart, and the version that matters
# during delivery is the one in the speaker view.
#
# Convention: inside a notes block, a line beginning with "> " is a stage
# direction (something to do, not something to say). It is passed through as a
# blockquote here and renders as one in the reveal speaker view. There is no
# guessing — if you want a direction, mark it.
#
# Everything outside the BEGIN/END GENERATED markers in speaker-notes.md is
# hand-written and preserved.
# ---------------------------------------------------------------------------

qmd_path   <- file.path("talk", "index.qmd")
notes_path <- file.path("notes", "speaker-notes.md")

BEGIN <- "<!-- BEGIN GENERATED -->"
END   <- "<!-- END GENERATED -->"

qmd <- readLines(qmd_path, warn = FALSE, encoding = "UTF-8")

# drop the YAML header so its --- fences don't split slides
yaml_ends <- grep("^---\\s*$", qmd)[2]
body <- qmd[(yaml_ends + 1):length(qmd)]

blocks <- split(body, cumsum(grepl("^---\\s*$", body)))

clean_inline <- function(x) {
  x <- gsub("\\{[^}]*\\}", "", x)                     # {.smaller}, {.divider}
  x <- gsub("\\[([^]]*)\\]\\{[^}]*\\}", "\\1", x)     # [Part one]{.era-num}
  x <- gsub("\\\\$", "", x)                           # trailing hard line break
  x <- gsub("[*_]{1,2}", "", x)                       # bold / italic
  trimws(x)
}

slides <- list()

for (blk in blocks) {
  # locate the notes div and its matching close
  start <- grep("^::: *\\{\\.notes\\}", blk)
  if (!length(start)) next
  start <- start[1]

  depth <- 1L
  end <- NA_integer_
  for (i in seq(start + 1, length(blk))) {
    if (grepl("^::: *\\{", blk[i])) depth <- depth + 1L
    else if (grepl("^:::\\s*$", blk[i])) depth <- depth - 1L
    if (depth == 0L) { end <- i; break }
  }
  if (is.na(end)) next

  notes <- blk[(start + 1):(end - 1)]

  # title: the ## heading if there is one, otherwise the first line of visible
  # slide content (this is how the punch-line slides get named)
  before <- blk[seq_len(start - 1)]
  h <- grep("^##\\s+", before, value = TRUE)
  if (length(h)) {
    title <- clean_inline(sub("^##\\s+", "", h[1]))
  } else {
    cand <- before[!grepl("^(:::|!\\[|---|\\s*$)", before)]
    title <- if (length(cand)) clean_inline(cand[1]) else "(untitled slide)"
    title <- sub("[.,;:]\\s*$", "", title)
  }

  slides[[length(slides) + 1L]] <- list(title = title, notes = notes)
}

message("found ", length(slides), " notes blocks")

# --- format ----------------------------------------------------------------
out <- character()
for (i in seq_along(slides)) {
  s <- slides[[i]]
  b <- s$notes

  timing <- ""
  hit <- grep("^\\[~.*\\]$", trimws(b))
  if (length(hit)) {
    timing <- paste0(" — ", gsub("^\\[~|\\]$", "", trimws(b[hit[1]])))
    b <- b[-hit]
  }

  while (length(b) && !nzchar(trimws(b[1]))) b <- b[-1]
  while (length(b) && !nzchar(trimws(b[length(b)]))) b <- b[-length(b)]

  out <- c(out, sprintf("## %d · %s%s", i, s$title, timing), "", b, "", "---", "")
}
out <- head(out, -2)

# --- splice ----------------------------------------------------------------
cur <- readLines(notes_path, warn = FALSE, encoding = "UTF-8")
b_i <- which(trimws(cur) == BEGIN)
e_i <- which(trimws(cur) == END)

if (!length(b_i) || !length(e_i)) {
  stop("markers not found in ", notes_path,
       " — add ", BEGIN, " and ", END, " around the narration section.")
}

writeLines(c(cur[seq_len(b_i[1])], "", out, "", cur[e_i[1]:length(cur)]),
           notes_path)
message("wrote ", notes_path, " (", length(slides), " slides)")
