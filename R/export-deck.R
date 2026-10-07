# ---------------------------------------------------------------------------
# Export the rendered deck for handing to the organisers.
#
# Run after `quarto render`:
#   Rscript R/export-deck.R
#
# Writes to _output/handover/ (git-ignored, because every file there embeds the
# AIMS template assets):
#
#   fisher-rexchange-perth-2026.html  the deck itself, self-contained
#   fisher-rexchange-perth-2026.pdf   one page per click
#   fisher-rexchange-perth-2026.pptx  one full-slide picture per click, with the
#                                     speaker notes in PowerPoint's notes pane
#
# Why pictures in the PowerPoint: Quarto's own pptx writer cannot use the
# reveal.js theme, so its output had none of the AIMS styling on content slides
# and put the title-slide collage on slides of its own. Printing the rendered
# deck and placing each page as a picture gives a PowerPoint that looks exactly
# like the HTML and still offers presenter view with notes. The deck sets
# `pdf-separate-fragments`, so a slide built up over several clicks prints as
# one page per click, and in PowerPoint each click is a slide of its own. The
# cost is that slide text is not editable in PowerPoint; change content in
# talk/index.qmd and re-export.
#
# Needs Edge or Chrome (for printing), Quarto, `pdftools`, `xml2` and `officer`. The
# PowerPoint is built on Pandoc's default reference document, written out by
# Quarto at run time: it is 16:9 and has a complete notes master. The SETAC
# deck was tried first, for its AIMS theme, but its notes master is empty and
# officer then has nowhere to put the notes.
# ---------------------------------------------------------------------------

html     <- file.path("_output", "talk", "index.html")
qmd      <- file.path("talk", "index.qmd")
out_dir  <- file.path("_output", "handover")
stem     <- "fisher-rexchange-perth-2026"

stopifnot(file.exists(html), file.exists(qmd))
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
out <- function(ext) file.path(out_dir, paste0(stem, ".", ext))

# Absolute Windows path for the browser. The parent is resolved rather than the
# path itself: normalizePath() returns a not-yet-existing file's path unchanged,
# and a relative path is resolved against the browser's own working directory.
win_path <- function(p) {
  p <- file.path(normalizePath(dirname(p)), basename(p))
  if (.Platform$OS.type == "windows") {
    return(normalizePath(p, winslash = "\\", mustWork = FALSE))
  }
  system2("wslpath", c("-w", shQuote(p)), stdout = TRUE)
}

# --- 1. HTML -------------------------------------------------------------------
invisible(file.copy(html, out("html"), overwrite = TRUE))

# --- 2. PDF, printed by a headless browser -----------------------------------
# reveal.js lays the deck out one slide per page when the URL ends ?print-pdf.
# The browser gets its own profile directory: with a shared profile, a headless
# instance still running from an earlier call made the print come out blank.
browsers <- c("C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe",
              "C:/Program Files/Google/Chrome/Application/chrome.exe")
if (.Platform$OS.type != "windows") browsers <- sub("^C:", "/mnt/c", browsers)
browser <- browsers[file.exists(browsers)][1]
if (is.na(browser)) stop("Neither Edge nor Chrome was found.")

# system2() quotes `command` itself, so the browser path is passed bare even
# though it contains spaces; the arguments are quoted here.
print_pdf <- function(html, pdf) {
  profile <- file.path("_output", ".browser-profile")
  dir.create(profile, showWarnings = FALSE)
  on.exit(unlink(profile, recursive = TRUE), add = TRUE)
  url <- paste0("file:///", gsub("\\\\", "/", win_path(html)), "?print-pdf")
  unlink(pdf)
  system2(browser, c(
    "--headless=new", "--disable-gpu", "--no-pdf-header-footer",
    paste0("--user-data-dir=", shQuote(win_path(profile))),
    "--run-all-compositor-stages-before-draw", "--virtual-time-budget=60000",
    paste0("--print-to-pdf=", shQuote(win_path(pdf))),
    shQuote(url)
  ), stdout = FALSE, stderr = FALSE)
  if (!file.exists(pdf)) stop("The browser did not write a PDF.")
}
print_pdf(html, out("pdf"))

# --- 3. Speaker notes, read from the deck source -----------------------------
# The same parse as R/build-speaker-notes.R. It is repeated here rather than
# sourced because that file is a script that rewrites notes/speaker-notes.md
# when run.
read_slides <- function(path) {
  x <- readLines(path, warn = FALSE, encoding = "UTF-8")
  body <- x[(grep("^---\\s*$", x)[2] + 1):length(x)]
  blocks <- split(body, cumsum(grepl("^---\\s*$", body)))
  slides <- list()
  for (blk in blocks) {
    h <- grep("^##\\s+", blk, value = TRUE)
    start <- grep("^::: *\\{\\.notes\\}", blk)
    if (!length(h)) next
    notes <- character()
    if (length(start)) {
      depth <- 1L
      for (i in seq(start[1] + 1, length(blk))) {
        if (grepl("^::: *\\{", blk[i])) depth <- depth + 1L
        else if (grepl("^:::\\s*$", blk[i])) depth <- depth - 1L
        if (depth == 0L) break
        notes <- c(notes, blk[i])
      }
    }
    title <- sub("^##\\s+", "", h[1])
    title <- gsub("\\[([^]]*)\\]\\{[^}]*\\}", "\\1 ·", title)
    title <- trimws(gsub("\\{[^}]*\\}|[*`]", "", title))
    slides[[length(slides) + 1L]] <- list(title = title, notes = notes)
  }
  slides
}

