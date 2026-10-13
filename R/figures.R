# ---------------------------------------------------------------------------
# Figures for the R Exchange Perth 2026 talk.
#
# Run from the repo root:
#   & "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/figures.R
#
# Writes .png to talk/figures/. Nothing here reads confidential data: the SSD
# figure uses the CCME boron dataset shipped with {ssddata}, and everything else
# is either schematic or drawn from the published record (see
# notes/source-synthesis.md).
#
# Figures are built here rather than in executable chunks inside index.qmd so the
# deck can be re-rendered on a machine with Quarto but without ssdtools/brms.
# ---------------------------------------------------------------------------

set.seed(42)

library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)
library(scales)
library(patchwork)
library(ssdtools)

fig_dir <- file.path("talk", "figures")
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)

# --- shared look ------------------------------------------------------------
# Deliberately close to the visual language of the speaker's existing decks:
# almost no chrome, one idea per panel, annotation carrying the argument.

# The three eras are about *distribution* and map onto the y-axis of the timeline:
# scripts on a disk -> a public repo -> CRAN. AI is deliberately NOT an era: it is
# Part two of the talk, and it gets its own colour so the two framings don't
# collide on the same chart.
pal <- c(
  era1   = "#9E9E9E",  # era 1: scripts, not software
  era2   = "#1B7F79",  # era 2: GitHub (AIMS teal)
  era3   = "#0F5257",  # era 3: CRAN (deeper teal — further along the same road)
  hi     = "#E4572E",  # highlight / AI accent, used for "look here"
  accent = "#005B9E",  # AIMS blue, matching the slide headings in custom.scss
  light  = "#C9D6DF"
)

theme_talk <- function(base_size = 15) {
  theme_minimal(base_size = base_size) +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(colour = "grey92"),
      plot.title = element_text(face = "bold", size = rel(1.05)),
      plot.subtitle = element_text(colour = "grey35", size = rel(0.85)),
      plot.caption = element_text(colour = "grey55", size = rel(0.7), hjust = 0),
      axis.title = element_text(colour = "grey35", size = rel(0.85)),
      legend.position = "none",
      plot.margin = margin(10, 14, 8, 10)
    )
}

save_fig <- function(plot, name, width = 10, height = 5.6, dpi = 200) {
  path <- file.path(fig_dir, name)
  ggsave(path, plot, width = width, height = height, dpi = dpi, bg = "white")
  message("wrote ", path)
}

# ===========================================================================
# 1. Code and regulation, 2010–2026
# ===========================================================================
# The y-axis is how the code was shared: who, other than the author, could run
# it. Regulatory use is marked separately, because the two do not line up. An
# earlier version stacked "named in regulation" above CRAN on one axis, as if
# regulation were the next step after CRAN. It is not: regulators use results
# and do not ask where the code lives, and the dredging thresholds, whose code
# never left the author's computer, are used in WA dredging guidance.

shared_levels <- c("My own computer", "Zip file", "GitHub", "CRAN")

# `hj` staggers labels left or right so points one year apart never overplot.
# The 2021 CRAN date is verified: ssddata 1.0.0 was published to CRAN on
# 2021-11-05, and bayesnec's CRAN-review commits run from June to October 2021.
# The other years are reconstructed from the CV.
code <- tribble(
  ~year, ~artefact,              ~shared,           ~era,   ~hj, ~vj,  ~note,
  2010,  "CReefs scripts",       "My own computer", "era1", 0.5, -1.2, "57 R and Tcl/Tk scripts",
  2012,  "ElicitN",              "Zip file",        "era1", 0.5, -1.2, "on SourceForge",
  2018,  "Dredging thresholds",  "My own computer", "era2", 0.5, -1.2, "",
  2018,  "FSSgam",               "GitHub",          "era2", 1.0, -1.2, "",
  2019,  "epower",               "GitHub",          "era2", 0.0, -1.2, "",
  2021,  "bayesnec, ssddata",    "CRAN",            "era3", 1.0, -1.2, "",
  2024,  "ssdtools",             "CRAN",            "era3", 0.5, -1.2, "",
  2025,  "ssdtools v2",          "CRAN",            "era3", 0.0, -1.2, ""
) |>
  mutate(
    shared = factor(shared, levels = shared_levels),
    nx     = case_when(hj == 1 ~ -0.2, hj == 0 ~ 0.2, TRUE ~ 0)
  )

regulation <- tribble(
  ~year, ~shared,           ~label,                                              ~hj,
  2018,  "My own computer", "used in WA dredging guidance",                      0.5,
  # Three lines, so the label is narrow enough to clear "epower" on its left
  # and the AI marker on its right.
  2024,  "CRAN",            "default software for\nguideline values: Australia,\nNew Zealand, Canada", 0.57
) |>
  mutate(shared = factor(shared, levels = shared_levels))

# The era bands and their labels are a layer of their own. The speaker asked on
# 2026-10-13 for them to appear on a click after the regulatory marks, as the
# step into the three eras, so the first two versions of the plot leave them out.
era_bands <- function() {
  list(
    annotate("rect", xmin = 2009, xmax = 2015.5, ymin = 0.4, ymax = 4.75,
             fill = pal[["era1"]], alpha = 0.07),
    annotate("rect", xmin = 2015.5, xmax = 2020.6, ymin = 0.4, ymax = 4.75,
             fill = pal[["era2"]], alpha = 0.07),
    annotate("rect", xmin = 2020.6, xmax = 2027.9, ymin = 0.4, ymax = 4.75,
             fill = pal[["era3"]], alpha = 0.07),
    annotate("text", x = 2012.25, y = 4.62, label = "1. scripts",
             colour = pal[["era1"]], fontface = "bold", size = 4.4),
    annotate("text", x = 2018.05, y = 4.62, label = "2. GitHub",
             colour = pal[["era2"]], fontface = "bold", size = 4.4),
    annotate("text", x = 2022.6, y = 4.62, label = "3. CRAN",
             colour = pal[["era3"]], fontface = "bold", size = 4.4)
  )
}

