# Source synthesis

What was read, and what was extracted from it. This is the evidence base for the talk —
every claim in `talk/index.qmd` should be traceable to something here.

## Sources read

### `old_talks_and_background/`

| File | What it is | Used for |
|---|---|---|
| `ANZG_WQ.pptx` (21 slides + notes) | Most recent talk. "Protecting Australia's marine communities from pollution: the problem of estimating 'no effect'" | Framing of the pollution problem; SSD explanation; ssdtools/Burrlioz evaluation; bayesnec & NSEC |
| `Fisher_11_Integrating_data_on_processes_and_change.pptx` (35 slides + notes) | AIMS 50th Anniversary invited talk, "Statistical modelling to support effective and sustainable environmental management" | The four research areas; **white/grey/BLACK literature**; epower; industry-data argument |
| `SETAC-Darwin_Fisher_Mon8th_July_11am_shorter.pptx` (22 slides + notes) | SETAC Darwin 2019, "Linking ecotoxicology and decision science" | Barrow Island case study; 33 exposure metrics; ROC-based probabilistic thresholds; management zones |
| `Talk_notes_extended_abstract_draft.docx` | Extended abstract for the above | Equations, threshold definitions, zone/trigger table |
| `Abstract.docx` | Short abstract for the AIMS 50th talk | Preferred framing sentence (see below) |
| `Rebecca_Fisher_bio_WQ.docx` | Speaker bio | Bio for the abstract submission |
| `Cirriculum Vitae_RFisher2025.docx` | Full CV | Software list, publication chronology, employment chronology |
| `tripple_planetary_crisis.png`, `confidential.jpg`, `stopsign.png` | Third-party clip art | Not committed. The stop sign and a CONFIDENTIAL stamp were once redrawn in `R/figures.R`; both drawings were removed on 2026-10-06, and the stamp shown now is the one on `slides.pptx` slide 8, used locally from `talk/local/` |
| `slides.pptx` (8 slides + notes) | Added by the speaker on 2026-10-06: slides gathered from her ANZG, SETAC Darwin and AIMS 50th talks | Slide 1 (blood-alcohol limit) adapted as *The legal limit*; slides 2–7 (exposure, *in situ* mortality, concentration–response, error-rate thresholds, management zones) rebuilt as the five-slide dredging sequence; slide 8 (white, grey and black literature) for that slide. Pictures extracted locally by `R/local-images.R`, never committed |
| `SETAC AP Produced water_WET.pptx` (3 slides + notes) | Title, AIMS and team slides from the speaker's SETAC Asia-Pacific produced-water talk, on the AIMS template | Slides 2 and 3 reused as the deck's AIMS introduction; the template's title and content masters give the deck its styling (see `notes/visuals-brief.md`). Extracted locally by `R/aims-assets.R`, never committed |

### `Relevant_publication_history_pdfs/` (19 PDFs)

Read via a custom text extractor (see `prompts/`). The set traces the arc:

- **2011** `Fisher_etal2011` (Cons. Letters), `Fisher_etal2011PLoSONE` — semi-automated text/data
  mining of research effort. First "I wrote a lot of scripts" phase.
- **2012** `Fisher_etal2012` (Env. Modelling & Software) — **ElicitN**. The origin story.
- **2015** `Fisher_etal2015` (Current Biology), `Fisher_etal2015PlosONE`, `Jones_etal2015` (PLoS ONE) —
  expert elicitation results; dredging water-quality time series.
