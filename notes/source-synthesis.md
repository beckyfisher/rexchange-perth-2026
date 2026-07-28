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
| `tripple_planetary_crisis.png`, `confidential.jpg`, `stopsign.png` | Reusable image assets | Copied to `assets/` |

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

## What NOT to duplicate

The previous decks already exist and some of this audience may have seen the ecotox
versions. For R Exchange the *science* is the setting, not the subject. Specifically:

- Do **not** re-teach the SSD in detail (2 slides max, as a device for "this is what the
  software computes").
- Do **not** walk through the Barrow Island analysis. Use it only as the "black data"
  exhibit.
- Do **not** repeat the ZoHI/ZoMI/ZoI trigger table.
- **Do** reuse: the blood-alcohol analogy, the white/grey/black framing, the
  model-averaging-over-model-selection argument, and the "thresholds have error rates"
  point — all recast as *software* arguments rather than *ecotoxicology* arguments.