timeline_base <- function(eras = FALSE) {
  ggplot(code, aes(year, as.numeric(shared))) +
    (if (eras) era_bands()) +
    # AI is the second part of the talk, not a fourth era: a marker, not a band
    annotate("segment", x = 2026.47, xend = 2026.47, y = 0.4, yend = 4.75,
             colour = pal[["hi"]], linetype = "22", linewidth = 0.6) +
    annotate("text", x = 2026.62, y = 2.0, label = "AI\nJune\n2026", hjust = 0,
             colour = pal[["hi"]], fontface = "bold", size = 3.7,
             lineheight = 0.9) +
    geom_point(aes(colour = era), size = 5) +
    geom_text(aes(x = year + nx, label = artefact, hjust = hj, vjust = vj),
              size = 4.6, fontface = "bold", colour = pal[["accent"]]) +
    geom_text(aes(x = year + nx, label = note, hjust = hj),
              vjust = 2.5, size = 3.4, colour = "grey45") +
    scale_colour_manual(values = pal) +
    scale_y_continuous(breaks = seq_along(shared_levels),
                       labels = shared_levels, limits = c(0.4, 4.75)) +
    scale_x_continuous(breaks = seq(2010, 2026, 2), limits = c(2009, 2027.9)) +
    labs(x = NULL, y = NULL, title = "How the code was shared") +
    theme_talk(base_size = 16) +
    theme(panel.grid.major.x = element_blank(),
          plot.title = element_text(colour = "grey35", face = "plain",
                                    size = rel(0.9)),
          axis.text.y = element_text(size = rel(1.05)))
}

regulation_marks <- function() {
  list(
    geom_point(data = regulation, aes(year, as.numeric(shared)),
               inherit.aes = FALSE, shape = 21, size = 11, stroke = 1.6,
               colour = pal[["hi"]], fill = NA),
    geom_text(data = regulation,
              aes(year, as.numeric(shared), label = label, hjust = hj),
              inherit.aes = FALSE, vjust = 1.9, nudge_y = -0.18, size = 3.9,
              fontface = "bold", colour = pal[["hi"]], lineheight = 0.95)
  )
}

# Three versions on the same canvas, so the slide can add the regulatory marks
# and then the eras with a click each, and nothing else on the plot shifts.
p_timeline <- timeline_base()
p_timeline_reg <- timeline_base() + regulation_marks()
p_timeline_eras <- timeline_base(eras = TRUE) + regulation_marks()

save_fig(p_timeline, "code-timeline.png", width = 10.5, height = 4.9)
save_fig(p_timeline_reg, "code-timeline-regulation.png", width = 10.5, height = 4.9)
save_fig(p_timeline_eras, "code-timeline-eras.png", width = 10.5, height = 4.9)

# ===========================================================================
# 2. The SSD: what the software actually computes
# ===========================================================================
# Real fit, real data, so the audience can see this is not a cartoon.

boron <- ssddata::ccme_boron
fits  <- ssd_fit_dists(boron, dists = ssd_dists_bcanz())
dists <- names(fits)
n_dist <- length(dists)

hc5     <- ssd_hc(fits, proportion = 0.05, ci = FALSE)
pred_ma <- as.data.frame(predict(fits, ci = FALSE))       # model average

# Individual distributions, so the audience can see the fan of defensible answers.
pred_each <- lapply(dists, function(d) {
  as.data.frame(predict(ssd_fit_dists(boron, dists = d), ci = FALSE))
}) |> bind_rows()

# ssd_ecd_data() returns the plotting position for each row in its original
# order, so do not sort first.
pts <- boron |> mutate(prop = ssd_ecd_data(boron))

# PC95 from each single-distribution fit, for the build-up below and for the
# figure in 2b.
hc_each <- lapply(dists, function(d) {
  f <- ssd_fit_dists(boron, dists = d)
  tibble(dist = d, hc5 = ssd_hc(f, proportion = 0.05, ci = FALSE)$est)
}) |>
  bind_rows() |>
  bind_rows(tibble(dist = "model average", hc5 = hc5$est)) |>
  mutate(
    is_ma = dist == "model average",
    dist  = forcats::fct_reorder(dist, hc5)
  )

# --- 2a. the SSD, built up in five steps ------------------------------------
# One figure per click, on identical axes and canvas, so that stepping through
# them on the slide reads as one plot gaining layers. That is how the speaker's
# ANZG deck teaches the SSD. The first single fit shown is the log-normal. Not
# used by the deck since 2026-10-07; see 2c.

one_dist <- "lnorm"
pred_one <- pred_each |> filter(dist == one_dist)
hc_one   <- hc_each$hc5[hc_each$dist == one_dist]
hc_range <- range(hc_each$hc5[!hc_each$is_ma])
x_lim    <- c(min(pred_each$est) * 0.8, max(pred_each$est))

pc95_mark <- function(x, label, colour = pal[["hi"]]) {
  list(
    # -Inf would be log(-Inf) = NaN on a log10 axis and the segment would be
    # dropped, so the guide lines start at the left limit instead.
    annotate("segment", x = x_lim[1], xend = x, y = 0.05, yend = 0.05,
             colour = colour, linetype = "22", linewidth = 0.8),
    annotate("segment", x = x, xend = x, y = 0, yend = 0.05,
             colour = colour, linetype = "22", linewidth = 0.8),
    annotate("point", x = x, y = 0.05, size = 4.4, colour = colour),
    annotate("text", x = x_lim[1] * 1.1, y = 0.14, label = label,
             colour = colour, size = 5.4, fontface = "bold", hjust = 0,
             vjust = 0, lineheight = 0.95)
  )
}