- **2018** `Fisher_etal2018-Ecology_and_Evolution` — **FSSgam** ("a simple function for
  full-subsets multiple regression"); `Fisher_etal2018-Journal_of_Applied_Ecology` —
  probabilistic dose–response and thresholds (Barrow Island); `vanDam_etal2018_extended_abstract`.
- **2019** `Fisher_etal2019-MEE` — **epower**; `Fisher_etal2019-Nature_Communications` —
  synergistic/antagonistic impacts; `Fisher_etal2019_Key_Issues_in_GV` — workshop report.
- **2021** `Fox_etal2021` (ET&C) — recent developments in SSD modelling; `Fisher_etal2021`.
- **2023** `Fisher_etal2023IEAM`, `Thomas_etal2023` — NSEC, microbiome guideline values.
- **2024** `Fisher_etal2024` (J. Stat. Software) — **bayesnec**.
- **2025** `Thorley_etal2025` (JOSS) — **ssdtools v2**; `warne-etal-2025`;
  `Thomas_etal2025` — site-specific guidelines for marine microbiomes.

### `Relevant_publication_history_pdfs/dredging_reports/`

Added 2026-10-06: four WAMSI Dredging Science Node reports, all released under CC BY 3.0 AU unless otherwise noted.
Text was extracted with `pdftools`; candidate figures were found from their captions and
inspected as rendered pages.

| File | What it is | Used for |
|---|---|---|
| `Dredging-Science-Synthesis-Report-Theme-4-…-Jones-et-al-March-2019.pdf` | Jones, Fisher, Bessell-Browne, Negri & Duckworth (2019), Theme 4 synthesis report (36 pp.) | Figure 19, the turbidity events against the possible and probable thresholds; a backup slide until the speaker removed it on 2026-10-09 |
| `Fisher_etal2019_WAMSI_DSN_Theme4.9_FINAL.pdf` | Fisher, Jones & Bessell-Browne (2019), Report of Theme 4, Project 4.9 (128 pp.), including Project 4.9.4 on deriving and operationalising thresholds | Figure 6 of 4.9.4, the *Porites* time sequence, on the industry-data slide and the title slide |
| `Fisher_etal2019_WAMSI_4.9.pdf` | An earlier version of the same Project 4.9 report (123 pp.) | Not used; the final version was preferred |
| `Dredging-Science-Final-Report-PROJ-4.2-…-Fisher-et-al-April-2017.pdf` | Fisher et al. (2017), Project 4.2, effects of dredging on water quality | Not used. Candidate figures considered and passed over for this deck: the turbidity and light record before and during dredging, and the distance-decay plots |

Other candidates seen and not used: the aggregate distance-decay plot with the impact zones
(too dense to read on a slide, and the source decks already advise against repeating the zone
scheme), the Pilbara monitoring-site maps, and the sediment-smothering photographs.

## Recurring themes

1. **Balance, not protection.** Every deck opens with the same framing: environmental
   management "balances environmental protection against development costs". Never
   anti-development; always *informed, risk-weighted*.
2. **Thresholds are the interface between science and decision.** Guideline values,
   triggers, DGVs — numbers that make things stop or continue.
3. **Uncertainty is the product, not a caveat.** Bayesian and probabilistic methods are
   chosen *because* they give uncertainty that can be carried into a decision framework.
4. **Model averaging over model selection.** Both for SSDs (which distribution?) and
   concentration–response (which curve?) — there is no theoretical basis for picking one,
   so don't.
5. **Statistical error has a cost, and the cost is asymmetric.** Type I → financial loss
   to a developer. Type II → irreversible environmental harm. Formal decision science
   would balance these against a cost model; in practice it almost never does.
6. **Real problems, real data, real solutions.** Industry collaboration is framed as a
   scientific *advantage*, not a compromise — it buys access to data no research grant
   could fund.
7. **Accessible tools change practice.** Repeated explicitly: building "practical tools",
   "user-friendly tools", "accessible solutions" is how better methods actually get
   adopted by consultants and regulators.

## Preferred terminology (use these exact phrases)

- "quantitative ecologist" / "ecological risk assessment modeller"
- "fit-for-purpose"
- "guideline values (GVs)", "default guideline values (DGVs)", "water quality guideline
  values (WQGVs)"
- "the environmental equivalent of the 0.05 blood alcohol driving limit" — her signature
  analogy for a DGV. **Reuse it.**
- "species sensitivity distribution (SSD)" — "the workhorse of guideline derivation"
- "concentration–response (C-R)", not "dose–response", in the ecotox work
- "no-effect" always in scare quotes
- NEC / NSEC / N(S)EC / ECx / NOEC
- "protection of x% of the community" — PC99 / PC95 / PC90 / PC80
- "pressure pathway", "exposure metric", "hazard profile"
- "high power" vs "low alarm rate" thresholds; "possible" vs "probable" mortality
- "Zone of High Impact (ZoHI) / Moderate Impact (ZoMI) / Influence (ZoI)"
- "white, grey and **black** literature" — her coinage for confidential industry data
- "→" as the connector on slides (used constantly)

## Visual style

- **Sparse text, big concepts.** Bullets are fragments, not sentences. Arrows do the work.
- **One idea per slide, built up in layers.** The same base slide recurs with successive
  reveals (the SSD slide appears ~6 times, gaining annotation each time). This is her
  strongest habit — carry it over as reveal.js incremental fragments.
- **Schematic redraws over screenshots.** Plots are simplified, hand-annotated with
  labels like "Which model to fit?", "5%", "PC95".
- **Consistent colour-coded motifs**: the three pressure pathways (suspended sediment /
  light availability / sediment covering) as a repeated three-box diagram; receptor icons
  (coral, sponge, barnacle, seagrass).
- **Title = topic, subtitle = the specific question.** e.g. "WQGV derivation - SSDs" /
  "Which model to fit?"
- Numbered running threads: "1." and "2." markers persist across slides to show where you
  are in a two-part argument.
- Ends on a plain thank-you slide with email + GitHub handles.

## Key technical concepts available to reuse

| Concept | One-line version | Source |
|---|---|---|
| DGV as blood alcohol limit | The number that makes activity stop | ANZG_WQ s6 |
| SSD | Fit a distribution to per-species toxicity estimates, read off the concentration protecting x% of the community | ANZG_WQ s7–s8 |
| Model averaging (SSD) | No theoretical basis to choose a distribution → average over them, weighted | ANZG_WQ s9–s10 |
| Burrlioz 2.0 vs ssdtools | One distribution, closed → many distributions, open | ANZG_WQ s11–s14 |
| Simulation benchmarking | Known "true" value → bias and coverage; more distributions beat fewer | ANZG_WQ s13 |
| NEC / NSEC / ECx / NOEC | Four ways to say "no effect", only one of which means it | ANZG_WQ s16–s19 |
| N(S)EC | Model-average NEC and NSEC into a single "no effect" estimate with uncertainty | ANZG_WQ s19 |
| 33 exposure metrics | Intensity × frequency × duration across three pressure pathways | SETAC s10 |
| ROC thresholds | Trade true-positive against false-positive; pick by decision goal | SETAC s16–s18 |
| Possible vs probable | High-power threshold vs low-alarm-rate threshold | SETAC s17–s18 |
| BACI + power | epower; regulators ask for power 0.8 and ignore Type I | AIMS50 s9–s12 |
| White/grey/black literature | Confidential industry data as a third, unexploited tier | AIMS50 s34 |
| Barrow Island scale | >1500 coral heads, fortnightly, 530 days; WQ every 10 min | AIMS50 notes s33 |

## Technical correction (author, 2026-07-28)

An early draft of the talk opened on a dredge stopping against a turbidity trigger and then
went straight into the SSD — implying the dredging thresholds were SSD-derived. **They were
not.** That is two separate bodies of work:

- **Dredging thresholds** (Barrow Island): *in situ* dose–response relationships between
  dredging exposure metrics and the Bayesian posterior probability of non-zero coral
  mortality, with thresholds read off **ROC curves** on Type I / Type II error. One
  habitat-forming receptor, one site, one campaign — an SSD was neither used nor available.
  **Fisher et al. (2018) *J. Appl. Ecol.* 55:415.** This work **predates** the SSD work.
- **Guideline values** (`ssdtools`, `bayesnec`): default guideline values derived from
  laboratory toxicity estimates across many species via an SSD. ~2020 onwards.

The `discharge-first` branch responded by opening on a licensed discharge. On `main` the talk
names both numbers on one slide (the dredge trigger and the discharge limit), shows the
dredging thresholds in era two, and introduces the SSD separately in era three, so the two
routes stay apart.

See `notes/slide-outline.md` §"Routes to a regulatory number".

## What NOT to duplicate

The previous decks already exist and some of this audience may have seen the ecotox
versions. For R Exchange the *science* is the setting, not the subject.

On 2026-10-06 the speaker revised two earlier limits here. The Barrow Island analysis is now
walked through, in five slides rebuilt from her SETAC Darwin sequence, ending on the WA EPA
impact zones; and the SSD is built up over two slides, as in her ANZG deck. Both are short
steps with the point written on the slide, and both serve the software argument: the first
ends on thresholds in regulatory use whose code was never packaged, the second on the
model averaging that `ssdtools` does and Burrlioz did not.

- Do **not** repeat the ZoHI/ZoMI/ZoI trigger table; the zones appear only as the picture the
  thresholds are projected onto.
- **Do** reuse: the blood-alcohol analogy, the white/grey/black framing, the
  model-averaging-over-model-selection argument, and the "thresholds have error rates"
  point — all recast as *software* arguments rather than *ecotoxicology* arguments.

## Corrections and checks before delivery

Made on 2026-10-06 while finalising the deck for the 15-minute slot.

- **Length of the `ssdtools` report.** Earlier drafts said 183 pages, with no source. The
  ANZG deck (slide 14) says "more than 166 pages". The page count has been dropped from the
  slide and notes.
- **ElicitN.** Earlier notes said it produced "the first expert-based estimate of global coral
  reef diversity". The 2015 *Current Biology* paper does not claim "first". It says expert
  elicitation of species richness "has been previously recognized and exploited", citing
  Appeltans et al. (2012, all marine species, "a more informal approach") and Joppa et al.
  (2011, flowering plants), and it compares its result with an earlier coral reef estimate
  (Knowlton et al. 2010). What it does claim is narrower: "there are no estimates for other taxa
  that estimate uncertainty in the way we have done here". So "first" may be true for coral reefs
  specifically, but no source here states it, and the deck does not use it. The slide shows the
  result instead: 830,000 species (95% credible interval 550,000–1,330,000), from 97 elicitations
  with 62 taxonomists. The author contributions record that R.F. and R.A.O. developed the
  software. The script counts (25 statistical, 32 Tcl/Tk) and SourceForge distribution are
  confirmed by the 2012 paper.
- **`ssdtools` evaluation results.** Now worded from the ANZG deck (slides 11–14): the stated
  aim was "collective agreement between the Australian and Canadian experts"; on benchmark data
  there was no systematic difference from Burrlioz but substantial differences for individual
  data sets; on simulated data `ssdtools` performed better, and more distributions improved its
  estimates. The quoted outcome "collective agreement on the recommendations between ANZG and
  ECCC" is from the speaker's notes on slide 14.
- **The two strands of era two.** The AIMS 50th notes (slide 27) record that the Barrow Island
  dredging and thermal-stress analysis (*Nature Communications* 2019) used FSSgam. So a
  general package did reach the industry data; what never came back out as a reusable tool was
  the threshold analysis. The slide wording ("code written for one project") is accurate, and
  the anticipated questions cover the point.
- **Talk slot.** The programme lists the talk at 2:15–2:30pm on day two, 15 minutes, with
  questions at a session Q&A at 3:00pm. Earlier notes assumed 20 minutes in session three.

## The speaker's statements, 2026-10-06

Made in her review of the deck, and used on the slides on her authority. Not yet traced to a
document in this folder.

- The dredging thresholds "made it into the WA regulatory guidance documents". The WAMSI
  reports confirm that the thresholds were derived to delineate the impact zones of the WA EPA
  (2016) Technical Guidance on marine dredging proposals; which edition of the guidance cites
  them is to be confirmed.
- The Barrow Island corals were monitored every two weeks "for nearly 2 years". The earlier
  figure of 530 days is the water quality record on her SETAC Darwin slide, and the *Porites*
  sequence runs to day 534.
- "I have never seen a monitoring program like it replicated, and no research funding scheme
  would ever cover anything even vaguely close."
- Regulators do not directly care whether code is on CRAN.

`ssdtools` v2 (Thorley et al. 2025, *JOSS* 10:7492) is by Joe Thorley, Rebecca Fisher, David Fox
and Carl Schwarz. The original package is Thorley & Schwarz (2018).

## The speaker's register

The narration was rewritten on 2026-10-06 to match how the speaker writes her own speaker
notes, taken from the notes pages of the ANZG, AIMS 50th, SETAC Darwin and SETAC Asia-Pacific
decks. Those notes are first person and explanatory: "I've been working on…", "The second area
I want to talk about is…", "So each point in this plot represents…". They state a result and
continue, without staged pauses, rhetorical questions or slogans. Where the speaker has a
phrasing of her own (the blood-alcohol analogy, white, grey and black literature, "financial
loss to a developer" against "irreversible environmental harm", "I've never seen a research
funding program that has gotten close"), the notes use it.
