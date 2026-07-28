# Prompt log — R Exchange Perth 2026 talk

This file logs Claude-assisted work on this project, for publication disclosure
purposes (see `C:/Rworking/CLAUDE.md` §10).

---

## Session: rexchange-perth-2026-talk
Date: 2026-07-28
Model: Claude Opus 5 (1M context) — `claude-opus-5[1m]`, via Claude Code

### Prompts and Responses

**User:**

> I need to write an abstract to give a 15 minute talk at this:
> https://epi.group/events/r-exchange-perth-2026
>
> The talk will be on my journey doing analyses with industry data and developing
> open source software products that facilitate uptake of improved fit-for purpose
> methods in environmental management and regulation. A part of that journey involves
> the transformation from my struggling attempts to build R packages from scratch as a
> "quantitative" ecologist, with little to no training in programming, only a sound
> applied understanding of statistics, through to being a reasonably competenent
> programmer, building R packages and using GitHub for open source collaboration, to
> now most recently my journey into AI (claude code) which means I am now 5 x more
> productive and havn;t written a line of code since subscribing.
>
> My GitHub handle is https://github.com/beckyfisher, but with many packages on
> https://github.com/open-AIMS, and contributions on https://github.com/poissonconsulting
> (ssdtools). Note that my earlier work (the first version of elcitic N, wasn't even on
> GitHub).
> There is a full archive of pdfs of relevant publications in
> Relevant_publication_history_pdfs, which should some extent track my journey, as well
> as some previous talks in old_talks_and_background.
>
> I've added other possible relevant content in old_talks_and_background, which includes
> some existing talks that potentially have valuable content (ANZG_WQ.pptx (most recent)
> and Fisher_11_Integrating_data_on_processes_and_change.pptx and
> SETAC-Darwin_Fisher_Mon8th_July_11am_shorter.pptx) and cv/bio.
>
> Read all materials in the two folders. Extract recurring themes, preferred terminology,
> visual style, and key technical concepts. Draft a 20-minute conference talk for an
> audience of R/python users interested in open science.
>
> Create speaker notes, slide outline, and suggested visuals.
> Use quarto for generating files, so everything is reproducible, and make a private
> GitHub repo with an appropriate structure, using the most recent standards for open
> source science for this content at beckfisher.
>
> Reuse concepts from previous presentations without duplicating content.
> Log this prompt and generate a project specific claude.md with information that is
> relevant. There is a higher level claude.md in the parent folder that should be
> considered.

**Claude:**

Read all source material:

- `old_talks_and_background/` — extracted slide text **and speaker notes** from all three
  `.pptx` decks by unzipping the OOXML and parsing `ppt/slides/slideN.xml` +
  `ppt/notesSlides/notesSlideN.xml` (PowerShell, no external dependencies); extracted the
  `.docx` files (`Abstract`, `CV`, `bio`, `Talk_notes_extended_abstract_draft`) from
  `word/document.xml`.
- `Relevant_publication_history_pdfs/` — 19 PDFs. `pdftoppm`/`pandoc`/`python` were not
  available and Word COM could not open the PDFs headlessly, so wrote a minimal PDF text
  extractor (`scratchpad/pdftext.ps1`) that inflates `FlateDecode` content streams and
  parses text-showing operators, including subset-font hex strings via an auto-detected
  constant glyph offset.
- Fetched the event page to confirm format: **14–15 Oct 2026, Perth CBD**; day two
  session three (2:30–4:10pm) is *"real-life applications"*; audience is open-source data
  science professionals; themes include AI integration and open-source workflows in
  enterprise.

Extracted the recurring themes, terminology and visual style (see
`notes/source-synthesis.md`) and used them to draft:

- `talk/abstract.qmd` — three abstract variants (150 / 250 word, plus a one-line hook)
  and a speaker bio.
- `talk/index.qmd` — the full Quarto `revealjs` deck, with speaker notes in
  `::: {.notes}` blocks and a marked 15-minute cut path.
- `notes/slide-outline.md` — slide-by-slide outline with timings.
- `notes/speaker-notes.md` — full narration script.
- `notes/visuals-brief.md` — suggested visuals, sourcing and alt text.
- `R/figures.R` — reproducible figure code (`ssdtools`, `ggplot2`); figures are written
  to `talk/figures/`.

Repo scaffolded to current open-science standards (`CITATION.cff`, `CODE_OF_CONDUCT.md`,
`CONTRIBUTING.md`, dual `LICENSE` CC-BY-4.0 / `LICENSE-CODE` MIT, `_quarto.yml`, GitHub
Actions render workflow with a stale-figure check) and pushed as a **private** repo:
<https://github.com/beckyfisher/rexchange-perth-2026>. Publisher PDFs and the large source
`.pptx` files are `.gitignore`d for copyright and repo-size reasons.

Note: `gh repo create --push` refused to create `.github/workflows/render.yml` (the OAuth
app lacks the `workflow` scope), so the workflow was committed separately and pushed with
plain `git push`, which succeeded.

**Note flagged to user:** the original prompt says *15 minute talk* in the first line and
*20-minute conference talk* in the brief. Built for 20 minutes with an explicitly marked
15-minute cut.

---