ssd_canvas <- function(...) {
  ggplot() +
    list(...) +
    geom_point(data = pts, aes(Conc, prop), size = 3, colour = "grey25") +
    scale_x_log10(labels = comma_signif, limits = x_lim) +
    scale_y_continuous(labels = percent, limits = c(0, 1)) +
    labs(x = "Concentration (mg/L)", y = "Proportion of species affected",
         caption = "CCME boron data, shipped with {ssddata}.") +
    theme_talk(base_size = 17)
}

ssd_steps <- list(
  ssd_canvas(),
  ssd_canvas(
    geom_line(data = pred_one, aes(est, proportion), colour = pal[["accent"]],
              linewidth = 1.5)
  ),
  ssd_canvas(
    geom_line(data = pred_one, aes(est, proportion), colour = pal[["accent"]],
              linewidth = 1.5),
    pc95_mark(hc_one, paste0("PC95 = ", signif(hc_one, 3), " mg/L"))
  ),
  ssd_canvas(
    geom_line(data = pred_each, aes(est, proportion, group = dist),
              colour = pal[["accent"]], linewidth = 0.8, alpha = 0.6),
    annotate("segment", x = hc_range[1], xend = hc_range[2], y = 0.05,
             yend = 0.05, colour = pal[["hi"]], linewidth = 2.2),
    annotate("text", x = x_lim[1] * 1.1, y = 0.14,
             label = paste0("PC95 from ", signif(hc_range[1], 3), "\nto ",
                            signif(hc_range[2], 3), " mg/L"),
             colour = pal[["hi"]], size = 5.4, fontface = "bold", hjust = 0,
             vjust = 0, lineheight = 0.95)
  ),
  ssd_canvas(
    geom_line(data = pred_each, aes(est, proportion, group = dist),
              colour = pal[["light"]], linewidth = 0.8),
    geom_line(data = pred_ma, aes(est, proportion), colour = pal[["accent"]],
              linewidth = 1.7),
    pc95_mark(hc5$est, paste0("PC95 = ", signif(hc5$est, 3), " mg/L\n(model average)"))
  )
)

for (i in seq_along(ssd_steps)) {
  save_fig(ssd_steps[[i]], sprintf("ssd-step-%d.png", i), width = 9, height = 5.6)
}

# --- 2c. the SSD on one slide ------------------------------------------------
# Points, every candidate distribution and the model average in one figure. The
# deck uses this one: on 2026-10-07 the speaker judged the step-by-step build in
# 2a too much animation and went back to this single slide. The steps are still
# written so that the build in commit 1336127 can be restored without changing
# this script.

p_ssd <- ggplot() +
  geom_line(data = pred_each, aes(est, proportion, group = dist),
            colour = pal[["light"]], linewidth = 0.7) +
  geom_line(data = pred_ma, aes(est, proportion),
            colour = pal[["accent"]], linewidth = 1.5) +
  geom_point(data = pts, aes(Conc, prop), size = 2.6, colour = "grey25") +
  # -Inf would be log(-Inf) = NaN on a log10 axis and the segment would be dropped,
  # so anchor the guide lines to finite values just outside the data range.
  geom_segment(aes(x = min(pred_each$est) * 0.8, xend = hc5$est,
                   y = 0.05, yend = 0.05),
               colour = pal[["hi"]], linetype = "22", linewidth = 0.7) +
  geom_segment(aes(x = hc5$est, xend = hc5$est, y = 0, yend = 0.05),
               colour = pal[["hi"]], linetype = "22", linewidth = 0.7) +
  annotate("point", x = hc5$est, y = 0.05, size = 4, colour = pal[["hi"]]) +
  annotate("text", x = hc5$est * 0.75, y = 0.30,
           label = paste0("PC95 = ", signif(hc5$est, 3), " mg/L"),
           colour = pal[["hi"]], size = 4.6, fontface = "bold", hjust = 0.5) +
  annotate("text", x = 400, y = 0.35,
           label = paste0(n_dist, " candidate\ndistributions"),
           colour = "grey55", size = 3.8, hjust = 0.5, lineheight = 0.95) +
  scale_x_log10(labels = comma_signif) +
  scale_y_continuous(labels = percent, limits = c(0, 1)) +
  labs(x = "Concentration (mg/L)", y = "Proportion of species affected",
       title = "The species sensitivity distribution",
       subtitle = "Each point is the toxicity estimate for one species. The concentration\nread off the curve becomes the guideline value.",
       caption = "CCME boron data, shipped with {ssddata}. Thin lines are single-distribution fits\nover the BCANZ set; the bold line is the model average.") +
  theme_talk()

# Drawn for the right-hand column of its slide, beside the blood-alcohol text
# that the speaker restored on 2026-10-09. Saved at this width rather than
# shrinking the 10.5-inch version, so its labels keep their size on screen.
save_fig(p_ssd, "ssd-model-average.png", width = 8, height = 6.2)

# --- 2b. why model averaging: the same data, several answers ----------------
# This was the "which model do you fit?" backup slide, made concrete. The
# backup slides were removed from the deck on 2026-10-13, as there is no time
# for them; the figure is still built so the slide can be restored.

spread_x <- max(hc_each$hc5) / min(hc_each$hc5)

p_spread <- ggplot(hc_each, aes(hc5, dist, colour = is_ma)) +
  geom_segment(aes(x = 0, xend = hc5, yend = dist), linewidth = 0.5) +
  geom_point(size = 4.4) +
  geom_text(aes(label = signif(hc5, 3)), hjust = -0.45, size = 3.9,
            fontface = "bold", show.legend = FALSE) +
  scale_colour_manual(values = c(`FALSE` = pal[["light"]], `TRUE` = pal[["hi"]])) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.18))) +
  labs(x = "PC95 guideline value (mg/L)", y = NULL,
       title = paste0("PC95 from each of ", n_dist,
                      " distributions fitted to the same data"),
       subtitle = paste0("A ", round(spread_x, 1),
                         "-fold spread, with no theoretical basis for choosing one distribution \u2192 average over them, weighted by AICc."),
       caption = "CCME boron data. Each row is a single-distribution fit; the highlighted row is the AICc-weighted model average.") +
  theme_talk() +
  theme(panel.grid.major.y = element_blank())

