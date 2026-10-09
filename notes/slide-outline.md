# Slide outline and timings

Deck: `talk/index.qmd` → `_output/talk/index.html`. Press `s` in the rendered deck for the
speaker view (notes, timer and next slide).

The slot is **15 minutes**, 2:15–2:30pm on day two (15 October 2026), between Matt Fraser
(Minderoo, 2:00pm) and François Michonneau (Posit, 2:30pm). Questions are taken in a combined
session Q&A at 3:00pm, so all 15 minutes are talk time and the next speaker starts on time.

There are 19 slides and 16 clicks within them, so the deck steps 35 times. Most of what is
said is written on the slides, some of which build up with clicks, and the notes hold only the
sentences that join them; the slide on species sensitivity distributions is shown complete,
with the explanation of the SSD in the notes. The timing markers in the
notes add to 12:35. Counting the words on the slides and the narration in the notes gives
about 14.8 minutes at 140 words a minute, and 13.0 at 160; the speaker talks faster than 140,
and the remainder of the 15 minutes is the allowance for explaining the figures, clicks and
pauses. A slide added means time taken from another.

The deck was 25 slides on 2026-10-06, after the speaker's first review: the dredging thresholds
were a five-slide build (exposure, coral mortality, concentration–response, thresholds from
error rates, thresholds in management) and the SSD took two slides. The speaker judged that too
long on 2026-10-07, and each was reduced to one slide. Reviewing that shorter version the same
day, she judged the animation overdone. Slide 4 went back to the original *Numbers in
environmental regulation* with two clicks, the timeline lost one click, the SSD and the
evaluation went back to the original single slides without clicks, and the open-source slide
lost its clicks. On 2026-10-09 she asked for the blood-alcohol picture and its two points,
from *The legal limit* in commit `1336127`, to be added to the SSD slide, and for the
open-source slide to be combined with the evaluation slide; it is now that slide's one click.
The longer version is commit `1336127`, and the version she first reviewed is on the branch
`pre-review-2026-10-06`.

> **Two versions exist.** `main` is the version described here. The `discharge-first` branch is
> an earlier 20-minute cut that opened on a licensed discharge. It has not been updated for the
> AIMS template, the dredging figures, the 15-minute slot or the rewritten notes.

---

## Structure

The talk opens with the AIMS introduction and the team, names the numbers that environmental
regulation depends on, and then walks the timeline from left to right.

1. **Introduction** (slides 1–3). Title, AIMS, and the tropical ecotoxicology and risk
   assessment team, whose areas include dredging.
2. **Numbers in environmental regulation** (slide 4). The turbidity trigger that stops a dredge
   and the concentration limit in a discharge licence, both defensible in court. The slide ends
   on "Increasingly, they come out of open-source R packages." The blood-alcohol analogy for a
   guideline value is on slide 12, beside the SSD.
3. **Improving statistical methods in regulation** (slide 5). The speaker's own code since
   2010, by how it was shared, with the two pieces used in regulation marked separately. The
   y-axis is how the code was shared; regulatory use is not a level on it, because regulators
   use results whatever the code's state, and the dredging thresholds, whose code was never
   shared, are in WA guidance. The title comes from the speaker's own notes ("my journey in
   improving statistical methods in environmental regulation"), shortened to fit one line.
4. **Three eras** (slides 6–13). Era one, ElicitN. Era two: white, grey and black literature,
   the Barrow Island data, the dredging thresholds on one slide (field concentration–response,
   ROC curves, the WA EPA impact zones), and the packages on GitHub that never met the industry
   work. Era three: the packages on CRAN, the SSD on one slide, and the `ssdtools` evaluation
   with, on one click, why open source mattered to it.
5. **AI-assisted coding** (slides 14–19). The measured change in the commit history, one
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
| Slides | 8–9 | 12–14 |
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
| Slides | 8–9 | 10 |

Slide 10 states the pattern: the higher the stakes, the less shareable the tooling. The speaker
has not solved it and says so, and it returns as the second point to take away on slide 18.

---

## Slide by slide

Clicks are counted from the slide's first appearance; each is marked in the notes by a "Click"
direction.

