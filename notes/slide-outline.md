# Slide outline and timings

Deck: `talk/index.qmd` → `_output/talk/index.html`
Runs **23:55** as written. 25-minute, 20-minute and 15-minute versions are specified below.

Press `s` in the rendered deck for the speaker view (notes + timer + next slide).

> **Two versions exist.** `main` is the **chronological** cut: it opens on the dredge, then
> walks the timeline left to right — ElicitN → black data → dredging thresholds → packages →
> SSDs → `ssdtools`. The `discharge-first` branch opens instead on a licensed discharge and
> puts the SSD material up front, which gets to the guideline-value stakes faster but is not
> chronological. `git switch discharge-first` to compare.

---

## Structure

A cold open, then a strictly chronological walk, then the AI turn:

1. **Hook** (slide 1) — a dredge stops against a number; *that number came out of R code I
   wrote*. Deliberately unexplained. It gets paid off on slide 7.
2. **Journey** (slides 2–14) — left to right across the timeline. Era one (ElicitN, 2012) →
   era two (black data, dredging thresholds, packages, and the gap between them) → era three
   (CRAN, `bayesnec`, `ssdtools`).
3. **The AI turn** (slides 15–23) — what changed, what didn't, and the standard of evidence
   that carries across.

The arc escalates in scale: a number for **one campaign at one site** (slide 7) → a number
for **every discharge in the country** (slides 10–11) → a method agreed across **three
jurisdictions** (slides 13–14).

**Two closing arguments, not one.** The AI material is the headline, but slide 9's unsolved
problem — open tooling around data you cannot ship — is the other, and it is the one that
gives the audience something to do. Both land in slide 22.

### Era two is two strands, and they never met

This is one of the talk's two closing arguments, so do not let the running order smooth it
over. Era two contains **two parallel bodies of work that did not converge**:

| | Industry data | Packaging |
|---|---|---|
| What | Barrow Island dredging; *in situ* dose–response + ROC | `FSSgam`, `epower` |
| Data | Confidential, undistributable | Public, shareable |
| Stakes | Numbers **still in regulatory use** | No regulation depends on either |
| Artefact | Bespoke code for one campaign | Installable packages |
| Slides | 6–7 | 8 |

Slide 9 names the pattern: **the higher the stakes, the less shareable the tooling.** The
speaker has not solved it and says so. That's the second take-home, and it's the one that
hands the audience a problem rather than a lesson.

### Two routes to a regulatory number — keep these separate

The talk deliberately shows **two different statistical routes** to a number that stops an
activity. Do not let them blur together; they are separate bodies of work from different
periods.

| | Route B — site-specific thresholds | Route A — guideline values |
|---|---|---|
| Method | *In situ* dose–response for one receptor + ROC curves on Type I / Type II error | Species sensitivity distribution over many species' toxicity estimates |
| Data | Industry monitoring data ("black literature") | Laboratory toxicity tests |
| Software | Bespoke Bayesian models (JAGS + R), never packaged | `ssdtools`, `bayesnec` |
| Scope | One campaign, one site | Every discharge in the country |
| Where in the talk | Slides 1, 6–7 | Slides 10–14 |
| Reference | **Fisher et al. 2018, *J. Appl. Ecol.* 55:415** | Fox et al. 2021; Fisher et al. 2024; Thorley et al. 2025 |
| Era | ~2015–2019, **predates the SSD work** | ~2020 onwards |

Route B comes **first** in this cut, because it came first in real life. **The dredging
thresholds were never SSD-based**, and could not have been — one habitat-forming receptor,
one site, one campaign. Slide 7 says this explicitly, and flags forward to Route A.

---

## Slide-by-slide