save_fig(p_spread, "ssd-model-spread.png", width = 10.5, height = 6)

# ===========================================================================
# 3. Four ways to say "no effect" — schematic
# ===========================================================================
# Schematic, not a fit: the point is definitional, and a real bayesnec fit would
# add minutes to the build for no extra clarity.

# Deliberately gentle decay: the four estimates really are close together in a
# real assay, but at a steeper slope they overplot and the figure stops teaching.
conc <- seq(0, 40, length.out = 900)
nec  <- 3
top  <- 100
k    <- -log(0.9) / 2                 # 10% effect two units above the NEC
resp <- ifelse(conc <= nec, top, top * exp(-k * (conc - nec)))

cr <- tibble(conc, resp)
at_conc <- function(x) approx(conc, resp, x)$y

nsec <- nec + -log(0.95) / k          # first conc distinguishable from control
ec10 <- nec + -log(0.90) / k          # 10% effect
noec <- 12                            # a *tested* concentration, by definition

# Labels are fanned out along one row with leader lines: the four estimates sit
# almost on top of each other in concentration, which is precisely the point.
marks <- tribble(
  ~x,    ~label,  ~lab_x, ~col,
  nec,   "NEC",   13,     pal[["era2"]],
  nsec,  "NSEC",  20,     pal[["era2"]],
  ec10,  "EC10",  27,     pal[["hi"]],
  noec,  "NOEC",  34,     pal[["hi"]]
) |> mutate(y = at_conc(x), lab_y = 118)

p_cr <- ggplot(cr, aes(conc, resp)) +
  annotate("rect", xmin = 0, xmax = nec, ymin = -Inf, ymax = 104,
           fill = pal[["era2"]], alpha = 0.09) +
  annotate("text", x = nec / 2, y = 52, label = "no effect",
           colour = pal[["era2"]], size = 4.6, fontface = "bold", angle = 90) +
  geom_line(linewidth = 1.4, colour = pal[["accent"]]) +
  geom_segment(data = marks, aes(x = x, xend = lab_x, y = y, yend = lab_y - 5),
               inherit.aes = FALSE, colour = "grey65", linewidth = 0.4) +
  geom_point(data = marks, aes(x = x, y = y, colour = col),
             inherit.aes = FALSE, size = 4.2, show.legend = FALSE) +
  geom_label(data = marks, aes(x = lab_x, y = lab_y, label = label, colour = col),
             inherit.aes = FALSE, fontface = "bold", size = 5,
             fill = "white", linewidth = 0, show.legend = FALSE) +
  scale_colour_identity() +
  scale_y_continuous(limits = c(0, 126), breaks = c(0, 50, 100)) +
  scale_x_continuous(expand = expansion(mult = c(0.01, 0.04))) +
  labs(x = "Concentration", y = "Response (% of control)",
       title = "Estimates of \"no effect\"",
       subtitle = "Only the NEC estimates a concentration below which no effect is predicted.\nWhichever estimate is used becomes an input to the SSD.",
       caption = "Schematic. Definitions after Warne et al. 2015; NSEC after Fisher & Fox (2023) Environ. Toxicol. Chem. 42:2019.") +
  theme_talk()

save_fig(p_cr, "no-effect-estimates.png", width = 10.5, height = 5.8)

# ===========================================================================
# 4. Thresholds have error rates — the ROC argument
# ===========================================================================

x  <- seq(-4, 8, length.out = 600)
ctrl <- dnorm(x, 0, 1)
imp  <- dnorm(x, 2.0, 1.3)

dens <- bind_rows(
  tibble(x, d = ctrl, grp = "control"),
  tibble(x, d = imp,  grp = "impact")
)

t_power <- qnorm(0.05, 2.0, 1.3)   # 95% of impact sites exceed it -> high power
t_alarm <- qnorm(0.95, 0, 1)       # only 5% of control sites exceed it -> low alarm

p_dens <- ggplot(dens, aes(x, d, fill = grp, colour = grp)) +
  geom_area(position = "identity", alpha = 0.28, linewidth = 0.9) +
  geom_vline(xintercept = t_power, colour = pal[["era2"]], linewidth = 1) +
  geom_vline(xintercept = t_alarm, colour = pal[["hi"]], linewidth = 1) +
  annotate("text", x = t_power - 0.2, y = 0.46, label = "high power\n\u2192 mortality possible",
           colour = pal[["era2"]], size = 3.8, hjust = 1, fontface = "bold",
           lineheight = 0.95) +
  annotate("text", x = t_alarm + 0.2, y = 0.46, label = "low alarm rate\n\u2192 mortality probable",
           colour = pal[["hi"]], size = 3.8, hjust = 0, fontface = "bold",
           lineheight = 0.95) +
  annotate("text", x = -1.9, y = 0.18, label = "control", colour = "grey30", size = 4) +
  annotate("text", x = 4.6, y = 0.13, label = "impact", colour = pal[["accent"]], size = 4) +
  scale_fill_manual(values = c(control = "grey70", impact = pal[["accent"]])) +
  scale_colour_manual(values = c(control = "grey50", impact = pal[["accent"]])) +
  scale_y_continuous(limits = c(0, 0.52)) +
  labs(x = "Exposure metric", y = "Density",
       title = "A threshold is a decision, and decisions have error rates") +
  theme_talk()

