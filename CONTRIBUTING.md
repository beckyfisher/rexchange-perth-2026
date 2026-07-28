# Contributing

This is a **talk repository** — the deliverable is one presentation on one date, not a
library with users. Contributions are welcome in a narrower sense than usual.

## What's most useful

- **Factual corrections.** Dates, package names, publication details, attributions. If
  something in the deck is wrong, please say so — every claim should be traceable to
  `notes/source-synthesis.md` or the published record.
- **Accessibility fixes.** Missing or unhelpful `fig-alt`, contrast problems, text too small.
- **Figure improvements** in `R/figures.R`, provided the figure still makes the same point.

## What to raise first

Open an issue before a PR if you want to change the *argument* — the structure, the running
order, or which lessons are drawn. The narrative is load-bearing and heavily timed
(`notes/slide-outline.md`); a change on one slide usually costs time on another.

## Working on it

```bash
Rscript R/figures.R     # regenerate figures into talk/figures/
quarto render           # build slides + abstract into _output/
```

Neither tool is on `PATH` on the author's machine — see `README.md` for the absolute paths.

### House rules

- Follow `C:/Rworking/CLAUDE.md` (working-directory conventions) and this repo's
  `CLAUDE.md`.
- R style: snake_case, native pipe `|>`, tidyverse for analysis code.
- **Never hand-edit `talk/figures/`.** Change `R/figures.R` and regenerate.
- Comment at decision points — explain *why* an approach was chosen over a plausible
  alternative, not what the code does.
- Keep the timings table in `notes/slide-outline.md` in sync with the deck. If you add a
  slide, say what you'd cut.
- Don't commit publisher PDFs, source `.pptx` files, or anything derived from confidential
  industry data. See `.gitignore` and `CLAUDE.md` §4.

### AI-assisted contributions

Disclose them, and log the session to `prompts/` following the existing format. That
convention is the subject of one of the slides; it would be a poor look to skip it here.

## Code of conduct

Participation is governed by [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md).
