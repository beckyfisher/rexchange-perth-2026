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

pal <- c(
  era1   = "#9E9E9E",  # lone scripter
  era2   = "#1B7F79",  # packages + GitHub (AIMS teal)
  era3   = "#E4572E",  # AI
  accent = "#2E4057",
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
# 1. The journey timeline — the spine of the talk
# ===========================================================================
# y-axis is "how far the software could travel", which is the actual argument:
# the same person, the same statistics, but a widening blast radius.

reach_levels <- c(
  "On my hard drive",
  "Zip file on request",
  "Public repository",
  "On CRAN",
  "Named in regulation"
)

# `hj` staggers labels left/right so points one year apart never overplot.
#
# TODO (author to confirm): the years below are reconstructed from the CV and the
# earlier decks, not from CRAN/GitHub metadata. `bayesnec` is placed at 2021 on
# the strength of the 2021 SETAC presentation and the 2022 AIMS talk describing
# it as already on CRAN — check the actual first release before presenting.
journey <- tribble(
  ~year, ~artefact,        ~reach,                ~era,   ~hj,  ~note,
  2010,  "CReefs scripts", "On my hard drive",    "era1", 0.5,  "25 stats scripts + 32 tcl/tk scripts",
  2012,  "ElicitN",        "Zip file on request", "era1", 0.5,  "Env. Modelling & Software; SourceForge",
  2018,  "FSSgam",         "Public repository",   "era2", 1.0,  "the \"simple function\" people kept asking for",
  2019,  "epower",         "Public repository",   "era2", 0.0,  "Methods Ecol. Evol.; industry-funded",
  2021,  "bayesnec",       "On CRAN",             "era2", 0.5,  "with D. Barneche, G. Ricardo, D. Fox · JSS 2024",
  2024,  "ssdtools",       "Named in regulation", "era2", 1.0,  "adopted as the default for GV derivation",
  2025,  "ssdtools v2",    "Named in regulation", "era3", 0.0,  "JOSS · AU / NZ / CA"
) |>
  mutate(
    reach = factor(reach, levels = reach_levels),
    nx    = case_when(hj == 1 ~ -0.18, hj == 0 ~ 0.18, TRUE ~ 0)
  )

# The Barrow Island dredging analysis is plotted separately, as a triangle off the
# step line. It is not packaged software, and its reach is deliberately *low* while
# its stakes are the highest in the talk — that non-monotonicity is the point, and
# folding it into the step line would hide it.
oneoff <- tibble(
  year  = 2018,
  reach = factor("On my hard drive", levels = reach_levels),
  label = "Barrow Island analysis",
  note  = "bespoke JAGS + R, never packaged"
)

p_journey <- ggplot(journey, aes(year, as.numeric(reach))) +
  annotate("rect", xmin = 2009, xmax = 2015.5, ymin = 0.4, ymax = 5.6,
           fill = pal[["era1"]], alpha = 0.07) +
  annotate("rect", xmin = 2015.5, xmax = 2024.5, ymin = 0.4, ymax = 5.6,
           fill = pal[["era2"]], alpha = 0.07) +
  annotate("rect", xmin = 2024.5, xmax = 2026.6, ymin = 0.4, ymax = 5.6,
           fill = pal[["era3"]], alpha = 0.09) +
  annotate("text", x = 2012.2, y = 5.45, label = "1. lone scripter",
           colour = pal[["era1"]], fontface = "bold", size = 4.2, hjust = 0.5) +
  annotate("text", x = 2020.0, y = 5.45, label = "2. packages + GitHub",
           colour = pal[["era2"]], fontface = "bold", size = 4.2, hjust = 0.5) +
  annotate("text", x = 2025.5, y = 5.45, label = "3. AI",
           colour = pal[["era3"]], fontface = "bold", size = 4.2, hjust = 0.5) +
  geom_step(data = journey |> arrange(year),
            aes(year, as.numeric(reach)), colour = "grey70",
            linewidth = 0.6, direction = "hv") +
  geom_point(aes(colour = era), size = 4.6) +
  geom_text(aes(x = year + nx, label = artefact, hjust = hj),
            vjust = -1.15, size = 4.3, fontface = "bold",
            colour = pal[["accent"]]) +
  geom_text(aes(x = year + nx, label = note, hjust = hj),
            vjust = 2.4, size = 3.05, colour = "grey45") +
  # the one-off analysis behind the talk's cold open
  geom_point(data = oneoff, aes(year, as.numeric(reach)),
             inherit.aes = FALSE, shape = 17, size = 5, colour = pal[["era3"]]) +
  geom_text(data = oneoff, aes(year - 0.18, as.numeric(reach), label = label),
            inherit.aes = FALSE, hjust = 1, size = 4.1, fontface = "bold",
            colour = pal[["era3"]]) +
  geom_text(data = oneoff, aes(year, as.numeric(reach), label = note),
            inherit.aes = FALSE, vjust = 2.5, size = 3.05, colour = "grey45") +
  annotate("curve", x = 2021.4, xend = 2018.3, y = 1.42, yend = 1.09,
           curvature = 0.3, linewidth = 0.4, colour = pal[["era3"]],
           arrow = arrow(length = unit(0.16, "cm"), type = "closed")) +
  annotate("text", x = 2021.6, y = 1.46, hjust = 0, size = 3.5,
           fontface = "italic", colour = pal[["era3"]],
           label = "the number that stops a dredge") +
  scale_colour_manual(values = pal) +
  scale_y_continuous(breaks = seq_along(reach_levels), labels = reach_levels,
                     limits = c(0.4, 5.7)) +
  scale_x_continuous(breaks = seq(2010, 2026, 2), limits = c(2009, 2026.6)) +
  labs(x = NULL, y = NULL,
       title = "Same statistician. Same statistics. Very different blast radius.") +
  theme_talk() +
  theme(panel.grid.major.x = element_blank())

save_fig(p_journey, "journey-timeline.png", width = 12, height = 6.2)

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
               colour = pal[["era3"]], linetype = "22", linewidth = 0.7) +
  geom_segment(aes(x = hc5$est, xend = hc5$est, y = 0, yend = 0.05),
               colour = pal[["era3"]], linetype = "22", linewidth = 0.7) +
  annotate("point", x = hc5$est, y = 0.05, size = 4, colour = pal[["era3"]]) +
  annotate("text", x = hc5$est * 0.75, y = 0.30,
           label = paste0("PC95 = ", signif(hc5$est, 3), " mg/L"),
           colour = pal[["era3"]], size = 4.6, fontface = "bold", hjust = 0.5) +
  annotate("text", x = 400, y = 0.35,
           label = paste0(n_dist, " candidate\ndistributions"),
           colour = "grey55", size = 3.8, hjust = 0.5, lineheight = 0.95) +
  scale_x_log10(labels = comma_signif) +
  scale_y_continuous(labels = percent, limits = c(0, 1)) +
  labs(x = "Concentration (mg/L)", y = "Proportion of species affected",
       title = "The species sensitivity distribution",
       subtitle = "Each point is one species. The number you read off the curve becomes the guideline value.",
       caption = "CCME boron data, shipped with {ssddata}. Thin lines are single-distribution fits over the BCANZ set; the bold line is the model average.") +
  theme_talk()