roc <- tibble(
  fp = pnorm(x, 0, 1, lower.tail = FALSE),
  tp = pnorm(x, 2.0, 1.3, lower.tail = FALSE)
)

p_roc <- ggplot(roc, aes(fp, tp)) +
  geom_abline(slope = 1, intercept = 0, colour = "grey85", linetype = "22") +
  geom_line(linewidth = 1.3, colour = pal[["accent"]]) +
  geom_point(data = tibble(fp = pnorm(t_power, 0, 1, lower.tail = FALSE),
                           tp = 0.95),
             size = 4.4, colour = pal[["era2"]]) +
  geom_point(data = tibble(fp = 0.05,
                           tp = pnorm(t_alarm, 2.0, 1.3, lower.tail = FALSE)),
             size = 4.4, colour = pal[["hi"]]) +
  scale_x_continuous(labels = percent) +
  scale_y_continuous(labels = percent) +
  labs(x = "False positive rate  (type I error \u2192 financial loss to the developer)",
       y = "True positive rate  (1 \u2212 type II error)",
       title = "Pick the point that matches the decision",
       caption = "Schematic, after Fisher et al. (2018) J. Appl. Ecol. 55:415.") +
  theme_talk()

save_fig(p_dens + p_roc + plot_layout(widths = c(1.25, 1)),
         "roc-thresholds.png", width = 12.5, height = 5.6)

# ===========================================================================
# 5. Where the work actually goes \u2014 MEASURED, from the commit history
# ===========================================================================
# Derived by R/git-evidence.R from the public repos; see that script for the
# method and its limits. Earlier drafts of this talk used an invented chart
# here. It was directionally right and numerically wrong, which is exactly the
# failure mode the talk warns about, so it has been replaced with the data.

shares <- read.csv(file.path("data", "git-evidence-shares.csv"),
                   stringsAsFactors = FALSE)
facts <- read.csv(file.path("data", "git-evidence-facts.csv"),
                  stringsAsFactors = FALSE)
fact <- function(k) facts$value[facts$key == k]
# Working days come from R/git-evidence-days.R, added on 2026-10-13 so the figure
# shows how much changed as well as the shares; see that script for why it is
# separate from the July measurement.
work_days <- read.csv(file.path("data", "git-evidence-days.csv"),
                      stringsAsFactors = FALSE)

cat_levels <- c("Source code", "Documentation (generated)",
                "Documentation (written)", "Tests", "Packaging, CI, CRAN",
                "Other")

# Bar length is files changed on a working day rather than share, so the two
# bars differ in length (how much changed) and the segments still give the
# shares that the narration quotes. A side-by-side pair of panels, one of
# volume and one of shares, was the alternative; one bar per period says both
# with half the ink.
work <- shares |>
  left_join(select(work_days, era, working_days), by = "era") |>
  mutate(
    per_day = touches / working_days,
    # reversed so "Before" reads on top
    era = factor(era, levels = c("With an AI assistant", "Before")),
    category = factor(category, levels = cat_levels)
  )
work_totals <- work |>
  group_by(era) |>
  summarise(per_day = sum(per_day), .groups = "drop")
n_days <- setNames(work_days$working_days, work_days$era)

p_work <- ggplot(work, aes(per_day, era, fill = category)) +
  geom_col(width = 0.5, colour = "white", linewidth = 0.8) +
  # a share is labelled where its segment is wide enough to hold the label
  geom_text(aes(label = ifelse(per_day >= 2.5, paste0(round(share), "%"), "")),
            position = position_stack(vjust = 0.5),
            size = 4.2, colour = "white", fontface = "bold") +
  geom_text(data = work_totals,
            aes(per_day, era, label = paste(round(per_day), "a day")),
            inherit.aes = FALSE, hjust = 0, nudge_x = 0.8,
            size = 6.2, fontface = "bold", colour = pal[["accent"]]) +
  scale_fill_manual(values = c(
    "Source code"               = pal[["accent"]],
    "Documentation (generated)" = pal[["era2"]],
    "Documentation (written)"   = "#4C9A94",
    "Tests"                     = "#7FBDB8",
    "Packaging, CI, CRAN"       = "#A9D3CF",
    "Other"                     = "#B0B0B0"
  )) +
  scale_x_continuous(limits = c(0, 60), expand = expansion(mult = c(0, 0))) +
  labs(x = NULL, y = NULL,
       title = "Files changed on a working day, by what each file is for",
       subtitle = paste0(
         "Before 20 June 2026: ", n_days[["Before"]], " working days.  ",
         "With an AI assistant since: ", n_days[["With an AI assistant"]], "."),
       caption = paste0(
         "Measured, not estimated: every commit I authored across ",
         length(strsplit(fact("repos_analysed"), ";")[[1]]),
         " public repos (", fact("commits_total"), " commits).\n",
         "\u201cWith an AI assistant\u201d = the ", fact("commits_ai_trailer"),
         " commits carrying a Co-Authored-By: Claude trailer \u2014 a conservative floor.\n",
         "Unit: one file changed in one commit.  A working day has at least one commit.",
         "  Code: R/git-evidence.R, R/git-evidence-days.R")) +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE)) +
  theme_talk() +
  theme(panel.grid.major.y = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.text.y = element_text(face = "bold", colour = pal[["accent"]],
                                   size = rel(1.05)),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(size = rel(0.85)),
        legend.key.size = unit(0.9, "lines"),
        plot.caption = element_text(size = rel(0.66)))

# Sized smaller than the other full-slide figures so that, scaled up to the
# slide, the bar labels and legend are legible from the back of a room.
save_fig(p_work, "where-work-goes.png", width = 9.6, height = 4.9)

# ===========================================================================
# 6. Title-slide panel
# ===========================================================================
# The template's front cover has a collage of photographs and plots beside the
# title. At collage size a plot's title and caption are unreadable, so this is
# the boron SSD from section 2 with the text removed.

