# Speaker notes

> **This file is generated.** The narration below is extracted from the `::: {.notes}`
> blocks in `talk/index.qmd`, which is the single source of truth. To change what you say,
> edit the deck, then run:
>
> ```powershell
> & "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/build-speaker-notes.R
> ```
>
> Everything outside the generated markers — this preamble and the anticipated questions at
> the end — is hand-written and preserved across regeneration.

The notes are short. Most of what is said is written on the slides, which build up one
click at a time; the notes hold the sentences that join them. Lines set as blockquotes are
stage directions, not things to say, and each "Click" direction marks one click.

For the running order, timings, and what to drop if running long, see
[`slide-outline.md`](slide-outline.md). The timing markers add to about 14 minutes at 140
words a minute, in a 15-minute slot.

---

<!-- BEGIN GENERATED -->

## 1 · Setting the legal limit with an R package — 5 s

> Wait to be introduced.

---

## 2 · Australian Institute of Marine Science — 20 s

For those who don't know me, I'm a quantitative ecologist at the Australian Institute of
Marine Science. AIMS is a government-funded marine science agency, with sites in
Townsville, Perth and Darwin. Our research supports the sustainable growth, management and
protection of tropical marine ecosystems.

---

## 3 · Tropical Ecotoxicology and Risk Assessment — 30 s

I work in the tropical ecotoxicology and risk assessment team, which has people at all three
AIMS sites. We work closely with industry on contamination and pollution: dredging,
pesticides, produced water from oil and gas, oil spills and decommissioning. Much of that
work ends in a guideline value or a threshold, and a lot of what I'll talk about today came
out of work with this team.

> Check before presenting that the people on this slide are current.

---

## 4 · The legal limit — 40 s

Environmental regulation runs on numbers like these.

> Click: the blood-alcohol limit.

> Click: above and below the limit.

> Click: dredging.

> Click: the last line.

This talk is about how that happened in my own work, over about fifteen years.

---

## 5 · Code and regulation, 2010–2026 — 45 s

I have a good applied understanding of statistics, but no formal training in programming.
This is the code I've written or contributed to since about 2010, plotted by how it was
shared: on my own computer, as a zip file, on GitHub, or on CRAN.

> Click: the two used in regulation.

> Click: the last line.

I'll go through this from left to right, in three eras.

---

## 6 · Era one · 2010–2015 · ElicitN — 45 s

Era one produced scripts, not software. ElicitN was a real collaboration, and the
elicitation methods were the statisticians' at least as much as mine. We used it with 62
taxonomists to estimate the number of species on coral reefs, published in *Current
Biology* in 2015.

> Click: unreproducible.

> Click: the last line.

---

## 7 · Era two · 2015–2020 · White, grey and black literature — 30 s

At the same time I started working with industry data.

> Click: grey literature.

> Click: black literature.

> Click: the last line.

---

## 8 · Era two · 2015–2020 · Barrow Island monitoring data — 35 s

This is one coral from that program, photographed through the dredging campaign, with the
turbidity record above it. You can see sediment settling, bleaching, and recovery.

> Click: the last line.

---

## 9 · Era two · 2015–2020 · Dredging exposure — 20 s

From the water quality data we derived metrics of exposure to dredging, across the three
ways dredging affects corals.

---

## 10 · Era two · 2015–2020 · Coral mortality — 25 s

From the coral photographs we estimated, for each site, the probability that mortality was
above that at the control sites.

---

## 11 · Era two · 2015–2020 · Concentration–response in the field — 20 s

Putting the two together gives a concentration–response relationship from field data rather
than from a laboratory.

---

## 12 · Era two · 2015–2020 · Thresholds from error rates — 35 s

We set the thresholds from ROC curves, because a threshold has error rates on both sides.
The two thresholds suit different decisions.

---

## 13 · Era two · 2015–2020 · Thresholds in dredging management — 30 s

The probable-mortality threshold marks the edge of the zone of high impact, and the
possible-mortality threshold marks the edge of the zone of moderate impact.

> Click: the last line.

The code behind them was written for this one project, and it cannot be separated from data
I'm not able to share.

---

## 14 · Era two · 2015–2020 · Industry work and packages — 65 s

Era two was really two strands. On the left is the industry work: the data and the
regulatory stakes, with code that only works on data I can't distribute.

> Click: the packages column.

Alongside it I started putting packages on GitHub. FSSgam began as a function for one paper
and became a package because people kept asking for it. epower is a toolbox for the power
of before–after control–impact designs, from an industry-funded project with BMT. Both are
public and installable, and no regulation depends on either. They could become packages
because they were built on data I could share. There were still no tests, and neither was
on CRAN.