| # | Slide | Visual | Beat | Time |
|---|---|---|---|---|
| 1 | When the next dredge works off the Pilbara coast | `figures/stop-sign.png` + punch line | Cold open. *"That number came out of R code that I wrote."* Do **not** explain it yet. | 0:45 |
| 2 | **Divider — Part one: How I got here** | — | Transition. | 0:10 |
| 3 | Fifteen years, three eras | `journey-timeline.png` | The spine, up front. Introduce yourself here. Point out the orange triangle: slide 1's number, lowest reach on the chart. "We're going to walk left to right." | 0:55 |
| 4 | Era one: scripts, not software | Two columns, `.arrows` list | ElicitN (2012), **credited to all five authors**: 57 scripts, Tcl/Tk, SourceForge, no tests. The point is that none of the five asked about longevity. | 1:15 |
| 5 | The science outlived the software | Full-bleed punch line | The lesson. Pause here. | 0:30 |
| 6 | Era two: the data most of you will never see | `figures/confidential-stamp.png` | Era two opens. White / grey / **black** literature. Barrow Island scale. Ends on *"that dataset is where the number on slide one came from"*. | 1:30 |
| 7 | What that data bought: the number from slide one | `roc-thresholds.png` | **Route B, and the payoff for the cold open.** In-situ dose–response + ROC. Fisher et al. 2018 JAE. Flags forward: no SSD here, hold that thought. | 1:15 |
| 8 | Era two, meanwhile: onto GitHub | Two columns | Same years, 2018–19. FSSgam, epower. GitHub as delivery, not collaboration. Ends on *"it solved distribution, it did not make me disciplined"*. | 1:25 |
| 9 | **Era two: two strands that never met** | Two columns + punch | **New, and load-bearing.** The high-stakes work produced no reusable tool. Names the unsolved problem that returns in the take-homes. | 1:30 |
| 10 | The other kind of number | `ssd-model-average.png` | **Route A enters.** ~2020. The discharge licence framing + the blood-alcohol analogy. National, not site-specific. | 1:00 |
| 11 | Which curve, though? | `ssd-model-spread.png` | Six distributions, six legal limits. The problem that pulled me into `ssdtools`. Note the jump in scale from slide 7. | 1:00 |
| 12 | Era three: onto CRAN | `no-effect-estimates.png` | bayesnec + ssddata to CRAN, Nov 2021. **First real use of `R CMD check`** — moved here from slide 8. Then four "no effects"; software made the method possible, not the reverse. | 1:50 |
| 13 | `ssdtools`: the part I did not expect | Two columns | **Track record and workshops got her in the room, not GitHub.** Then AU–CA joint evaluation vs Burrlioz, benchmarks + simulation, adopted. | 1:40 |
| 14 | You cannot get three regulators to agree on a black box | Full-bleed punch line | **The keystone slide**, closing act two. Open source as governance mechanism. Shiny as the last mile. | 1:10 |
| 15 | **Divider — Part two: And then the AI arrived** | — | Transition. | 0:05 |
| 16 | I stopped writing code by hand in June | Full-bleed punch line | The claim, stated plainly, plus a flag that "5×" needs unpacking. **Elapsed figure assumes an October delivery — check it.** | 0:40 |
| 17 | The speed-up is not in the typing | `where-work-goes.png` | **Measured**, from 1,340 authored commits. Tests 3×, packaging/CI 5×, source code share *down*. Say that it's measured — it's the point. | 1:25 |
| 18 | One package, in detail | Two columns | `FSSgam`: 7 yr 9 mo with no tests and no CI, then four days. Writing the tests found two silent bugs shipping since 2018. | 1:10 |
| 19 | What actually changed | Two columns | Now routine / still mine. Statistical judgement is the moat. | 1:00 |
| 20 | The awkward symmetry | Lede + punch | Same standard of evidence I demanded of Burrlioz. Fluent-and-wrong as a new hazard. | 1:10 |
| 21 | Provenance, out loud | `.arrows` list | Prompt logging. Reproducibility now covers how the code came to exist. | 0:55 |
| 22 | What I'd tell 2012 me | Numbered `.arrows` + punch | **Four take-homes plus the open problem.** Slow down; the unsolved tooling gap is the last thing they hear. | 1:25 |
| 23 | Thank you | Contacts + repos | Links, acknowledgements, invitation to question. | 0:25 |

**Total ≈ 23 min 55 s.** See the note on slot length in `talk/abstract.qmd` — it is worth
asking for 25–30 minutes rather than cutting this to 20.

### If you get 25 minutes — deliver it as written

This is the version the material wants to be. Nothing is padded and the two closing arguments
both get their weight.

### The 20-minute cut (lose 3 min 55 s)

- Drop slide 21, *Provenance, out loud* (0:55) — fold one clause into slide 20.
- Drop slide 11, *Which curve, though?* (1:00) — say *"and there are six defensible
  distributions you could fit, which give six different limits"* over slide 10's figure,
  which already shows the fan of candidate curves.
- Trim slide 4, *Era one*, 1:15 → 0:40 (0:35).
- Trim slide 6, *Era two: black data*, 1:30 → 1:00 (0:30).
- Trim slide 12, *Era three*, 1:50 → 1:20 (0:30) — keep CRAN and `R CMD check`, name NEC and
  EC10 only.
- Trim slide 13, `ssdtools`, 1:40 → 1:20 (0:20) — keep the "how I got in the room" point,
  drop the collaborator list.
- Trim slide 17, *Speed-up*, 1:25 → 1:10 (0:15) — three numbers and the method in one breath.

