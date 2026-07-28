# Slide outline and timings

Deck: `talk/index.qmd` → `_output/talk/index.html`
Built for **20 minutes**. A **15-minute cut** is specified at the bottom.

Press `s` in the rendered deck for the speaker view (notes + timer + next slide).

---

## Structure

The talk is a three-act arc with the science as setting, not subject:

1. **Stakes** (slides 1–3) — a discharge is licensed against a number; the number comes from
   an R package; the package's internal choices move the number.
2. **Journey** (slides 4–13) — three eras, each with one transferable lesson.
3. **The AI turn** (slides 14–21) — what changed, what didn't, and the standard of evidence
   that carries across.

### Two routes to a regulatory number — keep these separate

The talk deliberately shows **two different statistical routes** to a number that stops an
activity. Do not let them blur together; they are separate bodies of work from different
periods.

| | Route A — guideline values | Route B — site-specific thresholds |
|---|---|---|
| Method | Species sensitivity distribution over many species' toxicity estimates | *In situ* dose–response for one receptor + ROC curves on Type I / Type II error |
| Data | Laboratory toxicity tests | Industry monitoring data ("black literature") |
| Software | `ssdtools`, `bayesnec` | Bespoke Bayesian models (JAGS) |
| Where in the talk | Slides 2–3, 11–13 | Slides 9–10 |
| Reference | Fox et al. 2021; Fisher et al. 2024; Thorley et al. 2025 | **Fisher et al. 2018, *J. Appl. Ecol.* 55:415** |
| Era | ~2020 onwards | ~2015–2019, **predates the SSD work** |

**The dredging thresholds were never SSD-based**, and could not have been — there was one
habitat-forming receptor, one site, one campaign. Slide 10 says this explicitly.

---

## Slide-by-slide

| # | Slide | Visual | Beat | Time |
|---|---|---|---|---|
| 1 | The sewage outfall at your local beach | `assets/stopsign.png` + punch line | Cold open. A licensed discharge runs against a number. Relatable *and* industrial. | 0:45 |
| 2 | Where the number comes from | `ssd-model-average.png` | 30 s of SSD, then leave it. Blood-alcohol analogy. | 1:00 |
| 3 | Which curve, though? | `ssd-model-spread.png` | Six distributions, six legal limits. The problem that made me a developer. | 1:00 |
| 4 | **Divider — Part one: How I got here** | — | Transition. | 0:10 |
| 5 | Fifteen years, three eras | `journey-timeline.png` | The spine. y-axis = how far the software could travel. | 0:50 |
| 6 | Era one: the lone scripter | Two columns, `.arrows` list | ElicitN: 57 scripts, Tcl/Tk, SourceForge, no tests. | 1:15 |
| 7 | The science outlived the software | Full-bleed punch line | The lesson. Pause here. | 0:30 |
| 8 | Era two: packages and the discipline they impose | Two columns | FSSgam, epower. GitHub as delivery, not collaboration. `R CMD check` as reviewer. | 1:25 |
| 9 | The data most of you will never see | `assets/confidential.jpg` | White / grey / **black** literature. Barrow Island scale. Open code as the release valve. | 1:30 |
| 10 | What that data bought: a number, without an SSD | `roc-thresholds.png` | **Route B.** In-situ dose–response + ROC. Fisher et al. 2018 JAE. Says out loud that this predates the SSD work. | 1:05 |
| 11 | Era two, part two: the ecotoxicology pivot | `no-effect-estimates.png` | Back to Route A. Four "no effects". bayesnec. Software made the method possible, not the reverse. | 1:35 |
| 12 | `ssdtools`: the part I did not expect | Two columns | AU–CA joint evaluation vs Burrlioz. Benchmarks + simulation. Adopted. | 1:25 |
| 13 | You cannot get three regulators to agree on a black box | Full-bleed punch line | **The keystone slide**, and now the close of act two. Open source as governance mechanism. Shiny as the last mile. | 1:10 |
| 14 | **Divider — Part two: And then the AI arrived** | — | Transition. | 0:05 |
| 15 | I have not written a line of code in about a year | Full-bleed punch line | The claim, stated plainly, plus a flag that "5×" needs unpacking. | 0:40 |
| 16 | The speed-up is not in the typing | `where-work-goes.png` | **Say out loud that this chart is illustrative.** The tax on doing it properly collapsed. | 1:25 |
| 17 | What actually changed | Two columns | Now routine / still mine. Statistical judgement is the moat. | 1:00 |
| 18 | The awkward symmetry | Lede + punch | Same standard of evidence I demanded of Burrlioz. Fluent-and-wrong as a new hazard. | 1:10 |
| 19 | Provenance, out loud | `.arrows` list | Prompt logging. Reproducibility now covers how the code came to exist. | 0:55 |
| 20 | Three things I'd tell 2012 me | Numbered `.arrows` + punch | The take-homes. Slow down. | 1:10 |
| 21 | Thank you | Contacts + repos | Links, acknowledgements, invitation to question. | 0:25 |

**Total ≈ 20 min 30 s.** Deliberately ~30 s over: conference talks lose time to the room,
not gain it, and slides 7, 12 and 15 all have deliberate pauses that can absorb it.

---

## The 15-minute cut

Need to lose ~5 min 30 s. Do it by **removing two slides and trimming six**, not by talking
faster.

**Remove entirely (2 min 0 s):**

- Slide 10 — *What that data bought*. Self-contained; nothing downstream depends on it. If
  you cut it, add one clause to slide 9 so Route B still gets acknowledged:
  *"— and what we got out of it was a set of in-situ dredging thresholds, derived from ROC
  curves rather than from an SSD."* Without that clause the black-data slide has no payoff.
- Slide 19 — *Provenance, out loud*. Fold one sentence into slide 18 instead:
  *"— and I log every AI-assisted session to the repo, because reproducibility now has to
  cover how the code came to exist."*

**Also remove if the 15 minutes is hard (1 min 10 s):**

- Slide 18 — *The awkward symmetry*. Painful, because it is the intellectual centre of act
  three. Prefer trimming elsewhere first.

**Trim (2 min 25 s total):**

| Slide | From | To | How |
|---|---|---|---|
| 6 Era one | 1:15 | 0:40 | Drop the "how you ran it" detail. Keep: 57 scripts, zip file, dead in five years. |
| 8 Era two packages | 1:25 | 1:00 | Drop the FSSgam origin anecdote. Keep GitHub-as-delivery and `R CMD check`. |
| 9 Black data | 1:30 | 1:00 | Drop the ten-minute water quality logging detail. Keep 1,500 corals / 530 days. |
| 10 Ecotox pivot | 1:35 | 1:00 | Name NEC and EC10 only; skip NOEC and NSEC derivation. Keep the causation point. |
| 11 `ssdtools` | 1:25 | 1:10 | Drop the collaborator list; it's on the slide. |
| 3 Which curve | 1:00 | 0:45 | State the spread, skip the "aesthetic grounds" aside. |

Slide numbers above refer to the 20-minute running order. Note that slides 12 and 13 swapped
roles relative to an earlier draft: the keystone now *closes* act two, and the ROC material
sits with the black-data slide it belongs to.

**Never cut:** 1 (the hook), 5 (the spine), 13 (the keystone), 16 (the honest mechanism of
the speed-up), 20 (the take-homes).

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