# Paragraphs for the notes pane. Other stage directions are kept in square
# brackets, and the timing marker is spelt out.
note_paragraphs <- function(lines) {
  lines <- sub("^>\\s?(.*)$", "[\\1]", lines)
  lines <- sub("^\\[~(\\d+) s\\]$", "(about \\1 seconds)", lines)
  lines <- gsub("[*`]", "", lines)
  # a stage direction that wraps onto two `> ` lines becomes "[a] [b]"
  paras <- split(lines, cumsum(!nzchar(trimws(lines))))
  paras <- vapply(paras, function(p) paste(trimws(p[nzchar(trimws(p))]),
                                           collapse = " "), "")
  paras <- gsub("\\] \\[", " ", paras)
  paras[nzchar(paras)]
}

# Notes for each printed page of a slide. Each "> Click" direction starts the
# next page, so a page shows only what is said at that click; the timing goes on
# the slide's first page.
page_notes <- function(lines, n_pages) {
  click <- grepl("^>\\s*Click", lines)
  if (sum(click) != n_pages - 1L) return(NULL)
  segs <- split(lines[!click], cumsum(click)[!click])
  segs <- lapply(as.character(seq_len(n_pages) - 1L),
                 function(k) if (is.null(segs[[k]])) character() else segs[[k]])
  timing <- grepl("^\\[~\\d+ s\\]$", lines)
  segs <- lapply(segs, function(x) x[!grepl("^\\[~\\d+ s\\]$", x)])
  segs[[1]] <- c(lines[timing], "", segs[[1]])
  lapply(segs, note_paragraphs)
}

# Clicks per slide, counted in the rendered HTML the way reveal.js groups them:
# fragments that share a data-fragment-index appear together, and every other
# fragment is a click of its own. A slide prints as one page plus one per click.
count_clicks <- function(html) {
  doc <- xml2::read_html(html)
  has_class <- function(cls) {
    sprintf("contains(concat(' ', normalize-space(@class), ' '), ' %s ')", cls)
  }
  secs <- xml2::xml_find_all(doc, sprintf("//section[%s]", has_class("slide")))
  vapply(secs, function(sec) {
    idx <- xml2::xml_attr(
      xml2::xml_find_all(sec, sprintf(".//*[%s]", has_class("fragment"))),
      "data-fragment-index")
    length(unique(idx[!is.na(idx)])) + sum(is.na(idx))
  }, integer(1))
}

slides <- read_slides(qmd)
clicks <- count_clicks(html)
if (length(clicks) != length(slides)) {
  stop("The HTML has ", length(clicks), " slides but talk/index.qmd has ",
       length(slides), ".")
}
pages_per_slide <- clicks + 1L
n_pages <- pdftools::pdf_info(out("pdf"))$pages
if (n_pages != sum(pages_per_slide)) {
  stop("The PDF has ", n_pages, " pages but the deck has ",
       sum(pages_per_slide), " slides and clicks.")
}
notes_by_page <- unlist(lapply(seq_along(slides), function(i) {
  pn <- page_notes(slides[[i]]$notes, pages_per_slide[i])
  if (is.null(pn)) {
    stop("Slide '", slides[[i]]$title, "' has ", clicks[i],
         " clicks but its notes have a different number of '> Click' lines.")
  }
  pn
}), recursive = FALSE)
title_by_page <- rep(vapply(slides, `[[`, "", "title"), pages_per_slide)

# --- 4. PowerPoint -------------------------------------------------------------
quartos <- c("C:/Program Files/Positron/resources/app/quarto/bin/quarto.exe",
             Sys.which("quarto"))
if (.Platform$OS.type != "windows") quartos[1] <- sub("^C:", "/mnt/c", quartos[1])
quarto <- quartos[nzchar(quartos) & file.exists(quartos)][1]
if (is.na(quarto)) stop("Quarto was not found.")

base <- file.path(out_dir, ".reference.pptx")
base_arg <- if (grepl("\\.exe$", quarto)) win_path(base) else base
system2(quarto, c("pandoc", "-o", shQuote(base_arg),
                  "--print-default-data-file", "reference.pptx"),
        stdout = FALSE, stderr = FALSE)
if (!file.exists(base)) stop("Quarto did not write the reference document.")

# 1920 px wide: one image pixel per projector pixel at 1080p.
page_w_in <- pdftools::pdf_pagesize(out("pdf"))$width[1] / 72
pngs <- pdftools::pdf_convert(out("pdf"), format = "png", dpi = 1920 / page_w_in,
                              filenames = file.path(tempdir(), "slide-%02d.%s"),
                              verbose = FALSE)

deck <- officer::read_pptx(base)
for (i in rev(seq_len(length(deck)))) deck <- officer::remove_slide(deck, i)
size <- officer::slide_size(deck)
unlink(base)

for (i in seq_len(n_pages)) {
  deck <- officer::add_slide(deck, layout = "Title Only",
                             master = "Office Theme")
  # The title goes in first and the picture over it: the title is hidden in
  # the slide show but names the slide in PowerPoint's outline and in screen
  # readers.
  deck <- officer::ph_with(deck, title_by_page[i],
                           location = officer::ph_location_type("title"))
  deck <- officer::ph_with(
    deck, officer::external_img(pngs[i], width = size$width,
                                height = size$height),
    location = officer::ph_location(left = 0, top = 0, width = size$width,
                                    height = size$height)
  )
  paras <- notes_by_page[[i]]
  if (length(paras)) {
    notes <- do.call(officer::block_list,
                     lapply(paras, function(p) officer::fpar(officer::ftext(p))))
    deck <- officer::set_notes(deck, notes,
                               location = officer::notes_location_type("body"))
  }
}
print(deck, target = out("pptx"))
unlink(pngs)

message("wrote to ", normalizePath(out_dir), ":\n  ",
        paste(basename(list.files(out_dir, paste0("^", stem))), collapse = "\n  "))