Lands at ≈20:00. **Do not** take the time out of slides 9 or 22 — those carry the second
take-home.

---

## The 15-minute cut

Need to lose **8 min 55 s**. This is a genuinely different talk: at fifteen minutes you can
have the journey *or* the two arguments, not both. The plan below saves 8 min 50 s.

Slide numbers are the 23-slide running order above.

**Do not cut slide 7.** It is the payoff for the cold open — cutting it leaves slide 1's
promise unanswered. That was possible in the `discharge-first` cut; it is not here. This is
the main cost of the chronological order.

**Remove entirely (5 min 20 s):**

- Slide 21 — *Provenance, out loud* (0:55). Fold one sentence into slide 20.
- Slide 11 — *Which curve, though?* (1:00). As above.
- Slide 5 — *The science outlived the software* (0:30). Fold the line into slide 4.
- Slide 20 — *The awkward symmetry* (1:10). Painful; it's the intellectual centre of act
  three. Fold one clause into slide 19.
- Slide 18 — *One package, in detail* (1:10). **Last resort.** The two-silent-bugs line is
  the best thing in act three. If you must, add to slide 17: *"— and in one package that
  meant a test suite arriving seven years and nine months late, which immediately turned up
  two bugs that had been shipping since 2018."*
- Slide 9 — *Two strands that never met* (1:30). **Only if you also drop the corresponding
  take-home**, otherwise slide 22 references an argument you never made.

**Trim (3 min 30 s total):**

| Slide | From | To | Saves | How |
|---|---|---|---|---|
| 3 Timeline | 0:55 | 0:40 | 0:15 | Cut the "same statistics in 2012" aside. Keep the y-axis point and the triangle. |
| 4 Era one | 1:15 | 0:40 | 0:35 | Drop the "how you ran it" detail. Keep the co-author credit, 57 scripts, dead in five years. |
| 6 Black data | 1:30 | 1:00 | 0:30 | Drop the ten-minute logging detail. Keep 1,500 corals / 530 days. |
| 7 Dredging thresholds | 1:15 | 0:55 | 0:20 | Keep the ROC trade-off and the no-SSD flag; drop the posterior-probability construction. |
| 8 GitHub | 1:25 | 0:55 | 0:30 | Drop the FSSgam origin anecdote. Keep GitHub-as-delivery. |
| 10 The other kind of number | 1:00 | 0:50 | 0:10 | Keep the blood-alcohol line; drop the "not derived per site" aside. |
| 12 Era three | 1:50 | 1:20 | 0:30 | Keep CRAN and `R CMD check`; name NEC and EC10 only. |
| 13 `ssdtools` | 1:40 | 1:20 | 0:20 | Keep "track record got me in the room"; drop the collaborator list. |
| 17 Speed-up | 1:25 | 1:10 | 0:15 | Three numbers and the method in one breath. |
| 19 What changed | 1:00 | 0:50 | 0:10 | Read the columns, don't gloss each line. |
| 22 Take-homes | 1:25 | 1:10 | 0:15 | Deliver the four and the open problem; drop the elaboration on each. |

**Never cut:** 1 (the hook), 3 (the spine), 7 (the payoff), 14 (the keystone), 17 (the
measured mechanism), 22 (the take-homes).

---

## Things that go stale

| What | Where | Why |
|---|---|---|
| "Four months" since June | slide 16 aside + notes | Correct for 15 Oct 2026 only. First AI co-authored commit: **20 June 2026**. |
| The measured percentages | slides 17–18, `data/*.csv` | Cover 20 Jun – 22 Jul 2026. Re-run `Rscript R/git-evidence.R` before the talk; the figure and caption update themselves. |
| Timeline years | `journey-timeline.png` | Reconstructed from the CV, not from CRAN metadata — see the `TODO` in `R/figures.R`. |

---

## Room notes

- Session three is *"real-life applications"* (2:30–4:10pm, day two) — this is the right room
  for the regulatory framing. Lean into it.
- The audience will include Posit staff and consultants. Slide 14's governance argument,
  slide 9's unsolved-tooling problem and slide 17's maintenance argument are the three most
  likely to start a conversation at the refreshments afterwards; leave room for them.
- Expect a question on the "5×" claim. The honest answer is on slide 17 and it is
  *"the multiplier is on the work I previously wasn't doing at all"*.
- Expect a question on verification of AI-written code. Answer from slide 18: simulate,
  benchmark, check coverage against a known truth — the same thing we did to Burrlioz.
- Do not get drawn into ecotoxicology detail. Offer to talk afterwards.