p_title_ssd <- ggplot() +
  geom_line(data = pred_each, aes(est, proportion, group = dist),
            colour = pal[["light"]], linewidth = 0.8) +
  geom_line(data = pred_ma, aes(est, proportion),
            colour = pal[["accent"]], linewidth = 1.6) +
  geom_point(data = pts, aes(Conc, prop), size = 2.4, colour = "grey25") +
  annotate("point", x = hc5$est, y = 0.05, size = 3.6, colour = pal[["hi"]]) +
  scale_x_log10(labels = comma_signif) +
  scale_y_continuous(labels = percent, limits = c(0, 1)) +
  labs(x = "Concentration (mg/L)", y = "Species affected") +
  theme_talk(base_size = 14)

save_fig(p_title_ssd, "title-ssd.png", width = 6, height = 4)

# ===========================================================================
# 7. Coral reef species richness, the result ElicitN was built for
# ===========================================================================
# Redrawn from the numbers published in Fisher et al. (2015) Current Biology
# 25:500, rather than reproduced: the published figure is Elsevier copyright.
# The paper shows each estimate as an elicited density; here each is its point
# estimate and 95% credible interval, which are the values the text reports.

reef <- tribble(
  ~part,                     ~est,   ~lo,    ~hi,
  "Named",                    70000,  60000,  90000,
  "Discovered but unnamed",  110000,  80000, 170000,
  "Undiscovered",            620000, 370000, 1140000,
  "Total",                   830000, 550000, 1330000
) |>
  mutate(part = factor(part, levels = rev(part)),
         total = part == "Total")

p_reef <- ggplot(reef, aes(est, part, colour = total)) +
  geom_segment(aes(x = lo, xend = hi, yend = part), linewidth = 2.2,
               alpha = 0.45) +
  geom_point(size = 5) +
  geom_text(aes(label = comma(est)), vjust = -1.1, size = 5,
            fontface = "bold", show.legend = FALSE) +
  scale_colour_manual(values = c(`FALSE` = pal[["era2"]], `TRUE` = pal[["accent"]])) +
  scale_x_continuous(labels = comma, limits = c(0, 1.4e6),
                     breaks = c(0, 5e5, 1e6)) +
  labs(x = "Species on coral reefs worldwide", y = NULL,
       caption = "Fisher et al. (2015) Curr. Biol. 25:500. Estimates and\n95% credible intervals from 62 taxonomists.") +
  theme_talk(base_size = 17) +
  theme(panel.grid.major.y = element_blank(),
        axis.text.y = element_text(colour = "grey25", size = rel(0.95)))

save_fig(p_reef, "reef-richness.png", width = 6.2, height = 4.1)

# ===========================================================================
# 8. Stop sign, drawn rather than borrowed
# ===========================================================================
# For the slide "Numbers in environmental regulation". The earlier decks used
# clip art here. A third-party image of unknown provenance is fine on a slide
# presented once and awkward in a public repository, so it is generated instead.

octagon <- function(r = 1) {
  a <- seq(pi / 8, 2 * pi + pi / 8, length.out = 9)
  data.frame(x = r * cos(a), y = r * sin(a))
}

# ggplot text `size` is millimetres of font height, so it does not scale with the
# figure: these values are tuned to the width/height passed to save_fig() below
# and need re-tuning if those change.
p_stop <- ggplot(octagon(), aes(x, y)) +
  geom_polygon(fill = "#C1272D", colour = "white", linewidth = 3) +
  annotate("text", x = 0, y = 0, label = "STOP", colour = "white",
           fontface = "bold", size = 13, family = "sans") +
  coord_equal(xlim = c(-1.08, 1.08), ylim = c(-1.08, 1.08)) +
  theme_void()

save_fig(p_stop, "stop-sign.png", width = 3, height = 3, dpi = 220)

# ===========================================================================
# 9. Separating a method from confidential data — schematic
# ===========================================================================
# For the last click of "Industry work and packages", where the speaker says
# that separating a method from confidential data well enough to release it is a
# lot of work (her request of 2026-10-13 for a graphic). Code is drawn as bars,
# one per line, as an editor's minimap draws it; nothing here is measured, and
# the line lengths and their order are made up for the drawing. On the left,
# lines of method (teal) and lines written around the client's data (dark) are
# interleaved in one project's code. On the right the method stands alone as a
# package, and the data is a table behind a stamp. The dark lines on the left
# are what has to be rewritten for the separation.

code_lines <- function(x0, kinds, indent, len, top = 2.4, step = 0.2) {
  tibble(
    kind = kinds,
    x = x0 + 0.22 + 0.28 * indent,
    xend = x + len,
    y = top - step * (seq_along(kinds) - 1)
  )
}

blk_w <- 2.5
blk <- tibble(
  x0 = c(0.4, 5.6, 8.9),
  title = c("Code for one project", "Method", "Data"),
  caption = c("method written around\nthe client's data",
              "an R package\nanyone can run", "stays confidential")
)

mixed <- code_lines(blk$x0[1],
                    kinds = c("m", "d", "m", "m", "d", "m", "d", "d", "m"),
                    indent = c(0, 0, 1, 1, 1, 0, 1, 1, 0),
                    len = c(1.5, 1.9, 1.3, 1.0, 1.6, 1.4, 1.2, 1.7, 0.9))
method_only <- code_lines(blk$x0[2],
                          kinds = rep("m", 9),
                          indent = c(0, 1, 1, 0, 0, 1, 1, 1, 0),
                          len = c(1.5, 1.3, 1.0, 0.6, 1.4, 1.1, 1.6, 0.8, 0.9))

# The data as a grid of cells, five columns by seven rows.
cells <- expand_grid(col = 0:4, row = 0:6) |>
  mutate(x = blk$x0[3] + 0.2 + col * 0.42, y = 0.85 + row * 0.235)

