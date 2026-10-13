# Slide outline and timings

Deck: `talk/index.qmd` → `_output/talk/index.html`. Press `s` in the rendered deck for the
speaker view (notes, timer and next slide).

The slot is **15 minutes**, 2:15–2:30pm on day two (15 October 2026), between Matt Fraser
(Minderoo, 2:00pm) and François Michonneau (Posit, 2:30pm). Questions are taken in a combined
session Q&A at 3:00pm, so all 15 minutes are talk time and the next speaker starts on time.

There are 20 slides and 33 clicks within them, so the deck steps 53 times. Most of what is
said is written on the slides, some of which build up with clicks, and the notes hold only the
sentences that join them; the slide on species sensitivity distributions is shown complete,
with the explanation of the SSD in the notes. Some slide text is shown but not read out, and
is left out of the handout notes (see the README, § "Handover"). The timing markers in the
notes add to 14:40. Counting the words she reads, the slide text she reads out and the
narration in the notes, gives about 15.8 minutes at 140 words a minute, and 13.8 at 160. The
count was 13.1 and 11.5 before the AI section was revised on 2026-10-13, and 14.8 and 13.0 on
2026-10-09, when it included all the slide text, read or not. The remainder of the 15 minutes
is the allowance for explaining the figures, clicks and pauses, and as it stands there is
none: the revised AI section needs about a minute taken from elsewhere. A slide added means
time taken from another.

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
On 2026-10-13 she added a click to five slides: the team slide turns "Guidelines/thresholds"
red, *Numbers in environmental regulation* ends on fifteen years of improving the statistical
methods, the timeline adds the three eras, ElicitN shows the coral reef estimate on a click,
and the evaluation of `ssdtools` replaces the recommendation with the Shiny app. She also asked
for the dredge plume and the outfall on slide 4, an era label on each era's slides, a graphic
of separating a method from confidential data on slide 10, and the ANZG website on slide 13.
Later that day she revised the AI section: `FSSgam` builds over three clicks and ends on its
CRAN release, *Routine work and judgement* builds over three, ending on AI use in open source
software as a rapidly evolving space, and a new slide, *`bayesnec`, June to October 2026*,
gives her account of the two months since the first measurement, from the package's public
history. A third point to take away, her advice from those two months, was added on its own
click. After a review of what others propose for checking code written by AI, the third point
became her own: AI now writes more than can be reviewed, and her answer is to understand what
would show the code is wrong and build simulations and tests to check it. At her request it was
then set on two lines, the second without an arrow because it extends the third point, and
shown on the same click as a drawn schematic of checking code against a known answer. The phrase "Reviewing it does not." was removed from the first point, so
that review is raised once. The
measurement of 2026-07-28 on slide 15 was left as it was run.
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
   assessment team, whose areas include dredging. On a click, the team's area
   "Guidelines/thresholds" turns red, as the step to the next slide.
2. **Numbers in environmental regulation** (slide 4). The turbidity triggers used to manage
   dredging and the concentration limit in a discharge licence, both defensible in court, beside
   a dredge plume and an outfall. "Increasingly, they come out of open-source R packages" is
   followed by the speaker's fifteen years on the statistical methods. The blood-alcohol analogy
   for a guideline value is on slide 12, beside the SSD.
3. **Improving statistical methods in regulation** (slide 5). The speaker's own code since
   2010, by how it was shared, with the two pieces used in regulation marked separately and the
   three eras added on the last click. The
   y-axis is how the code was shared; regulatory use is not a level on it, because regulators
   use results whatever the code's state, and the dredging thresholds, whose code was never
   shared, are in WA guidance. The title comes from the speaker's own notes ("my journey in
   improving statistical methods in environmental regulation"), shortened to fit one line.
4. **Three eras** (slides 6–13). Above the title, era one's slide is labelled "R scripts" and
   era two's slides "Industry data and GitHub", and era three's "CRAN". Era one, ElicitN. Era two: white, grey and
   black literature, the Barrow Island data, the dredging thresholds on one slide (field
   concentration–response, ROC curves, probabilistic thresholds for the management zones), and
   the packages on GitHub that never met the industry work, ending on a schematic of separating
   a method from confidential data. Era three: the packages on CRAN, the SSD on one slide, and
   the `ssdtools` evaluation with the ANZG website, then why open source mattered to it, then
   the Shiny app.
