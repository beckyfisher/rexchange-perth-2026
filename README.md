# Setting the legal limit with an R package

Talk materials for **[R Exchange Perth 2026](https://epi.group/events/r-exchange-perth-2026)**
(14–15 October 2026, Perth CBD).

> How a quantitative ecologist with no programming training ended up maintaining the R
> package that sets water quality limits in three countries — and what changed when she
> stopped writing code.

**Rebecca Fisher** · Australian Institute of Marine Science ·
[github.com/beckyfisher](https://github.com/beckyfisher)

---

## What's here

| Path | What it is |
|---|---|
| `talk/index.qmd` | The slides — Quarto `revealjs`, with speaker notes in `::: {.notes}` blocks |
| `talk/abstract.qmd` | Abstract (150- and 250-word versions), title options, speaker bio |
| `talk/custom.scss` | Slide theme; colours mirror `R/figures.R` |
| `talk/figures/` | Generated figures — **do not hand-edit** |
| `R/figures.R` | Reproducible figure code (`ggplot2`, `ssdtools`) |
| `notes/slide-outline.md` | Slide-by-slide outline with timings and the 15-minute cut |
| `notes/speaker-notes.md` | Full narration script + anticipated questions |
| `notes/visuals-brief.md` | Visual system, sourcing, alt text, suggested additions |
| `notes/source-synthesis.md` | What was read to build this, and the themes extracted |
| `assets/` | Static images reused from earlier decks |
| `prompts/` | Log of AI-assisted sessions (publication disclosure) |

## Reproducing

Requires R (≥ 4.4) and Quarto (≥ 1.4).

```bash
# 1. figures
Rscript R/figures.R

# 2. slides + abstract  ->  _output/
quarto render
```

On the author's Windows machine neither is on `PATH`:

```powershell
& "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/figures.R
& "C:\Program Files\Positron\resources\app\quarto\bin\quarto.exe" render
```

Figures are built by a standalone script rather than by executable chunks in the `.qmd`, so
the deck can be rebuilt on a machine that has Quarto but not `ssdtools`. Regenerate them
only when `R/figures.R` changes.

R dependencies: `ggplot2`, `dplyr`, `tidyr`, `tibble`, `forcats`, `scales`, `patchwork`,
`ssdtools`, `ssddata`.

## Presenting

Open `_output/talk/index.html` and press **`s`** for the speaker view (notes, timer, next
slide). The deck is self-contained — no network connection required in the room.

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

## AI disclosure

This talk was prepared with AI assistance (Claude Code). Every session is logged in
`prompts/`, in line with the working-directory convention at `C:/Rworking/CLAUDE.md` §10.
All factual claims, figures and statistical content have been checked by the author.

## Licence

- **Content** (slides, notes, text, figures): [CC BY 4.0](LICENSE)
- **Code** (`R/`, `.scss`): [MIT](LICENSE-CODE)

## Citation

See [`CITATION.cff`](CITATION.cff), or use GitHub's *Cite this repository*.
