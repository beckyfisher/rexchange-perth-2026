# ---------------------------------------------------------------------------
# Crop the published dredging figures used in the talk into talk/external/.
#
#   & "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/external-figures.R
#
# Both source reports are WAMSI Dredging Science Node publications released
# under CC BY 3.0 AU ("unless otherwise noted"), and neither figure carries a
# separate credit. The crops are therefore committed, with attribution in
# talk/external/README.md and on the slide. The PDFs themselves are not: they
# sit in the git-ignored Relevant_publication_history_pdfs/, so this script runs
# only on the author's machine. Re-run it only if a crop box changes.
#
# Crop boxes are pixel geometries at 300 dpi, read off the rendered pages. Each
# rough box is then trimmed to the figure's own extent, so a box that is a few
# pixels generous does not leave a margin of page behind.
# ---------------------------------------------------------------------------

pdf_dir <- file.path("Relevant_publication_history_pdfs", "dredging_reports")
out_dir <- file.path("talk", "external")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

dpi <- 300

render_page <- function(file, page) {
  bmp <- pdftools::pdf_render_page(file.path(pdf_dir, file), page = page,
                                   dpi = dpi, numeric = FALSE)
  magick::image_read(bmp) |> magick::image_background("white") |>
    magick::image_flatten()
}

crop_trim <- function(img, geometry) {
  magick::image_crop(img, geometry) |>
    magick::image_trim(fuzz = 8) |>
    magick::image_border("white", "24x24")
}

# --- Fisher, Jones & Bessell-Browne (2019), Project 4.9.4, Figure 6 ----------
# One massive Porites colony photographed through the 534 days of dredging at
# Barrow Island, under the turbidity record for the same period. Used as
# published, without the caption.
t49 <- render_page("Fisher_etal2019_WAMSI_DSN_Theme4.9_FINAL.pdf", 107)

porites <- crop_trim(t49, "1700x2470+400+255")
# Photographs, so JPEG: as PNG this one crop was 4 MB, and embed-resources
# inlines every image into the single HTML file.
magick::image_write(porites, file.path(out_dir, "porites-time-sequence.jpg"),
                    format = "jpeg", quality = 85)

# Top row only (days 1, 130 and 263), for the title slide.
porites_row <- crop_trim(t49, "1545x510+476+655")
magick::image_write(porites_row, file.path(out_dir, "porites-strip.jpg"),
                    format = "jpeg", quality = 85)

# --- Jones et al. (2019), Theme 4 Synthesis Report, Figure 19 ---------------
# Panel A is the suspended sediment record ~200 m from the dredge; panel B is
# the running-mean hazard profile of two turbidity events against the possible
# and probable effect thresholds. In the report the panels are stacked, which
# leaves a figure too tall for a 16:9 slide, so they are placed side by side.
# That is an adaptation under the licence and the slide credit says so.
syn_file <- list.files(pdf_dir, "^Dredging-Science-Synthesis")
syn <- render_page(syn_file, 35)

panel_a <- crop_trim(syn, "1100x755+330+270")
panel_b <- crop_trim(syn, "1110x715+330+1030")

h <- max(magick::image_info(c(panel_a, panel_b))$height)
pad <- function(img) {
  magick::image_extent(img, sprintf("%dx%d", magick::image_info(img)$width, h),
                       gravity = "north", color = "white")
}
fig19 <- magick::image_append(c(pad(panel_a), pad(panel_b)))
magick::image_write(fig19, file.path(out_dir, "turbidity-thresholds.png"))

message("wrote ", paste(list.files(out_dir, "\\.(png|jpg)$"), collapse = ", "),
        " to ", normalizePath(out_dir))
