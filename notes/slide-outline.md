# Slide outline and timings

Deck: `talk/index.qmd` → `_output/talk/index.html`
Built for **20 minutes**. A **15-minute cut** is specified at the bottom.

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
2. **Journey** (slides 2–13) — left to right across the timeline. Era one (ElicitN, 2012) →
   era two (black data, dredging thresholds, packages, then SSDs and `ssdtools`).
3. **The AI turn** (slides 14–21) — what changed, what didn't, and the standard of evidence
   that carries across.

The arc escalates in scale: a number for **one campaign at one site** (slide 7) → a number
for **every discharge in the country** (slides 9–10) → a method agreed across **three
jurisdictions** (slides 12–13).

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
| Where in the talk | Slides 1, 6–7 | Slides 9–13 |
| Reference | **Fisher et al. 2018, *J. Appl. Ecol.* 55:415** | Fox et al. 2021; Fisher et al. 2024; Thorley et al. 2025 |
| Era | ~2015–2019, **predates the SSD work** | ~2020 onwards |

Route B comes **first** in this cut, because it came first in real life. **The dredging
thresholds were never SSD-based**, and could not have been — one habitat-forming receptor,
one site, one campaign. Slide 7 says this explicitly, and flags forward to Route A.

---

## Slide-by-slide

| # | Slide | Visual | Beat | Time |
|---|---|---|---|---|
| 1 | When a dredge works off the Pilbara coast | `assets/stopsign.png` + punch line | Cold open. *"That number came out of R code that I wrote."* Do **not** explain it yet. | 0:45 |
| 2 | **Divider — Part one: How I got here** | — | Transition. | 0:10 |
| 3 | Fifteen years, three eras | `journey-timeline.png` | The spine, up front. Introduce yourself here. Point out the orange triangle: slide 1's number, lowest reach on the chart. "We're going to walk left to right." | 0:55 |
| 4 | Era one: scripts, not software | Two columns, `.arrows` list | ElicitN (2012), **credited to all five authors**: 57 scripts, Tcl/Tk, SourceForge, no tests. The point is that none of the five asked about longevity. | 1:15 |
| 5 | The science outlived the software | Full-bleed punch line | The lesson. Pause here. | 0:30 |
| 6 | The data most of you will never see | `assets/confidential.jpg` | Era two opens. White / grey / **black** literature. Barrow Island scale. Ends on *"that dataset is where the number on slide one came from"*. | 1:30 |
| 7 | What that data bought: the number from slide one | `roc-thresholds.png` | **Route B, and the payoff for the cold open.** In-situ dose–response + ROC. Fisher et al. 2018 JAE. Flags forward: no SSD here, hold that thought. | 1:15 |
| 8 | Meanwhile: packages and the discipline they impose | Two columns | Same years, 2018–19. FSSgam, epower. GitHub as delivery, not collaboration. `R CMD check` as reviewer. | 1:25 |
| 9 | The other kind of number | `ssd-model-average.png` | **Route A enters.** ~2020. The discharge licence framing + the blood-alcohol analogy. National, not site-specific. | 1:00 |
| 10 | Which curve, though? | `ssd-model-spread.png` | Six distributions, six legal limits. The problem that pulled me into `ssdtools`. Note the jump in scale from slide 7. | 1:00 |
| 11 | One level down: what is a "no effect"? | `no-effect-estimates.png` | Four "no effects". bayesnec, NSEC. Software made the method possible, not the reverse. | 1:35 |
| 12 | `ssdtools`: the part I did not expect | Two columns | AU–CA joint evaluation vs Burrlioz. Benchmarks + simulation. Adopted. | 1:25 |
| 13 | You cannot get three regulators to agree on a black box | Full-bleed punch line | **The keystone slide**, closing act two. Open source as governance mechanism. Shiny as the last mile. | 1:10 |
| 14 | **Divider — Part two: And then the AI arrived** | — | Transition. | 0:05 |
| 15 | I stopped writing code by hand in June | Full-bleed punch line | The claim, stated plainly, plus a flag that "5×" needs unpacking. **Elapsed figure assumes an October delivery — check it.** | 0:40 |
| 16 | The speed-up is not in the typing | `where-work-goes.png` | **Measured**, from 1,340 authored commits. Tests 3×, packaging/CI 5×, source code share *down*. Say that it's measured — it's the point. | 1:25 |
| 17 | One package, in detail | Two columns | `FSSgam`: 7 yr 9 mo with no tests and no CI, then four days. Writing the tests found two silent bugs shipping since 2018. | 1:10 |
| 18 | What actually changed | Two columns | Now routine / still mine. Statistical judgement is the moat. | 1:00 |
| 19 | The awkward symmetry | Lede + punch | Same standard of evidence I demanded of Burrlioz. Fluent-and-wrong as a new hazard. | 1:10 |
| 20 | Provenance, out loud | `.arrows` list | Prompt logging. Reproducibility now covers how the code came to exist. | 0:55 |
| 21 | Three things I'd tell 2012 me | Numbered `.arrows` + punch | The take-homes. Slow down. | 1:10 |
| 22 | Thank you | Contacts + repos | Links, acknowledgements, invitation to question. | 0:25 |

