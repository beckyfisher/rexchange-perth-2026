# ---------------------------------------------------------------------------
# Extract pictures from the speaker's earlier slides into talk/local/:
#
#   old_talks_and_background/slides.pptx
#
#   Rscript R/local-images.R
#
# The source slides are the speaker's own: the blood-alcohol slide from the ANZG
# talk, the Barrow Island threshold sequence from the SETAC Darwin talk, and the
# white, grey and black literature slide from the AIMS 50th talk. The pictures
# on them are not all hers to relicense: stock photographs, journal covers, a
# web graphic of grey literature, the cover of the WA EPA guidance, and figures
# published in Fisher et al. (2018) J. Appl. Ecol. So, like talk/aims/, the
# folder is git-ignored and is filled only where the source deck is present.
# Anywhere else the script writes labelled grey placeholders of the same shape,
# using base graphics, so the deck still renders.
#
# Each picture is exported by PowerPoint (driven through PowerShell) rather than
# read from the archive, because most of them are groups: a plot with drawn
# arrows and labels, or photographs with traces drawn over them. Shape.Export()
# is a hidden but long-standing member of the PowerPoint object model, and it
# keeps transparency, which matters on the AIMS contour background.
# ---------------------------------------------------------------------------

src_pptx <- file.path("old_talks_and_background", "slides.pptx")
out_dir <- file.path("talk", "local")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# One row per picture. `shapes` names the shape on that slide; "A/B" is member
# B of group A, and "A+B" exports A and B grouped, so a white mask or label
# drawn over a plot stays in place. `w` and `h` are the size on the source slide
# in points, used only to give a placeholder the right shape.
# Since 2026-10-07 the deck uses neither the slide 1 pictures, nor the slide 2
# and 3 pictures, nor cr-triangle and epa-guidance. They are still exported,
# because they belong to the blood-alcohol slide and the five-slide dredging
# build in commit 1336127, and those can then be restored from the commit
# without changing this script.
manifest <- read.csv(text = "
slide,shapes,file,w,h
1,Group 25/Picture 8,breath-test.jpg,187,124
1,Group 25/Picture 16,police-hat.png,96,70
1,Group 25/Graphic 24,no-sign.png,147,147
1,Picture 12,outfall.jpg,187,125
2,Group 35,pressure-triangle.png,388,343
2,Picture 54,wq-strip.png,874,82
3,Group 15+Group 29+Rectangle 28+TextBox 34,mortality-densities.png,910,175
3,Group 4,coral-strip.jpg,875,79
4,Picture 49,cr-curve.png,337,305
4,Isosceles Triangle 3,cr-triangle.png,864,120
6,Group 37+Rectangle 38,roc.png,449,377
7,*,management-zones.png,590,500
7,Group 4,epa-guidance.png,286,281
8,Picture 7,white-literature.jpg,196,110
8,Picture 10,grey-literature.png,220,110
8,Group 44/Picture 15,confidential.png,238,119
8,Group 44/Graphic 41,black-box.png,99,99
", strip.white = TRUE)

# On slide 7 everything is exported together except the title, the contour
# decoration and the guidance cover, which the deck places separately.
slide7_exclude <- c("Title 1", "Picture 97", "Group 4")

write_placeholders <- function(why) {
  message(why, "; writing placeholders to ", out_dir)
  for (i in seq_len(nrow(manifest))) {
    f <- manifest$file[i]
    dev <- if (grepl("\\.jpg$", f)) grDevices::jpeg else grDevices::png
    dev(file.path(out_dir, f), width = manifest$w[i] * 4,
        height = manifest$h[i] * 4)
    op <- graphics::par(mar = c(0, 0, 0, 0))
    graphics::plot.new()
    graphics::rect(0, 0, 1, 1, col = "grey88", border = NA)
    graphics::text(0.5, 0.5, sub("\\.(png|jpg)$", "", f),
                   cex = max(1, min(manifest$w[i], manifest$h[i]) / 40),
                   col = "grey45")
    graphics::par(op)
    grDevices::dev.off()
  }
}

ps <- Sys.which(c("powershell.exe", "powershell"))
ps <- ps[nzchar(ps)]
if (!file.exists(src_pptx)) {
  write_placeholders("source deck not found")
  quit(save = "no")
}
if (!length(ps)) {
  write_placeholders("PowerShell not found")
  quit(save = "no")
}

win_path <- function(p) {
  p <- file.path(normalizePath(dirname(p)), basename(p))
  if (.Platform$OS.type == "windows") {
    return(normalizePath(p, winslash = "\\", mustWork = FALSE))
  }
  system2("wslpath", c("-w", shQuote(p)), stdout = TRUE)
}

# --- PowerShell: export each picture as PNG ---------------------------------
# PNG first for everything, so transparency survives; photographs are converted
# to JPEG afterwards, because embed-resources inlines every image into the one
# HTML file. The export size passed is the slide at 2400 x 1350, about two image
# pixels per slide pixel at 1600 x 900. Grouping changes the open copy only: the
# deck is opened read-only and closed without saving.

tmp_dir <- file.path(out_dir, ".export")
dir.create(tmp_dir, showWarnings = FALSE)
script <- file.path(out_dir, ".export-pictures.ps1")
# on.exit() does nothing at the top level of an Rscript, so the temporary files
# are removed explicitly on each way out.
clean_up <- function() unlink(c(script, tmp_dir), recursive = TRUE)

ps_shape <- function(slide, spec) {
  s <- sprintf("$p.Slides.Item(%d)", slide)
  if (spec == "*") {
    excl <- paste0("'", slide7_exclude, "'", collapse = ",")
    return(sprintf(paste0(
      "$names = @(foreach ($x in %s.Shapes) { if (@(%s) -notcontains $x.Name) { $x.Name } }); ",
      "$sh = %s.Shapes.Range([object[]]$names).Group()"), s, excl, s))
  }
  if (grepl("+", spec, fixed = TRUE)) {
    parts <- paste0("'", strsplit(spec, "+", fixed = TRUE)[[1]], "'", collapse = ",")
    return(sprintf("$sh = %s.Shapes.Range([object[]]@(%s)).Group()", s, parts))
  }
  if (grepl("/", spec, fixed = TRUE)) {
    parts <- strsplit(spec, "/", fixed = TRUE)[[1]]
    return(sprintf("$sh = %s.Shapes.Item('%s').GroupItems.Item('%s')", s,
                   parts[1], parts[2]))
  }
  sprintf("$sh = %s.Shapes.Item('%s')", s, spec)
}

png_name <- function(f) sub("\\.jpg$", ".png", f)
lines <- c(
  "$ErrorActionPreference = 'Stop'",
  "$pp = New-Object -ComObject PowerPoint.Application",
  sprintf("$p = $pp.Presentations.Open('%s', $true, $false, $false)",
          win_path(src_pptx)),
  "try {",
  unlist(lapply(seq_len(nrow(manifest)), function(i) c(
    ps_shape(manifest$slide[i], manifest$shapes[i]),
    sprintf("$sh.Export('%s', 2, 2400, 1350, 1)",
            win_path(file.path(tmp_dir, png_name(manifest$file[i]))))
  ))),
  "} finally {",
  "  $p.Close()",
  # PowerPoint may already be open with the speaker's own decks: quit only if
  # this script was its only user.
  "  if ($pp.Presentations.Count -eq 0) { $pp.Quit() }",
  "}"
)
writeLines(lines, script)
status <- system2(ps[[1]], c("-NoProfile", "-ExecutionPolicy", "Bypass",
                             "-File", shQuote(win_path(script))))
exported <- file.exists(file.path(tmp_dir, png_name(manifest$file)))
if (!identical(status, 0L) || !all(exported)) {
  warning("PowerPoint export failed for: ",
          paste(manifest$file[!exported], collapse = ", "))
  clean_up()
  write_placeholders("export incomplete")
  quit(save = "no")
}

# --- write the deck's copies -------------------------------------------------
# On slide 3 a white rectangle masks a panel label in the source figure. On the
# white source slide it was invisible; on the AIMS contour background it shows
# as a white box, so white is made transparent in that one picture.
clear_white <- "mortality-densities.png"

for (f in manifest$file) {
  img <- magick::image_read(file.path(tmp_dir, png_name(f)))
  if (f %in% clear_white) img <- magick::image_transparent(img, "white", fuzz = 3)
  if (grepl("\\.jpg$", f)) {
    img |>
      magick::image_background("white") |>
      magick::image_flatten() |>
      magick::image_write(file.path(out_dir, f), format = "jpeg", quality = 88)
  } else {
    magick::image_write(img, file.path(out_dir, f), format = "png")
  }
}

clean_up()
message("wrote ", paste(manifest$file, collapse = ", "), " to ",
        normalizePath(out_dir))