> Click: the last line.

The higher the stakes, the less shareable the tooling. Separating a method from
confidential data well enough to release it is a lot of work, it is rarely anyone's funded
deliverable, and I didn't do it. I don't think our field has solved this.

> If Adam Sparks's privacy-preserving pipelines talk (1:45pm) touched on this, say so here.

---

## 15 · Era three · 2021 onwards · Packages on CRAN — 35 s

In 2021 Diego Barneche and I released bayesnec on CRAN, with ssddata. Like ssdtools,
bayesnec averages over several models rather than choosing one.

> Click: the first time.

> Click: R CMD check.

---

## 16 · Era three · 2021 onwards · Species sensitivity distributions — 35 s

The default guideline values are derived from a species sensitivity distribution, or SSD.
bayesnec estimates the points; ssdtools fits the curve.

> Click: fit a distribution.

> Click: the PC95.

> Click: the guideline value.

---

## 17 · Era three · 2021 onwards · Choice of distribution — 35 s

For these boron data the guideline value ranges from 1.07 to 1.77 milligrams per litre,
depending on which distribution you pick.

> Click: Burrlioz.

> Click: the model average.

---

## 18 · Era three · 2021 onwards · Evaluation of `ssdtools` — 50 s

ssdtools was originally written by Joe Thorley and Carl Schwarz. The project's job was to
evaluate whether ssdtools could replace Burrlioz, and the stated aim was collective agreement
between the Australian and Canadian experts.

> Click: the comparison.

> Click: the results.

> Click: the recommendation.

> Click: the three countries.

The recommendation has since been approved.

> Click: the last line.

---

## 19 · Open source and regulatory agreement — 30 s

With a closed desktop program, the discussion ends up relying on trust in whoever wrote it.

> Click: reading the source.

> Click: the Shiny app.

---

## 20 · Since June 2026 · AI-assisted coding — 5 s

That brings me to the last few months.

---

## 21 · The change since June — 60 s

In June I stopped writing code by hand. I now work with Claude Code, and my impression is
that I'm about five times more productive. That is an impression, so I measured what I
could.

This is every commit I've authored across seven public repositories, 1,340 of them, with
each file classified by what it is for. "With an AI assistant" means the commit includes a
Co-Authored-By: Claude line, which anyone can check.

Tests went from 3% of the files I changed to 10%. Packaging, continuous integration and CRAN
went from 4% to 20%. Source code went down, from 41% to 25%.

So the change is not in the typing. What has changed is that the work around the code now
gets done: the tests, documentation and continuous integration that determine whether
software still runs in five years.

---

## 22 · `FSSgam`, 2018 to 2026 — 50 s

One package in detail. FSSgam's first commit was in September 2018, and it went seven years
and nine months without a test file or continuous integration. There was always a more
pressing deadline.

Both arrived on the 20th of June this year. Over the next four days there were thirty-two
commits, nine test files, documentation, a pkgdown site and CRAN preparation.

Writing the tests found two bugs that had been there since 2018. A deprecated argument gave
the right warning and then did nothing. Two fields of the output came back NULL, because the
code read the wrong element names. Anyone using those features got the wrong result,
with no warning.

> If running long, drop this slide and say the last paragraph over the previous one.

---

## 23 · Routine work and judgement — 40 s

The left column is work that used to be put off for the next deadline, and now gets done.
The right column has not changed. If anything it matters more, because I'm producing more
code for each hour of my own attention.

When we evaluated ssdtools against Burrlioz, we asked for the source code, benchmarks, and
simulations with a known answer. I don't get to lower that standard because a model wrote the code. The
methods I used for checking someone else's software are the ones I now use for this.

---

## 24 · Points to take away — 40 s

Two things I'd like to leave you with.

First, the tests, documentation and continuous integration that determine whether
research software outlives its project now take far less time. If you are using AI to work
faster, spend some of the time saved on this work.

Second, we still don't have a good pattern for building open, reusable tools on data that
can't be shared. That gap is where a large amount of high-quality industry data stops being
useful to anyone except the client. If you've worked on this problem, I'd like to talk to
you.

---

## 25 · Contacts and acknowledgements — 15 s

Thank you. The packages, the code for every figure in this talk, and the log of how I used
AI to prepare it are on GitHub. I'm happy to take questions in the session Q&A.

> The talk repository is private. Make it public before the talk, or drop the second
> sentence.

---

## 26 · Thresholds against turbidity events

> Backup for questions on how the thresholds are used during dredging.