# A stamp across the table: a rectangle and its word, both turned 12 degrees.
stamp_c <- c(blk$x0[3] + blk_w / 2, 1.6)
stamp_a <- 12 * pi / 180
stamp <- tibble(dx = c(-0.98, 0.98, 0.98, -0.98), dy = c(-0.23, -0.23, 0.23, 0.23)) |>
  mutate(x = stamp_c[1] + dx * cos(stamp_a) - dy * sin(stamp_a),
         y = stamp_c[2] + dx * sin(stamp_a) + dy * cos(stamp_a))

col_method <- pal[["era2"]]
col_data <- "#2B2B2B"
col_stamp <- "#C1272D"

p_separate <- ggplot() +
  geom_rect(data = blk, aes(xmin = x0, xmax = x0 + blk_w, ymin = 0.6, ymax = 2.6),
            fill = "#F4F6F8", colour = "grey75", linewidth = 0.6) +
  geom_segment(data = bind_rows(mixed, method_only),
               aes(x = x, xend = xend, y = y, yend = y, colour = kind),
               linewidth = 3.2, lineend = "round") +
  geom_tile(data = cells, aes(x + 0.19, y), width = 0.36, height = 0.19,
            fill = col_data, alpha = 0.85) +
  geom_polygon(data = stamp, aes(x, y), fill = "white", alpha = 0.85,
               colour = col_stamp, linewidth = 1.6) +
  annotate("text", x = stamp_c[1], y = stamp_c[2], label = "CONFIDENTIAL",
           angle = 12, colour = col_stamp, fontface = "bold", size = 5.7) +
  annotate("segment", x = 3.15, xend = 5.35, y = 1.6, yend = 1.6,
           linewidth = 1.4, colour = "grey30",
           arrow = arrow(length = unit(0.16, "in"), type = "closed")) +
  annotate("text", x = 4.25, y = 1.78, label = "separating them",
           size = 6.6, colour = "grey20", vjust = 0) +
  annotate("text", x = 4.25, y = 1.42, label = "a lot of work",
           size = 6.6, colour = pal[["hi"]], fontface = "bold", vjust = 1) +
  geom_text(data = blk, aes(x0 + blk_w / 2, 2.75, label = title),
            size = 7.4, fontface = "bold", colour = pal[["accent"]], vjust = 0) +
  geom_text(data = blk, aes(x0 + blk_w / 2, 0.45, label = caption),
            size = 6.2, colour = "grey30", vjust = 1, lineheight = 0.9) +
  scale_colour_manual(values = c(m = col_method, d = col_data)) +
  coord_cartesian(xlim = c(0, 11.75), ylim = c(-0.3, 3.15), expand = FALSE) +
  theme_void() +
  theme(legend.position = "none")

save_fig(p_separate, "method-data-separation.png", width = 12, height = 3.4)

# ===========================================================================
# 10. bayesnec, June to October 2026 — MEASURED, from the public history
# ===========================================================================
# Derived by R/bayesnec-evidence.R; see that script for the method. Commits are
# coloured by where they sit now rather than by a Co-Authored-By trailer, because
# Claude Code and Codex commit as the speaker and not all of it is marked. The
# issues panel shares the week axis, so the weeks in which as many issues were
# opened as closed line up under the weeks of most commits.

bn_weekly <- read.csv(file.path("data", "bayesnec-weekly.csv")) |>
  mutate(week = as.Date(week))

bn_where <- c(dev = "merged into dev", predev = "parked on predev",
              other = "never merged")
bn_commits <- bn_weekly |>
  select(week, dev = commits_dev, predev = commits_predev, other = commits_other) |>
  pivot_longer(-week, names_to = "where", values_to = "n") |>
  mutate(where = factor(bn_where[where], levels = rev(bn_where)))

bn_issues <- bn_weekly |>
  select(week, opened = issues_opened, closed = issues_closed) |>
  pivot_longer(-week, names_to = "what", values_to = "n") |>
  mutate(what = factor(what, levels = c("opened", "closed")))

bn_x <- scale_x_date(date_breaks = "1 month", date_labels = "%b",
                     limits = range(bn_weekly$week) + c(0, 7),
                     expand = expansion(mult = 0.01))
bn_legend <- theme(legend.position = "top", legend.justification = "left",
                   legend.title = element_blank(),
                   legend.text = element_text(size = rel(0.72)),
                   legend.key.size = unit(0.8, "lines"),
                   legend.margin = margin(0, 0, 0, 0),
                   panel.grid.major.x = element_blank())

p_bn_commits <- ggplot(bn_commits, aes(week + 3, n, fill = where)) +
  geom_col(width = 5.6) +
  scale_fill_manual(values = setNames(c(pal[["accent"]], pal[["hi"]], "#B0B0B0"),
                                      bn_where),
                    breaks = unname(bn_where)) +
  bn_x +
  scale_y_continuous(expand = expansion(mult = c(0, 0.04))) +
  labs(x = NULL, y = NULL, title = "Commits a week") +
  theme_talk(base_size = 22) + bn_legend

p_bn_issues <- ggplot(bn_issues, aes(week + 3, n, fill = what)) +
  geom_col(width = 5.6, position = position_dodge(width = 5.8)) +
  scale_fill_manual(values = c(opened = "grey35", closed = pal[["era2"]])) +
  bn_x +
  scale_y_continuous(expand = expansion(mult = c(0, 0.06))) +
  labs(x = NULL, y = NULL, title = "Issues a week") +
  theme_talk(base_size = 22) + bn_legend

save_fig(p_bn_commits / p_bn_issues + plot_layout(heights = c(1.35, 1)),
         "bayesnec-weekly.png", width = 6.8, height = 6.2)