5. **AI-assisted coding** (slides 14–19). The measured change in the commit history to July,
   one package in detail, what is now routine and what is not, then `bayesnec` since July: the
   volume of commits, the bugs found in code written before and since June, issues opened as
   fast as they were closed, the work parked on `predev`, and reading, not writing, as the
   limit. The three points to take away follow, the third on what review of code written by AI
   should look like.

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
has not solved it and says so, and it returns as the second point to take away on slide 19.

---

## Slide by slide

Clicks are counted from the slide's first appearance; each is marked in the notes by a "Click"
direction.

| # | Slide | Visual | Content | Clicks | Time |
|---|---|---|---|---|---|
| 1 | Title | AIMS front cover; dredge photograph, boron SSD, three *Porites* photographs | Programme title, name, event. | 0 | 0:05 |
| 2 | Australian Institute of Marine Science | Slide 2 of the SETAC Asia-Pacific deck | AIMS: sites, purpose. | 0 | 0:20 |
| 3 | Tropical Ecotoxicology and Risk Assessment | Slide 3 of the SETAC Asia-Pacific deck; on the click, the same with "Guidelines/thresholds" in red | The team and its areas; its focus on guidelines and thresholds. | 1 | 0:30 |
| 4 | Numbers in environmental regulation | Satellite picture of a dredge plume, outfall photograph, `stop-sign.png` | The turbidity triggers and the discharge limit; defensible in court; increasingly from open-source R packages; about 15 years improving the statistical methods. | 3 | 0:40 |
| 5 | Improving statistical methods in regulation | `code-timeline.png`, then `code-timeline-regulation.png`, then `code-timeline-eras.png` | The speaker's code that made it into publications; the two used in regulation, with the last line on the same click; the three eras. | 2 | 0:50 |
| 6 | Era one · R scripts · ElicitN | `reef-richness.png` on the first click | 57 scripts, no package; used to estimate the number of species on coral reefs; unreproducible within five years. | 3 | 0:45 |
| 7 | Era two · White, grey and black literature | Journal covers, grey literature, CONFIDENTIAL and a black box | Papers, reports, industry monitoring data. | 3 | 0:30 |
| 8 | Era two · Barrow Island monitoring data | *Porites* time sequence (Fisher, Jones & Bessell-Browne 2019, Fig. 6) | Required by the approval conditions for dredging; 1,500 colonies every two weeks for nearly two years; never replicated. | 1 | 0:35 |
| 9 | Era two · Dredging thresholds | Field concentration–response curve, then ROC curve, then the thresholds on the WA EPA impact zones | Concentration–response from field data; thresholds from ROC curves; probabilistic thresholds linked to their purpose, distinguishing the management zones; still in regulatory use, never packaged. | 3 | 0:45 |
| 10 | Era two · Industry work and packages | Two columns; `method-data-separation.png` on the last click | `FSSgam`, `epower`; the higher the stakes, the less shareable the tooling; separating a method from confidential data is a lot of work. | 2 | 1:05 |
| 11 | Era three · Packages on CRAN | Text | `bayesnec`, `ssddata`, `ssdtools`; CRAN as the first external standard. | 1 | 0:30 |
| 12 | Era three · Species sensitivity distributions | `ssd-model-average.png`; breath-test photograph and police cap | Default guideline values as the 0.05 blood alcohol driving limit, and what happens above and below it. In the notes: `ssdtools` as the work with the most impact; the SSD; `ssdtools` averages over distributions. | 0 | 1:00 |
| 13 | Era three · Evaluation of `ssdtools` | Text, two columns, ANZG website; black box on the first click; the Shiny app on the second | AU–CA project; benchmark and simulated data; recommendation, now in the Australian and New Zealand guidance. First click: three regulators cannot audit a black box; reading the source. Second click: the Shiny app replaces the recommendation, and most people deriving guideline values don't write R. | 2 | 1:30 |
| 14 | Divider · AI-assisted coding | None | Transition. | 0 | 0:05 |
| 15 | The change since June | `where-work-goes.png` | Stopped writing R code by hand in June; 1,340 commits; about 12 files changed a working day before and 47 with an AI assistant, over four days; tests 3→10%, packaging 4→20%, source 41→25% as shares. | 0 | 1:15 |
| 16 | `FSSgam`, 2018 to 2026 | Text, two columns | Seven years nine months without tests; four days; two silent bugs; now on CRAN. | 3 | 1:00 |
| 17 | Routine work and judgement | Two columns | Now routine against still the speaker's; the Burrlioz standard applies to model-written code; AI use in open source software is a rapidly evolving space. | 3 | 0:50 |
| 18 | `bayesnec`, June to October 2026 | `bayesnec-weekly.png` | 817 commits since late June after none for eleven months (shown, not read); 86 bugs and flaws found, 47 in code written before June; issues opened as fast as closed, against the 22 open in June; 103 commits parked on `predev`; writing code is no longer the limit, reading it is. | 4 | 1:15 |
| 19 | Points to take away | Three points beside `known-answer-check.png`; the second on the first click, the third and the figure on the second | Maintenance takes far less time; no good pattern for open tools on data that cannot be shared; AI now writes more than humans can feasibly review, and on the next line, without an arrow, understand what would show it is wrong, and build simulations and tests to check it. | 2 | 0:55 |
| 20 | Contacts and acknowledgements | Links | Thanks; questions at the session Q&A. | 0 | 0:15 |