On the left is suspended sediment about 200 metres from the dredge. On the right, two
turbidity events are plotted against the thresholds. Event A crosses the possible threshold
only. Event B is above both. An exceedance like that can result in changing how the dredge
operates, or stopping it.

---

## 27 · Threshold setting with ROC curves

> Backup for questions on how the dredging thresholds were set.

For any threshold, the proportion of impact sites above it is the true positive rate, and
the proportion of control sites above it is the false positive rate. Varying the threshold
across its range traces out the ROC curve. The high-power threshold detects most impacts at the expense of
more false alarms; the low-alarm-rate threshold is exceeded only when mortality is
probable.

---

## 28 · PC95 by distribution

> Backup for questions on model averaging.

The same boron data, fitted with each of the six distributions in turn. The guideline value
ranges from 1.07 to 1.77 mg/L, and there is no theoretical basis for choosing between them.
The model average weights each fit by its AICc.

---

## 29 · Estimates of "no effect"

> Backup for questions on bayesnec and what goes into an SSD.

The NEC is the concentration below which no effect is predicted. The NSEC, which David Fox
and I defined, is the concentration at which the response cannot be distinguished from the
control. The EC10 is, by definition, a 10% effect. The NOEC is the highest tested
concentration not statistically different from the control, so it depends on which
concentrations were tested. Whichever is used becomes an input to the SSD.


<!-- END GENERATED -->

## Anticipated questions

Questions are taken at the session Q&A at 3:00pm, after the Posit talk. Slide names are given
rather than numbers.

**"How long have you been working this way?"**
Since 20 June 2026, so about four months. The FSSgam work was in the first fortnight, so it
wasn't a matter of having become good at it.

**"Five times is a big claim. How did you measure it?"**
I didn't. Five times is my impression of overall productivity, and I won't defend the number.
What I measured is the composition of the work, on *The change since June*: across 1,340
authored commits in seven public repositories, tests went from 3% to 10% of files changed,
packaging and CI from 4% to 20%, and source code fell from 41% to 25%. The largest change is
in work I previously wasn't doing at all. My output of new statistical methods did not go up
five times.

**"How did you decide a commit was AI-assisted?"**
By the `Co-Authored-By: Claude` trailer and nothing else. Anyone who clones the repositories
can check it, and it undercounts: AI-assisted work before I adopted the trailer is counted as
"before". The script is `R/git-evidence.R` in the talk repository, and its output is
committed.

**"Isn't 36 commits a small sample?"**
For the percentages, yes: the AI-assisted bars rest on 36 commits over four days, and 189 file
changes. That is why there is a slide on one package followed end to end, where the change
does not depend on how I drew the categories.

**"How do you check code you didn't write?"**
The same way we checked Burrlioz: simulate data with a known answer, measure bias and
coverage, and compare against an existing implementation.

**"Doesn't this deskill the field?"**
I was never a good programmer, and slow programming was not what made my work useful. What
matters is being able to tell when an answer is wrong, and that hasn't changed.

**"Can we see the Barrow Island data?"**
No, in most cases. The methods are in the papers and the WAMSI reports, and two of the figures
in this talk are from those reports. The tooling is the part I haven't been able to share.

**"Why couldn't you package the dredging work?"**
The method and the data were tangled together. A shareable tool would have needed the method
separated from the data well enough to work on its own, with test data I could share, worked
examples on public data, and functions that don't assume one company's monitoring design.
That is a substantial piece of work, it wasn't anyone's funded deliverable, and I didn't do it.
It is the main thing I would do differently.

**"You used FSSgam on the Barrow Island data. Didn't the two strands meet?"**
In one direction. FSSgam was used in the analysis of dredging and thermal stress published in
*Nature Communications* in 2019, so a general package did go into the industry work. What
never came back out was a reusable tool for the threshold analysis itself.

**"Are the dredging thresholds based on an SSD?"**
No. They come from concentration–response relationships measured in the field for one
receptor, coral, at one site, with ROC curves used to set the thresholds (Fisher et al. 2018,
*Journal of Applied Ecology*). That predates my SSD work. The SSD is for national default
guideline values from laboratory toxicity data across many species. The slide *Thresholds
from error rates* shows how the thresholds were set, and the backup slide on ROC curves explains
the method further.

**"Did open source get you onto the ssdtools project?"**
No. Years of work in the field, the publication record, and convening workshops with the
people who set these guidelines got me onto it. The software skills mattered once I was there.

**"Why R and not Python?"**
The regulatory community, the statistics and the reviewers were already in R, and `ssdtools`
and `bayesnec` sit on packages such as `brms`, Stan and `fitdistrplus` that would be a lot of
work to reproduce.