# ===========================================================================
# 11. Checking code against a known answer — schematic
# ===========================================================================
# For the last click of "Points to take away", where the speaker says AI now
# writes more than people can review, and that for her review means
# understanding what would show the code is wrong and building simulations and
# tests to check it (her request of 2026-10-13 for a graphic). No openly
# licensed graphic of this was found, so it is drawn. The cycle is the method of
# the ssdtools evaluation: set a true value, simulate data from it, run the code,
# and compare the estimates with the true value for bias and coverage. The known
# answer and the estimates are drawn as the bias-and-precision target used in
# statistics teaching, rather than as an interval plot, because an interval plot
# would read as a measured coverage result and none was measured. The code is
# drawn as an editor's minimap, as in section 9. Nothing here is measured: the
# positions of the data points, line lengths and estimates are made up for the
# drawing.

set.seed(2026)

chk_box <- tibble(
  x0 = c(0.25, 5.9, 5.9, 0.25),
  y0 = c(5.7, 5.7, 0.3, 0.3),
  title = c("Known answer", "Simulated data", "Code written by AI", "Estimates"),
  caption = c("set by you", "from that answer", "too much to read", "one per data set")
) |>
  mutate(x1 = x0 + 3.85, y1 = y0 + 4, cx = x0 + 3.85 / 2, cy = y0 + 1.45)

target_rings <- function(cx, cy, r = c(1.25, 0.85, 0.45)) {
  expand_grid(ring = seq_along(r), t = seq(0, 2 * pi, length.out = 121)) |>
    mutate(x = cx + r[ring] * cos(t), y = cy + r[ring] * sin(t),
           group = paste(cx, cy, ring))
}
rings <- bind_rows(target_rings(chk_box$cx[1], chk_box$cy[1]),
                   target_rings(chk_box$cx[4], chk_box$cy[4]))

chk_data <- tibble(x = runif(26, chk_box$x0[2] + 0.5, chk_box$x1[2] - 0.5),
                   y = runif(26, chk_box$y0[2] + 0.35, chk_box$y0[2] + 2.6))

chk_code <- code_lines(chk_box$x0[3] + 0.15,
                       kinds = rep("ai", 11),
                       indent = c(0, 1, 1, 2, 1, 0, 1, 1, 2, 2, 1),
                       len = c(2.4, 2.0, 1.4, 1.1, 2.3, 1.7, 2.5, 1.2, 1.5, 0.9, 2.1),
                       top = chk_box$y0[3] + 2.4, step = 0.2) |>
  mutate(alpha = c(rep(1, 7), 0.75, 0.5, 0.3, 0.15))

chk_est <- tibble(dx = c(0.14, -0.2, 0.06, 0.27, -0.09, 0.17, -0.27, 0.0),
                  dy = c(0.05, 0.12, -0.22, -0.08, -0.13, 0.24, -0.02, 0.3)) |>
  mutate(x = chk_box$cx[4] + 1.4 * dx, y = chk_box$cy[4] + 1.4 * dy)

chk_arrow <- arrow(length = unit(0.11, "in"), type = "closed")

p_check <- ggplot() +
  geom_rect(data = chk_box, aes(xmin = x0, xmax = x1, ymin = y0, ymax = y1),
            fill = "#F4F6F8", colour = "grey75", linewidth = 0.6) +
  geom_text(data = chk_box, aes(cx, y1 - 0.3, label = title),
            size = 5.6, fontface = "bold", colour = pal[["accent"]], vjust = 1) +
  geom_text(data = chk_box, aes(cx, y1 - 0.9, label = caption),
            size = 5.4, colour = "grey35", vjust = 1) +
  geom_path(data = rings, aes(x, y, group = group),
            colour = pal[["accent"]], linewidth = 1.1) +
  annotate("point", x = chk_box$cx[c(1, 4)], y = chk_box$cy[c(1, 4)],
           colour = pal[["accent"]], size = 4.5) +
  geom_point(data = chk_data, aes(x, y), colour = "grey35", size = 2.4) +
  geom_segment(data = chk_code,
               aes(x = x, xend = xend, y = y, yend = y, alpha = alpha),
               colour = pal[["hi"]], linewidth = 2.6, lineend = "round") +
  geom_point(data = chk_est, aes(x, y), colour = pal[["hi"]], size = 3) +
  # simulate, run, give estimates: the cycle runs clockwise
  annotate("segment", x = 4.25, xend = 5.75, y = 7.15, yend = 7.15,
           linewidth = 1, colour = "grey30", arrow = chk_arrow) +
  annotate("text", x = 5, y = 7.4, label = "simulate", size = 5.4,
           colour = "grey20", vjust = 0) +
  annotate("segment", x = 7.825, xend = 7.825, y = 5.55, yend = 4.45,
           linewidth = 1, colour = "grey30", arrow = chk_arrow) +
  annotate("text", x = 8.05, y = 5, label = "run", size = 5.4,
           colour = "grey20", hjust = 0) +
  annotate("segment", x = 5.75, xend = 4.25, y = 1.75, yend = 1.75,
           linewidth = 1, colour = "grey30", arrow = chk_arrow) +
  annotate("segment", x = 2.175, xend = 2.175, y = 4.45, yend = 5.55,
           linewidth = 1.2, colour = pal[["accent"]],
           arrow = arrow(length = unit(0.11, "in"), type = "closed", ends = "both")) +
  annotate("text", x = 2.4, y = 5, label = "compare: bias, coverage",
           size = 5.4, colour = pal[["accent"]], fontface = "bold", hjust = 0) +
  scale_alpha_identity() +
  coord_fixed(xlim = c(0, 10), ylim = c(0, 10), expand = FALSE) +
  theme_void() +
  theme(legend.position = "none")

save_fig(p_check, "known-answer-check.png", width = 5.6, height = 5.6)

message("\nAll figures written to ", normalizePath(fig_dir))
