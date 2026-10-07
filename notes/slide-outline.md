# Slide outline and timings

Deck: `talk/index.qmd` → `_output/talk/index.html`. Press `s` in the rendered deck for the
speaker view (notes, timer and next slide).

The slot is **15 minutes**, 2:15–2:30pm on day two (15 October 2026), between Matt Fraser
(Minderoo, 2:00pm) and François Michonneau (Posit, 2:30pm). Questions are taken in a combined
session Q&A at 3:00pm, so all 15 minutes are talk time and the next speaker starts on time.

There are 25 slides and 29 clicks within them, so the deck steps 54 times. Most of what is
said is written on the slides, which build up one click at a time, and the notes hold only the
sentences that join them. The timing markers in the notes add to 14:00 at 140 words a minute;
the speaker talks faster than that, and the remainder of the 15 minutes is the allowance for
clicks and pauses. A slide added means time taken from another.

> **Two versions exist.** `main` is the version described here. The `discharge-first` branch is
> an earlier 20-minute cut that opened on a licensed discharge. It has not been updated for the
> AIMS template, the dredging figures, the 15-minute slot or the rewritten notes.

---

## Structure

The talk opens with the AIMS introduction and the team, states what a legal limit is, and then
walks the timeline from left to right.

1. **Introduction** (slides 1–3). Title, AIMS, and the tropical ecotoxicology and risk
   assessment team, whose areas include dredging.
2. **The legal limit** (slide 4). Guideline values as the environmental equivalent of the 0.05
   blood alcohol driving limit, and the same kind of limit for dredging. The slide ends on
   "Increasingly, these limits come out of open-source R code."
3. **Code and regulation** (slide 5). The speaker's own code since 2010, by how it was shared,
   with the two pieces used in regulation marked separately. The y-axis is how the code was
   shared; regulatory use is not a level on it, because regulators use results whatever the
   code's state, and the dredging thresholds, whose code was never shared, are in WA guidance.
4. **Three eras** (slides 6–19). Era one, ElicitN. Era two: white, grey and black literature,
   the Barrow Island data, the five-step build from exposure to thresholds in management, and the
   packages on GitHub that never met the industry work. Era three: the packages on CRAN, the SSD
   built up in two slides, the `ssdtools` evaluation, and why open source mattered to it.
5. **AI-assisted coding** (slides 20–25). The measured change in the commit history, one
   package in detail, what is now routine and what is not, and the two points to take away.

### Routes to a regulatory number

The talk shows two different statistical routes to a number that stops an activity. They are
separate bodies of work from different periods and must not blur together.

| | Site-specific thresholds | Guideline values |
|---|---|---|
| Method | *In situ* concentration–response for one receptor, with ROC curves on type I and type II error | Species sensitivity distribution over many species' toxicity estimates |
| Data | Industry monitoring data ("black literature") | Laboratory toxicity tests |
| Software | Bespoke Bayesian models (JAGS and R), never packaged | `ssdtools`, `bayesnec` |
| Scope | One campaign, one site | Every discharge in the country |
| Slides | 8–13 | 16–19 |
| Reference | Fisher et al. 2018, *J. Appl. Ecol.* 55:415 | Fox et al. 2021; Fisher et al. 2024; Thorley et al. 2025 |

The dredging thresholds were never derived from an SSD, and could not have been: there was one
habitat-forming receptor, one site and one campaign.

### Industry work and packages in era two

| | Industry work | Packages |
|---|---|---|
| What | Barrow Island dredging; *in situ* concentration–response and ROC | `FSSgam`, `epower` |
| Data | Confidential, cannot be distributed | Public, shareable |
| Stakes | Thresholds still in regulatory use | No regulation depends on either |
| Code | Written for one campaign | Installable packages |
| Slides | 8–13 | 14 |

Slide 14 states the pattern: the higher the stakes, the less shareable the tooling. The speaker
has not solved it and says so, and it returns as the second point to take away on slide 24.

---

## Slide by slide

Clicks are counted from the slide's first appearance; each is marked in the notes by a "Click"
direction.

