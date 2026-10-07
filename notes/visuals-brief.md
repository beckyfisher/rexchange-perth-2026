# Visuals brief

What is on each slide, where it comes from, and what to do to change it.

The deck uses the AIMS presentation template from the speaker's SETAC Asia-Pacific deck
(`old_talks_and_background/SETAC AP Produced water_WET.pptx`): a blue title panel with the
Commonwealth Coat of Arms and the AIMS logo, a blue strip and contour linework on content
slides, Arial throughout, and headings in AIMS blue. Within that frame the speaker's own habits
from the earlier decks still apply: sparse text, one idea per slide, `→` as the connector, and
annotation on the figure stating the point.

There are four sources of images, and they are handled differently because their licences
differ.

| Source | Folder | In git | Made by |
|---|---|---|---|
| Generated figures | `talk/figures/` | yes | `R/figures.R` |
| Published dredging figures, CC BY 3.0 AU | `talk/external/` | yes, with attribution | `R/external-figures.R` |
| AIMS template assets | `talk/aims/` | no | `R/aims-assets.R` |
| Pictures from the speaker's earlier slides | `talk/local/` | no | `R/local-images.R` |

Slides are built up one click at a time, so that the slide holds what the speaker says. Where
the picture changes with a click, the versions are stacked in a `.r-stack` and drawn on
identical canvases, so nothing else on the slide shifts. Where a picture stays in place across
several slides, as the coral photographs and the concentration–response curve do through the
dredging sequence, it is placed at the same absolute position on each.

---

## Colour and type

Defined in `talk/custom.scss`, with the plot palette `pal` in `R/figures.R` matching it.

| Role | Hex | Used for |
|---|---|---|
| AIMS blue | `#005B9E` | headings, emphasis, the main curve in each plot (`pal$accent`) |
| Body text | `#333333` | the template's body grey |
| Era 1 | `#9E9E9E` | grey; scripts, not software |
| Era 2 | `#1B7F79` | teal; GitHub, and "protective" in plots |
| Highlight | `#E4572E` | orange; the number that matters, and the AI section |
| Light | `#C9D6DF` | de-emphasised candidate distributions |

Fonts are Arial, as in the template. Figures are rendered with Windows R so that `ggplot2`'s
`sans` family is Arial as well; on Linux it falls back to a different face.

---

## AIMS template assets (`talk/aims/`, not committed)

These belong to AIMS. The Coat of Arms has its own conditions of use, and the team slide holds
colleagues' portraits, so none of it can be relicensed under this repository's CC BY 4.0.
`R/aims-assets.R` reads them out of the source deck on the author's machine.

| File | Source in the SETAC deck | Used on |
|---|---|---|
| `title-background.jpg` | Front-cover master (`media/image1.jpg`) | title |
| `content-background.jpg` | Content master strip (`image3.png`) flattened over the layout's contour lines (`image5.jpg`) | every content slide, via `talk/aims-background.lua` |
| `aims-intro.jpg` | Slide 2, a single full-slide picture | AIMS introduction |
| `aims-team.jpg` | Slide 3, exported by PowerPoint | team |
| `dredge-photo.jpg` | The dredging photograph on slide 3 | title collage |

Without the source deck (CI, or any other clone) the script writes labelled grey placeholders
with base R graphics, so the deck still renders. Exporting the team slide needs PowerPoint,
driven through PowerShell, and works from Windows R or WSL R.

The team slide was current for the SETAC talk. Check the people on it before presenting.

---

## Pictures from the speaker's earlier slides (`talk/local/`, not committed)

`R/local-images.R` exports them from `old_talks_and_background/slides.pptx` through PowerPoint,
which keeps transparency. That file collects slides from the ANZG, SETAC Darwin and AIMS 50th
talks. The pictures include stock photographs, journal covers, a web graphic, the cover of the
WA EPA guidance, and figures published in Fisher et al. (2018) *J. Appl. Ecol.*, so none can be
relicensed. Without the source deck the script writes grey placeholders of the same shape.

| File | Source slide | Used on |
|---|---|---|
| `outfall.jpg`, `no-sign.png`, `breath-test.jpg`, `police-hat.png` | 1, the blood-alcohol slide | *The legal limit* |
| `white-literature.jpg`, `grey-literature.png`, `confidential.png`, `black-box.png` | 8, white, grey and black literature | *White, grey and black literature*; the black box also on *Open source and regulatory agreement* |
| `pressure-triangle.png`, `wq-strip.png` | 2, exposure metrics | *Dredging exposure*, and the strip on the next two slides |
| `mortality-densities.png`, `coral-strip.jpg` | 3, *in situ* mortality | *Coral mortality*, and the strip on the next slide |
| `cr-curve.png`, `cr-triangle.png` | 4, concentration–response | *Concentration–response in the field*, *Thresholds from error rates* |
| `roc.png` | 6, probabilistic thresholds | *Thresholds from error rates* |
| `management-zones.png`, `epa-guidance.png` | 7, link to management | *Thresholds in dredging management* |

The water quality strip is semi-transparent in the source, so laid over the coral photographs
it gives the combined strip of the source deck's slide 4. In `mortality-densities.png` a white
mask over a panel label is made transparent, because it showed as a white box on the contour
background.

---

## Published dredging figures (`talk/external/`, committed)

Both are WAMSI Dredging Science Node reports, released under CC BY 3.0 AU unless otherwise
noted; neither figure has a separate credit. Full attribution is in
`talk/external/README.md`, and each slide gives a credit line.