| # | Slide | Visual | Content | Clicks | Time |
|---|---|---|---|---|---|
| 1 | Title | AIMS front cover; dredge photograph, boron SSD, three *Porites* photographs | Programme title, name, event. | 0 | 0:05 |
| 2 | Australian Institute of Marine Science | Slide 2 of the SETAC Asia-Pacific deck | AIMS: sites, purpose. | 0 | 0:20 |
| 3 | Tropical Ecotoxicology and Risk Assessment | Slide 3 of the SETAC Asia-Pacific deck | The team and its areas. | 0 | 0:30 |
| 4 | Numbers in environmental regulation | `stop-sign.png` | The turbidity trigger and the discharge limit; defensible in court; increasingly from open-source R packages. Ends on the segue to fifteen years of R code. | 2 | 0:40 |
| 5 | Improving statistical methods in regulation | `code-timeline.png`, then `code-timeline-regulation.png` | The speaker's code by how it was shared; the two used in regulation, with the last line on the same click. | 1 | 0:50 |
| 6 | Era one · ElicitN | `reef-richness.png` | 57 scripts, no package; used for the coral reef species estimate; unreproducible within five years. | 2 | 0:45 |
| 7 | Era two · White, grey and black literature | Journal covers, grey literature, CONFIDENTIAL and a black box | Papers, reports, industry monitoring data. | 3 | 0:30 |
| 8 | Era two · Barrow Island monitoring data | *Porites* time sequence (Fisher, Jones & Bessell-Browne 2019, Fig. 6) | Required by the approval conditions for dredging; 1,500 colonies every two weeks for nearly two years; never replicated. | 1 | 0:35 |
| 9 | Era two · Dredging thresholds | Field concentration–response curve, then ROC curve, then the thresholds on the WA EPA impact zones | Concentration–response from field data; thresholds from ROC curves; the edges of the impact zones; still in regulatory use, never packaged. | 3 | 0:45 |
| 10 | Era two · Industry work and packages | Two columns | `FSSgam`, `epower`; the higher the stakes, the less shareable the tooling. | 2 | 1:05 |
| 11 | Era three · Packages on CRAN | Text | `bayesnec`, `ssddata`, `ssdtools`; CRAN as the first external standard. | 1 | 0:30 |
| 12 | Era three · Species sensitivity distributions | `ssd-model-average.png`; breath-test photograph and police cap | Default guideline values as the 0.05 blood alcohol driving limit, and what happens above and below it. In the notes: `ssdtools` as the work with the most impact; the SSD; `ssdtools` averages over distributions. | 0 | 1:00 |
| 13 | Era three · Evaluation of `ssdtools` | Text, two columns; black box on the click | AU–CA project; benchmark and simulated data; recommendation. On the click: three regulators cannot audit a black box; reading the source; the Shiny app. In the notes: the result, and how the speaker came to be on the project. | 1 | 1:30 |
| 14 | Divider · AI-assisted coding | None | Transition. | 0 | 0:05 |
| 15 | The change since June | `where-work-goes.png` | Stopped writing code by hand in June; 1,340 commits; tests 3→10%, packaging 4→20%, source 41→25%. | 0 | 1:00 |
| 16 | `FSSgam`, 2018 to 2026 | Text, two columns | Seven years nine months without tests; four days; two silent bugs. | 0 | 0:50 |
| 17 | Routine work and judgement | Two columns | Now routine against still the speaker's; the Burrlioz standard applies to model-written code. | 0 | 0:40 |
| 18 | Points to take away | Two points | Maintenance takes far less time; no good pattern for open tools on data that cannot be shared. | 0 | 0:40 |
| 19 | Contacts and acknowledgements | Links | Thanks; questions at the session Q&A. | 0 | 0:15 |

Three backup slides follow slide 19 and are not counted in the slide numbers: threshold
setting with ROC curves, PC95 by distribution, and estimates of "no effect". They are for the
session Q&A. A fourth, the WAMSI figure of thresholds against turbidity events, was removed at
the speaker's request on 2026-10-09.

### If running long

In order of what to drop first:

1. Slide 16, `FSSgam`. Say its last paragraph (the two silent bugs) over slide 15.
2. The last paragraph of the slide 13 notes, on how the speaker came to be on the project.
3. The narration after the last click on slide 10. The line on the slide states the point.

Do not take time from slides 10 or 18. They hold the second point to take away.

---

## Things that go stale

| What | Where | Why |
|---|---|---|
| "Four months" since June | anticipated questions | First AI co-authored commit: 20 June 2026. Correct for 15 October 2026. |
| The measured percentages | slides 15–16, `data/*.csv` | They cover 20 June – 22 July 2026 (36 commits on 4 days). Re-running `R/git-evidence.R` would give a larger sample, but would change the 1,340 quoted in the published abstract. |
| The team slide | slide 3 | Exported from the SETAC Asia-Pacific deck. Check the people on it are current. |
| "on GitHub" in the closing notes | slide 19 | The talk repository is private. Make it public before the talk or drop the sentence. |
| Timeline years | `code-timeline.png` | Reconstructed from the CV, not from CRAN metadata, apart from the 2021 CRAN date; see the comment in `R/figures.R`. |
| "used in WA dredging guidance" | slide 5, `code-timeline-regulation.png` | The speaker's statement of 2026-10-06. Name the guidance document in `notes/source-synthesis.md` once confirmed. |

---

## Room notes

- Adam Sparks presents privacy-preserving R pipelines at 1:45pm in the same session. If that
  talk touched on building tools around data that cannot be shared, slide 10 is the place to
  say so.
- The talk after this one (Posit) is on LLM tooling, so the audience is likely to come back to
  slides 15–17 in the Q&A.
- Expect a question on the "five times" claim. The answer is in the slide 15 notes: it is an
  impression; what was measured is the composition of the work.
- Expect a question on verifying AI-written code. Answer from slide 17: simulate, benchmark,
  check coverage against a known truth, as was done for Burrlioz.
- Do not get drawn into ecotoxicology detail. The backup slides are there if needed.