| # | Slide | Visual | Content | Clicks | Time |
|---|---|---|---|---|---|
| 1 | Title | AIMS front cover; dredge photograph, boron SSD, three *Porites* photographs | Programme title, name, event. | 0 | 0:05 |
| 2 | Australian Institute of Marine Science | Slide 2 of the SETAC Asia-Pacific deck | AIMS: sites, purpose. | 0 | 0:20 |
| 3 | Tropical Ecotoxicology and Risk Assessment | Slide 3 of the SETAC Asia-Pacific deck | The team and its areas. | 0 | 0:30 |
| 4 | The legal limit | Outfall and breath-test photographs | Guideline values; the 0.05 blood alcohol limit; above and below the limit; dredging limits; increasingly from open-source R code. | 4 | 0:40 |
| 5 | Code and regulation, 2010–2026 | `code-timeline.png`, then `code-timeline-regulation.png` | The speaker's code by how it was shared; the two used in regulation; only `ssdtools` can be run by anyone else. | 2 | 0:45 |
| 6 | Era one · ElicitN | `reef-richness.png` | 57 scripts, no package; used for the coral reef species estimate; unreproducible within five years. | 2 | 0:45 |
| 7 | Era two · White, grey and black literature | Journal covers, grey literature, CONFIDENTIAL and a black box | Papers, reports, industry monitoring data. | 3 | 0:30 |
| 8 | Era two · Barrow Island monitoring data | *Porites* time sequence (Fisher, Jones & Bessell-Browne 2019, Fig. 6) | 1,500 colonies every two weeks for nearly two years; never replicated. | 1 | 0:35 |
| 9 | Era two · Dredging exposure | Three pressure pathways; water quality traces along the foot | Exposure metrics from the water quality data. | 0 | 0:20 |
| 10 | Era two · Coral mortality | Posterior densities; coral photographs along the foot | Probability of non-zero mortality at each site. | 0 | 0:25 |
| 11 | Era two · Concentration–response in the field | Fitted curve over both strips | Exposure + mortality → concentration–response from field data. | 0 | 0:20 |
| 12 | Era two · Thresholds from error rates | Curve and ROC | False alarm against missed impact; possible and probable thresholds. | 0 | 0:35 |
| 13 | Era two · Thresholds in dredging management | Thresholds projected onto the WA EPA impact zones | Still in regulatory use; never packaged. | 1 | 0:30 |
| 14 | Era two · Industry work and packages | Two columns | `FSSgam`, `epower`; the higher the stakes, the less shareable the tooling. | 2 | 1:05 |
| 15 | Era three · Packages on CRAN | Text | `bayesnec`, `ssddata`, `ssdtools`; CRAN as the first external standard. | 2 | 0:35 |
| 16 | Era three · Species sensitivity distributions | `ssd-step-1` to `ssd-step-3` | Points, a fitted distribution, the PC95 as the default guideline value. | 3 | 0:35 |
| 17 | Era three · Choice of distribution | `ssd-step-4`, `ssd-step-5` | PC95 from 1.07 to 1.77 mg/L; Burrlioz fitted one; `ssdtools` averages. | 2 | 0:35 |
| 18 | Era three · Evaluation of `ssdtools` | Text, two columns | AU–CA project; benchmark and simulated data; recommendation; how the speaker came to be on it. | 5 | 0:50 |
| 19 | Open source and regulatory agreement | Punch line, black box | Three regulators cannot audit a black box; reading the source; the Shiny app. | 2 | 0:30 |
| 20 | Divider · AI-assisted coding | None | Transition. | 0 | 0:05 |
| 21 | The change since June | `where-work-goes.png` | Stopped writing code by hand in June; 1,340 commits; tests 3→10%, packaging 4→20%, source 41→25%. | 0 | 1:00 |
| 22 | `FSSgam`, 2018 to 2026 | Text, two columns | Seven years nine months without tests; four days; two silent bugs. | 0 | 0:50 |
| 23 | Routine work and judgement | Two columns | Now routine against still the speaker's; the Burrlioz standard applies to model-written code. | 0 | 0:40 |
| 24 | Points to take away | Two points | Maintenance takes far less time; no good pattern for open tools on data that cannot be shared. | 0 | 0:40 |
| 25 | Contacts and acknowledgements | Links | Thanks; questions at the session Q&A. | 0 | 0:15 |

Four backup slides follow slide 25 and are not counted in the slide numbers: thresholds
against turbidity events (the WAMSI figure that was slide 8 before 2026-10-06), threshold
setting with ROC curves, PC95 by distribution, and estimates of "no effect". They are for the
session Q&A.

### If running long

In order of what to drop first:

1. Slide 22, `FSSgam`. Say its last paragraph (the two silent bugs) over slide 21.
2. The last line of slide 18, on how the speaker came to be on the project.
3. Slides 10 and 11. Go from *Dredging exposure* to *Thresholds from error rates*, and say that
   exposure was related to coral mortality in the field.

Do not take time from slides 14 or 24. They hold the second point to take away.

---

## Things that go stale

| What | Where | Why |
|---|---|---|
| "Four months" since June | anticipated questions | First AI co-authored commit: 20 June 2026. Correct for 15 October 2026. |
| The measured percentages | slides 21–22, `data/*.csv` | They cover 20 June – 22 July 2026 (36 commits on 4 days). Re-running `R/git-evidence.R` would give a larger sample, but would change the 1,340 quoted in the published abstract. |
| The team slide | slide 3 | Exported from the SETAC Asia-Pacific deck. Check the people on it are current. |
| "on GitHub" in the closing notes | slide 25 | The talk repository is private. Make it public before the talk or drop the sentence. |
| Timeline years | `code-timeline.png` | Reconstructed from the CV, not from CRAN metadata, apart from the 2021 CRAN date; see the comment in `R/figures.R`. |
| "used in WA dredging guidance" | slide 5, `code-timeline-regulation.png` | The speaker's statement of 2026-10-06. Name the guidance document in `notes/source-synthesis.md` once confirmed. |

---

## Room notes

- Adam Sparks presents privacy-preserving R pipelines at 1:45pm in the same session. If that
  talk touched on building tools around data that cannot be shared, slide 14 is the place to
  say so.
- The talk after this one (Posit) is on LLM tooling, so the audience is likely to come back to
  slides 21–23 in the Q&A.
- Expect a question on the "five times" claim. The answer is in the slide 21 notes: it is an
  impression; what was measured is the composition of the work.
- Expect a question on verifying AI-written code. Answer from slide 23: simulate, benchmark,
  check coverage against a known truth, as was done for Burrlioz.
- Do not get drawn into ecotoxicology detail. The backup slides are there if needed.
