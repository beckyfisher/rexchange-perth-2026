# Visuals brief

What is on each slide, where it comes from, and what to do if you want to change it.

The visual language deliberately follows the speaker's existing decks (see
`notes/source-synthesis.md` §"Visual style"): sparse text, one idea per slide, `→` as the
connector, schematic redraws rather than screenshots, and annotation carrying the argument
rather than a caption explaining it.

---

## Colour system

Defined once in `R/figures.R` (`pal`) and mirrored in `talk/custom.scss`, so plots and
slides read as one thing.

| Role | Hex | Used for |
|---|---|---|
| Era 1 — scripts, not software | `#9E9E9E` | grey; the pre-GitHub era |
| Era 2 — packages + GitHub | `#1B7F79` | teal; the working era, and "safe / protective" |
| Era 3 — AI | `#E4572E` | orange; also the "this is the number that matters" highlight |
| Accent | `#2E4057` | headings, primary curve, body emphasis |
| Light | `#C9D6DF` | de-emphasised candidate distributions |

The three-era colour thread runs all the way through: it appears on the timeline, on the
section dividers, and inline in the text (`.e1` / `.e2` / `.e3` classes).

---

## Generated figures

All produced by `R/figures.R` into `talk/figures/`. **Do not hand-edit them.**

### `journey-timeline.png` — slide 5, the spine

Software artefacts 2010–2026 plotted against *how far the thing could travel*
(hard drive → zip on request → public repo → CRAN → named in regulation), with the three
eras shaded behind.

- **Check the years before presenting.** They were reconstructed from the CV and the earlier
  decks, not from CRAN or GitHub metadata. `bayesnec` in particular is placed at 2021 on the
  strength of the 2021 SETAC presentation and the 2022 AIMS talk describing it as already on
  CRAN. There's a matching `TODO` in `R/figures.R`.
- The y-axis is the argument. Resist any temptation to relabel it "capability".
- Labels are staggered left/right via the `hj`/`nx` columns so points a year apart don't
  collide. If you add an event, set `hj` accordingly.
- **To extend:** add a row to the `journey` tibble. Add new reach levels to `reach_levels`
  first if needed.

### `ssd-model-average.png` — slide 2

A real SSD: CCME boron data from `{ssddata}`, six BCANZ candidate distributions as thin
lines, model average bold, PC95 marked in orange.

- Real fit, real data — deliberately not a cartoon, because the audience will assume it is.
- **Alt text** is set on the slide and describes the reading, not the geometry.

### `ssd-model-spread.png` — slide 3

Lollipop chart of the PC95 value from each single-distribution fit, model average
highlighted. The subtitle computes the fold-spread from the data, so it stays true if the
distribution set changes.

- This is the single most persuasive figure in act one for a technical audience: it converts
  "model choice matters" from an assertion into a number.

### `no-effect-estimates.png` — slide 10

Schematic concentration–response curve with NEC, NSEC, EC10 and NOEC marked, leader lines
fanning out to a single label row, and the pre-threshold region shaded "no effect".

- Schematic on purpose — a real `bayesnec` fit adds minutes to the build and no clarity.
- The four estimates genuinely sit close together in concentration; the leader lines exist
  so that fact is visible rather than illegible.

### `roc-thresholds.png` — slide 10

Two panels: overlapping control/impact densities with two operating thresholds marked, and
the corresponding ROC curve with those two points.

- **This is Route B, not Route A.** It illustrates the dredging work (Fisher et al. 2018,
  *J. Appl. Ecol.* 55:415) — *in situ* dose–response plus ROC, with **no SSD involved**.
  Keep it visually distinct from the SSD figures and never let a caption imply otherwise;
  the plot caption already cites the paper.
- Distribution separation is tuned (`2.0, 1.3`) so the two thresholds are visibly different.
  If you make the groups more separated, the trade-off looks trivial and the slide stops
  working.

### `where-work-goes.png` — slide 16

Stacked bars, before vs with an AI assistant: the share of files touched, by what each file
is for.

- **This is measured, not estimated.** An earlier draft of this talk used an invented chart
  here with plausible-looking made-up percentages. It was directionally right and
  numerically wrong — precisely the failure mode slide 19 warns about — so it was replaced
  with the real commit history.
- Derived by `R/git-evidence.R` from 1,340 commits across seven public repos, written to
  `data/git-evidence-shares.csv` and `data/git-evidence-facts.csv`. The figure reads the
  CSVs, so it rebuilds offline; regenerate the CSVs only when you want fresher data.
- "With an AI assistant" is defined as commits carrying a `Co-Authored-By: Claude` trailer.
  That is deliberately conservative — it misses AI-assisted work done before the trailer
  convention, so it understates the contrast. **Say so if asked**; the definition is the
  most attackable part of the slide and owning it is stronger than defending it.
- The unit is a *file touch*, not lines (dominated by generated `man/` output) and not
  commits (one commit often spans categories).
- Only public repos. Private work is invisible.

---

## Static assets — there are none

Every image in the deck is generated by `R/figures.R`. The earlier decks used clip art for
the stop sign and the CONFIDENTIAL stamp; those were third-party images of unknown
provenance, which is fine on a slide you present once and a problem in a public repository.
They are now drawn:

| File | Slide | Use |
|---|---|---|
| `stop-sign.png` | 1 | The cold open. Small, right column — it's punctuation, not decoration. |
| `confidential-stamp.png` | 6 | The black-literature slide. The whole visual argument in one stamp. |

Note that `ggplot2`'s text `size` is millimetres of font height and does **not** scale with
the figure, so if you change the `width`/`height` passed to `save_fig()` for either of these,
retune the `size` values or the text will overflow the shape.

**Worth adding on slide 7:** a map or photo of the Barrow Island monitoring layout. Check the
confidentiality and licence position on any operational imagery first — and remember the repo
is public, so it would need to be yours or openly licensed.

The UNEP "triple planetary crisis" graphic from the earlier deck is **not** used and should
not be added — it is third-party and the talk deliberately opens on a single dredge rather
than the global framing.

---

## Suggested additions, if you want more

Not built, because the deck is already at time. In rough order of value:

1. **A screenshot of `shinyssdtools`** on slide 12, to make the "last mile" argument
   concrete. One image, no annotation. This is the strongest missing visual.
2. **A screenshot of the `FSSgam` test suite passing**, or of the two-bug fix commit, on
   slide 17. The numbers are strong; seeing the actual commit message would be stronger.
3. **A photograph of a dredge plume from the air** behind slide 1. Emotionally effective,
   but check the licence and the confidentiality position on any operational imagery before
   using it.
4. **The three pressure-pathway diagram** (suspended sediment / light availability /
   sediment covering) from the SETAC deck, if slide 13 is ever expanded — but it's ecotox
   detail this audience does not need.

---

## Accessibility

- Every image on a slide has `fig-alt` set. Keep that true of anything you add.
- The palette does not rely on red/green discrimination. Era 2 (teal) and Era 3 (orange)
  are distinguishable in the common forms of colour vision deficiency and differ in
  lightness as well as hue.
- Slide text is large by default (`$presentation-font-size-root: 34px`). If a slide needs
  `{.smaller}` more than once, it has too much on it.
- The deck renders as a single self-contained HTML file (`embed-resources: true`), so it
  works with no network connection in the room.
