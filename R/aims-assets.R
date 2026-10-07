# ---------------------------------------------------------------------------
# Extract the AIMS presentation-template assets used by the deck into
# talk/aims/, from the speaker's SETAC Asia-Pacific deck:
#
#   old_talks_and_background/SETAC AP Produced water_WET.pptx
#
#   & "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/aims-assets.R
#
# These assets belong to AIMS, not to the author: the Commonwealth Coat of Arms
# and AIMS logo on the title background, AIMS photographs, and staff portraits
# on the team slide. The repository is licensed CC BY 4.0 and is intended to be
# made public, so neither the source deck nor talk/aims/ is committed.
#
# Where the source deck is absent (CI, or anyone else's clone) the script writes
# plain placeholders instead, using base graphics only, so the deck still
# renders. The public build then shows a labelled grey panel in place of the two
# AIMS introduction slides.
#
# Exporting the team slide as an image needs PowerPoint, driven through
# PowerShell; it works from Windows R and from WSL R on a machine with Office.
# Everything else is read straight out of the .pptx archive.
# ---------------------------------------------------------------------------

src_pptx <- file.path("old_talks_and_background",
                      "SETAC AP Produced water_WET.pptx")
out_dir <- file.path("talk", "aims")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

aims_blue <- "#005B9E"

# --- placeholders (no source deck) -----------------------------------------

placeholder <- function(file, label, fill = "grey88", panel = FALSE,
                        width = 1920, height = 1080) {
  dev <- if (grepl("\\.jpe?g$", file)) grDevices::jpeg else grDevices::png
  dev(file.path(out_dir, file), width = width, height = height)
  op <- graphics::par(mar = c(0, 0, 0, 0))
  graphics::plot.new()
  graphics::rect(0, 0, 1, 1, col = fill, border = NA)
  if (panel) graphics::rect(0, 0, 0.336, 1, col = aims_blue, border = NA)
  if (nzchar(label)) graphics::text(0.5, 0.5, label, cex = 3, col = "grey40")
  graphics::par(op)
  grDevices::dev.off()
}

if (!file.exists(src_pptx)) {
  message("source deck not found; writing placeholders to ", out_dir)
  placeholder("title-background.jpg", "", fill = "white", panel = TRUE)
  placeholder("content-background.jpg", "", fill = "white")
  placeholder("aims-intro.jpg", "AIMS introduction slide (not in the public build)")
  placeholder("aims-team.jpg", "AIMS team slide (not in the public build)")
  placeholder("dredge-photo.jpg", "photograph", width = 1600, height = 1200)
  quit(save = "no")
}

# --- real assets -------------------------------------------------------------

unpacked <- file.path(tempdir(), "aims-template")
utils::unzip(src_pptx, exdir = unpacked)
media <- function(f) file.path(unpacked, "ppt", "media", f)

# Title-slide background: the "Front Cover" master, which already carries the
# blue panel, both logos, the contour linework and the tagline bar.
invisible(file.copy(media("image1.jpg"),
                    file.path(out_dir, "title-background.jpg"),
                    overwrite = TRUE))

# Content background: in PowerPoint this is two layers, the master's blue strip
# (image3.png, transparent elsewhere) over the layout's contour lines
# (image5.jpg). A reveal.js slide takes one background image, so they are
# flattened here.
contours <- magick::image_read(media("image5.jpg")) |>
  magick::image_scale("3000x1689!")
strip <- magick::image_read(media("image3.png"))
magick::image_flatten(c(contours, strip)) |>
  magick::image_scale("1920x1080!") |>
  magick::image_write(file.path(out_dir, "content-background.jpg"),
                      format = "jpeg", quality = 90)

# Slide 2 of the source deck is a single full-slide picture, so it is read
# rather than rendered. JPEG throughout for photographs: embed-resources
# inlines every image into the one HTML file.
magick::image_read(media("image26.png")) |>
  magick::image_write(file.path(out_dir, "aims-intro.jpg"), format = "jpeg",
                      quality = 90)

# The dredging photograph from the team slide, downsized for the title slide.
magick::image_read(media("image38.jpeg")) |>
  magick::image_scale("1600") |>
  magick::image_write(file.path(out_dir, "dredge-photo.jpg"), format = "jpeg",
                      quality = 88)

# Slide 3 is built from some forty shapes, so it is rendered by PowerPoint.
# The commands go through a script file rather than -Command because quoting a
# PowerShell one-liner through system2() differs between Windows and WSL.
win_path <- function(p) {
  p <- normalizePath(p, mustWork = FALSE)
  if (.Platform$OS.type == "windows") {
    return(normalizePath(p, winslash = "\\", mustWork = FALSE))
  }
  system2("wslpath", c("-w", shQuote(p)), stdout = TRUE)
}

export_slide <- function(slide, out, width = 2400, height = 1350) {
  ps <- Sys.which(c("powershell.exe", "powershell"))
  ps <- ps[nzchar(ps)]
  if (!length(ps)) return(FALSE)
  out_abs <- file.path(normalizePath(out_dir), out)
  script <- file.path(out_dir, ".export-slide.ps1")
  on.exit(unlink(script), add = TRUE)
  writeLines(c(
    "$pp = New-Object -ComObject PowerPoint.Application",
    sprintf("$p = $pp.Presentations.Open('%s', $true, $false, $false)",
            win_path(src_pptx)),
    sprintf("$p.Slides.Item(%d).Export('%s', 'JPG', %d, %d)",
            slide, win_path(out_abs), width, height),
    "$p.Close()",
    "$pp.Quit()"
  ), script)
  status <- system2(ps[[1]], c("-NoProfile", "-ExecutionPolicy", "Bypass",
                               "-File", shQuote(win_path(script))),
                    stdout = FALSE, stderr = FALSE)
  identical(status, 0L) && file.exists(out_abs)
}

if (!export_slide(3, "aims-team.jpg")) {
  warning("PowerPoint export failed; writing a placeholder for the team slide")
  placeholder("aims-team.jpg", "AIMS team slide (PowerPoint export failed)")
}

unlink(unpacked, recursive = TRUE)
message("wrote ", paste(list.files(out_dir), collapse = ", "), " to ",
        normalizePath(out_dir))