save_fig(p_ssd, "ssd-model-average.png", width = 10.5, height = 6)

# --- 2b. why model averaging: the same data, several answers ----------------
# This is the "which model do you fit?" slide, made concrete.

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

spread_x <- max(hc_each$hc5) / min(hc_each$hc5)

p_spread <- ggplot(hc_each, aes(hc5, dist, colour = is_ma)) +
  geom_segment(aes(x = 0, xend = hc5, yend = dist), linewidth = 0.5) +
  geom_point(size = 4.4) +
  geom_text(aes(label = signif(hc5, 3)), hjust = -0.45, size = 3.9,
            fontface = "bold", show.legend = FALSE) +
  scale_colour_manual(values = c(`FALSE` = pal[["light"]], `TRUE` = pal[["era3"]])) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.18))) +
  labs(x = "PC95 guideline value (mg/L)", y = NULL,
       title = paste0("Same data. ", n_dist,
                      " defensible distributions. ", n_dist,
                      " different answers."),
       subtitle = paste0("A ", round(spread_x, 1),
                         "\u00d7 spread, and no theoretical basis for choosing one \u2192 so don't. Average over them, weighted."),
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
  ec10,  "EC10",  27,     pal[["era3"]],
  noec,  "NOEC",  34,     pal[["era3"]]
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
       title = "Four ways to say \"no effect\". Only one of them means it.",
       subtitle = "Whichever your software computes becomes the input to the SSD \u2014 and so becomes the guideline value.",
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
  geom_vline(xintercept = t_alarm, colour = pal[["era3"]], linewidth = 1) +
  annotate("text", x = t_power - 0.2, y = 0.46, label = "high power\n\u2192 mortality possible",
           colour = pal[["era2"]], size = 3.8, hjust = 1, fontface = "bold",
           lineheight = 0.95) +
  annotate("text", x = t_alarm + 0.2, y = 0.46, label = "low alarm rate\n\u2192 mortality probable",
           colour = pal[["era3"]], size = 3.8, hjust = 0, fontface = "bold",
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
             size = 4.4, colour = pal[["era3"]]) +
  scale_x_continuous(labels = percent) +
  scale_y_continuous(labels = percent) +
  labs(x = "False positive rate  (type I \u2192 cost to the developer)",
       y = "True positive rate  (1 \u2212 type II \u2192 cost to the environment)",
       title = "Pick the point that matches the decision",
       caption = "Schematic, after Fisher et al. (2018) J. Appl. Ecol. 55:415.") +
  theme_talk()

save_fig(p_dens + p_roc + plot_layout(widths = c(1.25, 1)),
         "roc-thresholds.png", width = 12.5, height = 5.6)

# ===========================================================================
# 5. Where the work actually goes (illustrative)
# ===========================================================================
# LABELLED ILLUSTRATIVE ON THE SLIDE. This is the speaker's own estimate of how
# effort is distributed, not a measurement. Do not present it as data.

work <- tribble(
  ~phase,  ~task,                          ~share,
  "before", "Thinking about the problem",   18,
  "before", "Writing the code that works",  32,
  "before", "Tests",                         6,
  "before", "Documentation / vignettes",     9,
  "before", "Packaging, CI, CRAN, review",  10,
  "before", "Fighting the tooling",         25,
  "after",  "Thinking about the problem",   46,
  "after",  "Writing the code that works",   4,
  "after",  "Tests",                        14,
  "after",  "Documentation / vignettes",    12,
  "after",  "Packaging, CI, CRAN, review",  16,
  "after",  "Fighting the tooling",          8
) |>
  mutate(
    # reversed so "Before" reads on top
    phase = factor(phase, levels = c("after", "before"),
                   labels = c("With an AI assistant", "Before")),
    task = factor(task, levels = c("Thinking about the problem",
                                   "Writing the code that works",
                                   "Tests",
                                   "Documentation / vignettes",
                                   "Packaging, CI, CRAN, review",
                                   "Fighting the tooling"))
  )

p_work <- ggplot(work, aes(share, phase, fill = task)) +
  geom_col(width = 0.5, colour = "white", linewidth = 0.8) +
  geom_text(aes(label = ifelse(share >= 8, paste0(share, "%"), "")),
            position = position_stack(vjust = 0.5),
            size = 3.4, colour = "white", fontface = "bold") +
  scale_fill_manual(values = c(
    "Thinking about the problem"   = pal[["accent"]],
    "Writing the code that works"  = pal[["era2"]],
    "Tests"                        = "#4C9A94",
    "Documentation / vignettes"    = "#7FBDB8",
    "Packaging, CI, CRAN, review"  = "#A9D3CF",
    "Fighting the tooling"         = "#B0B0B0"
  )) +
  scale_x_continuous(labels = percent_format(scale = 1),
                     expand = expansion(mult = c(0, 0.02))) +
  labs(x = NULL, y = NULL,
       title = "The speed-up is not in the typing",
       subtitle = "It is in the parts I used to skip \u2014 which are the parts that decide whether software survives.",
       caption = "ILLUSTRATIVE. My own estimate of where effort goes, not a measurement.") +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE, reverse = FALSE)) +
  theme_talk() +
  theme(panel.grid.major.y = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.text.y = element_text(face = "bold", colour = pal[["accent"]],
                                   size = rel(1.05)),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(size = rel(0.8)),
        legend.key.size = unit(0.9, "lines"))

save_fig(p_work, "where-work-goes.png", width = 11, height = 5.2)

message("\nAll figures written to ", normalizePath(fig_dir))