There are no backup slides. Three followed the closing slide until 2026-10-13, for the session
Q&A: threshold setting with ROC curves, PC95 by distribution, and estimates of "no effect". The
speaker removed them then, because there will be no time for them; `R/figures.R` still builds
their figures, so they can be restored from commit history. A fourth, the WAMSI figure of
thresholds against turbidity events, was removed at her request on 2026-10-09.

### If running long

In order of what to drop first:

1. Slide 16, `FSSgam`. Say its paragraph on the two silent bugs over slide 15.
2. The narration after the last click on slide 10. The line and the schematic on the slide
   state the point.

Do not take time from slides 10 or 19. They hold the second point to take away.

---

## Things that go stale

| What | Where | Why |
|---|---|---|
| "Four months" since June | anticipated questions | First AI co-authored commit: 20 June 2026. Correct for 15 October 2026. |
| The `bayesnec` counts | slide 18, `data/bayesnec-*.csv` | Measured on 2026-10-13 by `R/bayesnec-evidence.R`; the 86 bugs and flaws are from `data/bayesnec-issue-review.csv`, a reading of the 151 issues opened from her account since 20 June against the history of each fix. Correct while `bayesnec` is parked; re-run the script if work resumes before the talk. |
| The measured percentages | slides 15–16, `data/git-evidence-*.csv` | They cover 20 June – 22 July 2026 (36 commits on 4 days). Re-running `R/git-evidence.R` would give a larger sample, but would change the 1,340 quoted in the published abstract. The working days in `data/git-evidence-days.csv` were counted on 2026-10-13 from each repository as it stood on 28 July; that reconstruction holds nine `toxval` commits of 24 and 26 June that the July run did not, which changes the 12 files a day before by less than 0.1. |
| The team slide | slide 3 | Exported from the SETAC Asia-Pacific deck. Check the people on it are current. The speaker removed this reminder from the slide's notes on 2026-10-13. |
| "on GitHub" in the closing notes | slide 19 | The talk repository is private. Make it public before the talk or drop the sentence. |
| Timeline years | `code-timeline.png` | Reconstructed from the CV, not from CRAN metadata, apart from the 2021 CRAN date; see the comment in `R/figures.R`. |
| "used in WA dredging guidance" | slide 5, `code-timeline-regulation.png` | The speaker's statement of 2026-10-06. Name the guidance document in `notes/source-synthesis.md` once confirmed. |

---

## Room notes

- Adam Sparks presents privacy-preserving R pipelines at 1:45pm in the same session. If that
  talk touched on building tools around data that cannot be shared, slide 10 is the place to
  say so. The speaker removed this reminder from the slide 10 notes on 2026-10-13.
- The talk after this one (Posit) is on LLM tooling, so the audience is likely to come back to
  slides 15–17 in the Q&A.
- Expect a question on the "five times" claim. The answer is in the slide 15 notes: it is an
  impression; what was measured is the composition of the work.
- Expect a question on verifying AI-written code. Answer from slide 17: simulate, benchmark,
  check coverage against a known truth, as was done for Burrlioz.
- Do not get drawn into ecotoxicology detail.