### `porites-time-sequence.jpg`

Slide: *Barrow Island monitoring data.*

Fisher, Jones & Bessell-Browne (2019), Project 4.9.4, Figure 6: one massive *Porites* colony
photographed from day 1 to day 534 of the Barrow Island dredging campaign, beneath the turbidity
record for the same period. Used as published, without the caption.

It replaces a drawn CONFIDENTIAL stamp. The stamp showed only that the data were confidential;
the photographs show what one of the 1,500 monitored colonies looked like, from a report
already in the public record.

### `turbidity-thresholds.png`

Backup slide: *Thresholds against turbidity events.* It was the main dredging slide until
2026-10-06, when the five-slide build from *Dredging exposure* to *Thresholds in dredging
management* replaced it.

Jones et al. (2019), Theme 4 Synthesis Report, Figure 19. Panel A is suspended sediment at a
site about 200 m from the dredge; panel B is the running-mean hazard profile of two turbidity
events against the possible and probable effect thresholds of Fisher et al. (2018). In the
report the panels are stacked, which is too tall for a 16:9 slide, so they are placed side by
side; the credit line says so.

Reading it: event A exceeds the possible-effects threshold over short running means and stays
below the probable threshold; event B exceeds both for most durations.

### `porites-strip.jpg`

The top row of the same Figure 6 (days 1, 130 and 263), for the title collage.

---

## Generated figures (`talk/figures/`, committed)

Produced by `R/figures.R`. Do not hand-edit them.

### `code-timeline.png` and `code-timeline-regulation.png`

Slide: *Code and regulation, 2010–2026.*

The speaker's code from 2010 to 2026, by how it was shared: her own computer, a zip file,
GitHub, or CRAN. The second version, shown on a click, circles the two pieces used in
regulation: the dredging thresholds, used in WA dredging guidance, and `ssdtools`, the default
software for guideline values in Australia, New Zealand and Canada.

An earlier version put "named in regulation" as a fifth level above CRAN, with an axis titled
"how far each piece of software could travel". The speaker rejected it on 2026-10-06. The axis
title is a metaphor, and the ordering is wrong: regulators use results and do not ask whether
the code is on CRAN, and the dredging thresholds are in WA guidance although their code was
never shared. Regulatory use is now marked separately from how the code was shared. Years
before 2021 are reconstructed from the CV; the 2021 CRAN date is verified.

### `ssd-step-1.png` to `ssd-step-5.png`

Slides: *Species sensitivity distributions* (steps 1–3) and *Choice of distribution* (steps 4–5).

A real SSD, built up in the way the speaker's ANZG deck teaches it: the CCME boron toxicity
estimates from `ssddata`; a log-normal fit; its PC95 (1.68 mg/L); six single-distribution fits,
whose PC95 ranges from 1.07 to 1.77 mg/L; and the model average, PC95 1.26 mg/L. All five
share axes and canvas, so on the slide they read as one plot gaining layers.

### `reef-richness.png`

Slide: *ElicitN.*

The estimate ElicitN was used for: 830,000 species on coral reefs worldwide (95% credible
interval 550,000–1,330,000), with its named, discovered but unnamed, and undiscovered parts.
Redrawn from the numbers in the text of Fisher et al. (2015) *Current Biology* 25:500, because
the published Figure 1 is Elsevier copyright. The paper shows each estimate as an elicited
density; the redraw shows the point estimate and interval.

### `where-work-goes.png`

Slide: *The change since June.*

Stacked bars, before and with an AI assistant: the share of files changed, by what each file is
for. Measured by `R/git-evidence.R` from 1,340 commits across seven public repositories; the
figure reads `data/git-evidence-shares.csv` and `data/git-evidence-facts.csv`. "With an AI
assistant" means a `Co-Authored-By: Claude` trailer, which understates the contrast. The unit is
one file changed in one commit. Saved smaller than the other figures so its labels are legible
when scaled to the slide.

### `title-ssd.png`

The boron SSD without title or caption, for the title collage.

### Backup slides

`roc-thresholds.png` (schematic ROC, after Fisher et al. 2018), `ssd-model-spread.png` (PC95
from each single distribution, 1.07 to 1.77 mg/L) and `no-effect-estimates.png` (schematic NEC,
NSEC, EC10 and NOEC) are on three of the four uncounted slides after the closing slide; the
fourth holds `turbidity-thresholds.png`.

The stop sign drawn for the earlier slide 4, and `ssd-model-average.png`, were removed on
2026-10-06 with the slides that used them.

---

## Layout notes

- The slide is 1600 × 900, the template's own proportions, with `margin: 0`. Content is padded
  128 px from the left so it clears the template's blue strip.
- Full-width figures use `{.fig-full}`, sized by `custom.scss` to at most 1400 × 640 px.
  Quarto's `auto-stretch` is off, because it sized images to fill the height regardless of
  width and pushed wide figures off the right edge.
- Smaller supporting text uses `.minor`, not `.aside`: Quarto places anything with class
  `.aside` at the foot of the slide.
- The title slide is built by hand (no YAML `title`) so the right half can take a collage, as
  on the template's front cover.

## Accessibility

- Every image on a slide has `fig-alt`. Keep that true of anything added.
- The palette does not rely on red–green discrimination; teal and orange differ in lightness as
  well as hue.
- The deck renders as one self-contained HTML file, so it needs no network connection in the
  room.
