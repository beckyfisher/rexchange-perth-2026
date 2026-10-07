# Setting the legal limit with an R package

Talk materials for **[R Exchange Perth 2026](https://epi.group/events/r-exchange-perth-2026)**
(14–15 October 2026, Perth CBD).

A 15-minute talk, 2:15pm on 15 October 2026. Title as programmed: *Setting the legal limit
with an R package: fifteen years of open-source software in environmental regulation*.

**Rebecca Fisher** · Australian Institute of Marine Science ·
[github.com/beckyfisher](https://github.com/beckyfisher)

---

## What's here

| Path | What it is |
|---|---|
| `talk/index.qmd` | The slides — Quarto `revealjs`, with speaker notes in `::: {.notes}` blocks |
| `talk/abstract.qmd` | Abstract and bio as submitted, with earlier versions and submission notes |
| `talk/custom.scss` | Slide theme, after the AIMS presentation template; colours mirror `R/figures.R` |
| `talk/aims-background.lua` | Gives every slide the AIMS content background |
| `talk/figures/` | Generated figures — **do not hand-edit** |
| `talk/external/` | Two figures from published WAMSI reports, CC BY 3.0 AU — see its `README.md` |
| `talk/aims/` | AIMS template assets — **not committed**; extracted locally by `R/aims-assets.R` |
| `talk/local/` | Pictures from the speaker's earlier slides — **not committed**; extracted locally by `R/local-images.R` |
| `R/figures.R` | Reproducible figure code (`ggplot2`, `ssdtools`) |
| `R/external-figures.R` | Crops the WAMSI figures from the source PDFs (author's machine only) |
| `R/aims-assets.R` | Extracts the AIMS template assets, or writes placeholders where the source deck is absent |
| `R/local-images.R` | Exports pictures from the speaker's earlier slides through PowerPoint, or writes placeholders |
| `R/export-deck.R` | Writes the HTML, PDF and picture-per-slide PowerPoint for the organisers to `_output/handover/` |
| `R/git-evidence.R` | Derives the commit-history evidence in the AI section |
| `data/` | The CSVs that script produces — committed, so figures build offline and the numbers are checkable |
| `notes/slide-outline.md` | Slide-by-slide outline, timings, and what to drop if running long |
| `notes/speaker-notes.md` | Full narration script + anticipated questions — **generated** from the deck by `R/build-speaker-notes.R` |
| `notes/visuals-brief.md` | Visual system, sourcing, alt text, suggested additions |
| `notes/source-synthesis.md` | What was read to build this, and the themes extracted |
| `prompts/` | Log of AI-assisted sessions (publication disclosure) |

## Reproducing

Requires R (≥ 4.4) and Quarto (≥ 1.4).

```bash
# 1. figures
Rscript R/figures.R

# 2. AIMS template assets and pictures from earlier slides
#    (real ones on the author's machine, placeholders elsewhere)
Rscript R/aims-assets.R
Rscript R/local-images.R

# 3. narration file, regenerated from the deck's speaker notes
Rscript R/build-speaker-notes.R

# 4. slides + abstract  ->  _output/
quarto render

# 5. HTML, PDF and PowerPoint for the organisers  ->  _output/handover/
Rscript R/export-deck.R
```

`R/external-figures.R` is not part of the routine build. It recreates `talk/external/` from
the git-ignored source PDFs and needs `pdftools` and `magick`; run it only if a crop changes.
`R/aims-assets.R` and `R/local-images.R` use `magick` when their source decks are present and
base R otherwise. Exporting the AIMS team slide, and every picture `R/local-images.R` writes,
needs PowerPoint on the same machine.

The speaker notes live in `talk/index.qmd` inside `::: {.notes}` blocks and are the single
source of truth; `notes/speaker-notes.md` is generated from them so the two can't drift. A
line beginning `> ` inside a notes block is a **stage direction** — something to do, not
something to say.

On the author's Windows machine neither is on `PATH`:

```powershell
& "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/figures.R
& "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/aims-assets.R
& "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/local-images.R
& "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/build-speaker-notes.R
& "C:\Program Files\Positron\resources\app\quarto\bin\quarto.exe" render
```

Build the figures with Windows R: on Windows `ggplot2`'s `sans` family is Arial, which matches
the AIMS template.

Figures are built by a standalone script rather than by executable chunks in the `.qmd`, so
the deck can be rebuilt on a machine that has Quarto but not `ssdtools`. Regenerate them
only when `R/figures.R` changes.

R dependencies: `ggplot2`, `dplyr`, `tidyr`, `tibble`, `forcats`, `scales`, `patchwork`,
`ssdtools`, `ssddata`.

## Presenting

Open `_output/talk/index.html` and press **`s`** for the speaker view (notes, timer, next
slide). The deck is self-contained — no network connection required in the room. Most slides
build up over several clicks (fragments), and the notes mark each one.

## Handover

For an organiser's machine, after `quarto render`:

```bash
Rscript R/export-deck.R     # -> _output/handover/
```

This writes three files from the same render, so they match slide for slide:

| File | Use |
|---|---|
| `fisher-rexchange-perth-2026.html` | The deck itself. One file, about 12 MB, with every image inside it, including the AIMS ones. Opens in Chrome, Edge or Firefox with no network. Press `s` for speaker notes, which open in a second window. |
| `fisher-rexchange-perth-2026.pptx` | One full-slide picture per click, with the notes for that click in PowerPoint's notes pane, so presenter view works and advancing a slide steps through a build as the HTML does. Slide text is not editable. |
| `fisher-rexchange-perth-2026.pdf` | One page per click, no notes. The format any venue can show. |

The PDF and PowerPoint omit the footer line. Every file in `_output/handover/` embeds the AIMS
template assets and the pictures in `talk/local/`, so the folder is git-ignored and is built
only where the source decks are present.

The PDF has one page per click because the deck sets `pdf-separate-fragments`. To give each
page its own notes, `R/export-deck.R` counts the clicks on each slide in the rendered HTML and
splits that slide's notes at its "Click" directions. It stops if the two counts differ, so a
fragment added to a slide needs a matching `> Click` line in its notes.

The PowerPoint is built from pictures because Quarto's own pptx writer cannot use
`custom.scss`: its output had the AIMS styling only on the two AIMS image slides and put the
title-slide collage on slides of its own, so the format was removed from `talk/index.qmd`.
`R/export-deck.R` needs Edge or Chrome, Quarto, `pdftools`, `xml2` and `officer`. `officer` is
installed in the author's WSL R but not in Windows R 4.5.1.

## The software this talk is about

| Package | Where |
|---|---|
| `ssdtools` — species sensitivity distributions | [bcgov/ssdtools](https://github.com/bcgov/ssdtools) · [Poisson Consulting](https://github.com/poissonconsulting) |
| `bayesnec` — Bayesian concentration–response modelling | [open-AIMS/bayesnec](https://github.com/open-AIMS/bayesnec) |
| `epower` — power analysis for BACI designs | [bmtglobal/epower](https://github.com/bmtglobal/epower) |
| `FSSgam` — full-subsets model selection | [beckyfisher/FSSgam](https://github.com/beckyfisher/FSSgam) |
| `ElicitN` — expert elicitation | [beckyfisher/ElicitN](https://github.com/beckyfisher/ElicitN) |

Key references: Fisher et al. (2012) *Env. Modelling & Software* 30:1 · Fisher et al. (2018)
*J. Applied Ecology* 55:415 · Fisher et al. (2019) *Methods Ecol. Evol.* 10:1843 · Fisher &
Fox (2023) *Env. Toxicol. Chem.* 42:2019 · Fisher et al. (2024) *J. Statistical Software*
110 · Thorley et al. (2025) *JOSS* 10:7492.

## Data

The SSD figures use the CCME boron dataset shipped with `{ssddata}`. **No confidential
industry data is included in this repository**, and none is required to reproduce anything
here — see `CLAUDE.md` §4.

Publisher PDFs of the background literature and the large source `.pptx` decks are
deliberately excluded from version control (copyright, repo size); they exist only in the
author's local working directory.

## The productivity claim

The AI section makes an empirical claim about what changed with an AI assistant. It is
**measured, not asserted**:

```bash
Rscript R/git-evidence.R    # clones the public repos, writes data/*.csv
```

Across **1,340 commits** authored by Rebecca in seven public repositories, comparing commits
that carry a `Co-Authored-By: Claude` trailer against all the rest:

| Category | Before | With an AI assistant |
|---|---|---|
| Tests | 3% | 10% |
| Packaging, CI, CRAN | 4% | 20% |
| Source code | 41% | 25% |

And one package end to end: `FSSgam` was created in September 2018 and got its first test
file and its first CI workflow on the **same day, 20 June 2026** — 7 years and 9 months
later. Writing those tests surfaced two silent bugs that had been shipping since 2018.

Caveats are stated on the slide and in `notes/visuals-brief.md`: public repos only, the
trailer definition is a conservative floor, and the unit is a file touch rather than lines
or commits.

## AI disclosure

This talk was prepared with AI assistance (Claude Code). Every session is logged in
`prompts/`, in line with the working-directory convention at `C:/Rworking/CLAUDE.md` §10.
All factual claims, figures and statistical content have been checked by the author.

## Licence

- **Content** (slides, notes, text, generated figures): [CC BY 4.0](LICENSE)
- **Code** (`R/`, `.scss`, `.lua`): [MIT](LICENSE-CODE)
- **`talk/external/`**: reproduced from WAMSI reports under
  [CC BY 3.0 AU](https://creativecommons.org/licenses/by/3.0/au/); not covered by this
  repository's licence. Attribution in `talk/external/README.md`.
- **AIMS template assets** (logos, Coat of Arms, photographs, staff portraits) are not in the
  repository and are not licensed by it.
- **Pictures from the speaker's earlier slides** (`talk/local/`: stock photographs, journal
  covers, published figures) are not in the repository and are not licensed by it.

## Citation

See [`CITATION.cff`](CITATION.cff), or use GitHub's *Cite this repository*.
