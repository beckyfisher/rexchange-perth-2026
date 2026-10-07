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
  2024,  "CRAN",            "default software for guideline values:\nAustralia, New Zealand, Canada", 0.6
) |>
  mutate(shared = factor(shared, levels = shared_levels))

timeline_base <- function() {
  ggplot(code, aes(year, as.numeric(shared))) +
    annotate("rect", xmin = 2009, xmax = 2015.5, ymin = 0.4, ymax = 4.75,
             fill = pal[["era1"]], alpha = 0.07) +
    annotate("rect", xmin = 2015.5, xmax = 2020.6, ymin = 0.4, ymax = 4.75,
             fill = pal[["era2"]], alpha = 0.07) +
    annotate("rect", xmin = 2020.6, xmax = 2027.9, ymin = 0.4, ymax = 4.75,
             fill = pal[["era3"]], alpha = 0.07) +
    annotate("text", x = 2012.25, y = 4.62, label = "1. scripts",
             colour = pal[["era1"]], fontface = "bold", size = 4.4) +
    annotate("text", x = 2018.05, y = 4.62, label = "2. GitHub",
             colour = pal[["era2"]], fontface = "bold", size = 4.4) +
    annotate("text", x = 2022.6, y = 4.62, label = "3. CRAN",
             colour = pal[["era3"]], fontface = "bold", size = 4.4) +
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

# Two versions on the same canvas, so the slide can add the regulatory marks
# with a click and nothing else on the plot shifts.
p_timeline <- timeline_base()
p_timeline_reg <- timeline_base() +
  geom_point(data = regulation, aes(year, as.numeric(shared)),
             inherit.aes = FALSE, shape = 21, size = 11, stroke = 1.6,
             colour = pal[["hi"]], fill = NA) +
  geom_text(data = regulation,
            aes(year, as.numeric(shared), label = label, hjust = hj),
            inherit.aes = FALSE, vjust = 1.9, nudge_y = -0.18, size = 3.9,
            fontface = "bold", colour = pal[["hi"]], lineheight = 0.95)

save_fig(p_timeline, "code-timeline.png", width = 10.5, height = 4.9)
save_fig(p_timeline_reg, "code-timeline-regulation.png", width = 10.5, height = 4.9)

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
# backup slide in 2b.
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
# ANZG deck teaches the SSD. The first single fit shown is the log-normal.

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

# --- 2b. why model averaging: the same data, several answers ----------------
# This is the "which model do you fit?" backup slide, made concrete.

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

cat_levels <- c("Source code", "Documentation (generated)",
                "Documentation (written)", "Tests", "Packaging, CI, CRAN",
                "Other")

work <- shares |>
  mutate(
    # reversed so "Before" reads on top
    era = factor(era, levels = c("With an AI assistant", "Before")),
    category = factor(category, levels = cat_levels)
  )

p_work <- ggplot(work, aes(share, era, fill = category)) +
  geom_col(width = 0.5, colour = "white", linewidth = 0.8) +
  geom_text(aes(label = ifelse(share >= 7, paste0(round(share), "%"), "")),
            position = position_stack(vjust = 0.5),
            size = 4.2, colour = "white", fontface = "bold") +
  scale_fill_manual(values = c(
    "Source code"               = pal[["accent"]],
    "Documentation (generated)" = pal[["era2"]],
    "Documentation (written)"   = "#4C9A94",
    "Tests"                     = "#7FBDB8",
    "Packaging, CI, CRAN"       = "#A9D3CF",
    "Other"                     = "#B0B0B0"
  )) +
  scale_x_continuous(labels = percent_format(scale = 1),
                     expand = expansion(mult = c(0, 0.02))) +
  labs(x = NULL, y = NULL,
       title = "Share of files changed, by what each file is for",
       subtitle = "Commits before 20 June 2026, and commits made with an AI assistant since.",
       caption = paste0(
         "Measured, not estimated: every commit I authored across ",
         length(strsplit(fact("repos_analysed"), ";")[[1]]),
         " public repos (", fact("commits_total"), " commits).\n",
         "\u201cWith an AI assistant\u201d = the ", fact("commits_ai_trailer"),
         " commits carrying a Co-Authored-By: Claude trailer \u2014 a conservative floor.",
         "  Unit: one file changed in one commit.  Code: R/git-evidence.R")) +
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

message("\nAll figures written to ", normalizePath(fig_dir))