**Total ≈ 21 min 55 s** — over a 20-minute slot. See the two cuts below.

### The 20-minute cut (lose 2 min)

- Drop slide 20, *Provenance, out loud* (0:55) — fold one clause into slide 19.
- Trim slide 4, *Era one*, 1:15 → 0:40 (0:35).
- Trim slide 6, *Black data*, 1:30 → 1:00 (0:30).

Lands at ≈19:55. This is the version to rehearse first.

---

## The 15-minute cut

Need to lose **6 min 55 s**. Do it by removing three slides and trimming eleven, not by
talking faster. The plan below saves 6 min 50 s, landing at ≈15:05.

Slide numbers are the 22-slide running order above.

**Do not cut slide 7 in this version.** It is the payoff for the cold open — cutting it
leaves slide 1's promise unanswered. That was possible in the `discharge-first` cut; it is
not possible here. This is the main cost of the chronological order.

**Remove entirely (3 min 5 s):**

- Slide 20 — *Provenance, out loud* (0:55). Fold one sentence into slide 19 instead:
  *"— and I log every AI-assisted session to the repo, because reproducibility now has to
  cover how the code came to exist."*
- Slide 10 — *Which curve, though?* (1:00). Painful but survivable: say the sentence
  *"and there are six defensible distributions you could fit, which give six different
  limits"* over slide 9's figure, which already shows the fan of candidate curves.
- Slide 17 — *One package, in detail* (1:10). **Last resort.** It is the most concrete
  evidence in the talk and the two-silent-bugs line is the best thing in act three. Cut it
  only if you must, and if you do, add one clause to slide 16: *"— and in one package that
  meant a test suite arriving seven years and nine months late, which immediately turned up
  two bugs that had been shipping since 2018."*

**Trim (3 min 45 s total):**

| Slide | From | To | Saves | How |
|---|---|---|---|---|
| 3 Timeline | 0:55 | 0:40 | 0:15 | Cut the "same statistics in 2012" aside. Keep the y-axis point and the triangle. |
| 4 Era one | 1:15 | 0:40 | 0:35 | Drop the "how you ran it" detail. Keep: 57 scripts, zip file, dead in five years. |
| 6 Black data | 1:30 | 1:00 | 0:30 | Drop the ten-minute water quality logging detail. Keep 1,500 corals / 530 days. |
| 7 Dredging thresholds | 1:15 | 0:55 | 0:20 | Keep the ROC trade-off and the no-SSD flag; drop the posterior-probability construction. |
| 8 Packages | 1:25 | 0:55 | 0:30 | Drop the FSSgam origin anecdote. Keep GitHub-as-delivery and `R CMD check`. |
| 9 The other kind of number | 1:00 | 0:50 | 0:10 | Keep the blood-alcohol line; drop the "not derived per site" aside. |
| 11 "No effect" | 1:35 | 1:00 | 0:35 | Name NEC and EC10 only; skip NOEC and NSEC derivation. Keep the causation point. |
| 12 `ssdtools` | 1:25 | 1:10 | 0:15 | Drop the collaborator list; it's on the slide. |
| 16 Speed-up | 1:25 | 1:10 | 0:15 | Give the three numbers and the method in one breath; drop the list of skipped tasks. |
| 18 What changed | 1:00 | 0:50 | 0:10 | Read the columns, don't gloss each line. |
| 21 Three things | 1:10 | 1:00 | 0:10 | Deliver the three; drop the elaboration on each. |

**Never cut:** 1 (the hook), 3 (the spine), 7 (the payoff), 13 (the keystone), 16 (the
measured mechanism of the speed-up), 21 (the take-homes).

---

## Things that go stale

| What | Where | Why |
|---|---|---|
| "Four months" since June | slide 15 aside + notes | Correct for 15 Oct 2026 only. First AI co-authored commit: **20 June 2026**. |
| The measured percentages | slides 16–17, `data/*.csv` | Cover 20 Jun – 22 Jul 2026. Re-run `Rscript R/git-evidence.R` before the talk; the figure and caption update themselves. |
| Timeline years | `journey-timeline.png` | Reconstructed from the CV, not from CRAN metadata — see the `TODO` in `R/figures.R`. |

---

## Room notes

- Session three is *"real-life applications"* (2:30–4:10pm, day two) — this is the right room
  for the regulatory framing. Lean into it.
- The audience will include Posit staff and consultants. Slide 12's governance argument and
  slide 16's maintenance argument are the two most likely to start a conversation at the
  refreshments afterwards; leave room for them.
- Expect a question on the "5×" claim. The honest answer is on slide 16 and it is
  *"the multiplier is on the work I previously wasn't doing at all"*.
- Expect a question on verification of AI-written code. Answer from slide 18: simulate,
  benchmark, check coverage against a known truth — the same thing we did to Burrlioz.
- Do not get drawn into ecotoxicology detail. Offer to talk afterwards.
