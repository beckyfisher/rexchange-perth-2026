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
| Era 1 — lone scripter | `#9E9E9E` | grey; the pre-GitHub era |
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

### `roc-thresholds.png` — slide 13

Two panels: overlapping control/impact densities with two operating thresholds marked, and
the corresponding ROC curve with those two points.

- Distribution separation is tuned (`2.0, 1.3`) so the two thresholds are visibly different.
  If you make the groups more separated, the trade-off looks trivial and the slide stops
  working.

### `where-work-goes.png` — slide 16

Stacked bars, before vs with an AI assistant, over six categories of effort.

- **This is the only figure that is not derived from data.** It carries an `ILLUSTRATIVE`
  caption *and* the speaker notes instruct you to say so aloud. Keep both.

---

## Static assets

Carried over from earlier decks, in `assets/`:

| File | Slide | Use |
|---|---|---|
| `stopsign.png` | 1 | The cold open. Small, right column — it's punctuation, not decoration. |
| `confidential.jpg` | 9 | The black-literature slide. The whole visual argument in one stamp. |
| `tripple_planetary_crisis.png` | *unused* | Available if you ever need to open on the global pollution framing instead — but that's the ecotox opening, and this talk deliberately opens on a single dredge instead. |

---

## Suggested additions, if you want more

Not built, because the deck is already at time. In rough order of value:

1. **A screenshot of `shinyssdtools`** on slide 12, to make the "last mile" argument
   concrete. One image, no annotation. This is the strongest missing visual.
2. **A `git log --stat` or GitHub contribution graph** on slide 16 — real evidence for the
   productivity claim, which currently rests on an illustrative chart. If you can extract a
   defensible before/after commit or test-count series from the `open-AIMS` repos, it would
   materially strengthen the weakest point in the talk.
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
