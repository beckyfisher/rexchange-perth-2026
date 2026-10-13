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

Most of what is said is written on the slides, some of them built up with clicks, and the
notes hold the sentences that join them. The slide on species sensitivity distributions is
the exception: it is shown complete, and the explanation of the SSD is in the notes. Lines
set as blockquotes are stage directions, not things to say, and each "Click" direction marks
one click.

The PowerPoint in `_output/handover/` has one page per click. Each page's notes repeat the
notes of the slide's earlier clicks, and include the text on the slide in bold, apart from
text marked as not read out. A "Read the slide" direction marks where that text is placed
among the narration.

For the running order, timings, and what to drop if running long, see
[`slide-outline.md`](slide-outline.md). The timing markers add to about 12.5 minutes, in a
15-minute slot.

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
pesticides, produced water from oil and gas, oil spills and decommissioning.

> Click: guidelines and thresholds in red.

In particular, we have a focus on developing guidelines and thresholds for environmental
management and risk assessment.

---

## 4 · Numbers in environmental regulation — 40 s

These numbers are important in environmental regulation.

Examples include:

> Click: defensible.

> Click: open-source R packages.

> Click: fifteen years.

I've spent the last 15 years developing R code and tools in an attempt to improve the
statistical methods we use in environmental regulation.

---

## 5 · Improving statistical methods in regulation — 50 s

This graphic shows you

> Read the slide.

that has at least made it into publications.

I started with an applied understanding of statistics, but no formal training in computer
programming.

You can see the changes over time, from R scripts on my personal computer, through to
developing packages on CRAN.

> Click: the two used in regulation, and the last line.

These highlighted ones are the work that has actually made it directly into regulatory
guidance.

> Read the slide.

> Click: the three eras.

---

## 6 · Era one · 2010–2015 · R scripts · ElicitN — 45 s

Era one produced scripts, not software.

ElicitN was a real collaboration with three statisticians.

> Click: coral reef species.

Published in *Current Biology* in 2015.

> Click: unreproducible.

> Click: the last line.

---

## 7 · Era two · 2015–2020 · Industry data and GitHub · White, grey and black literature — 30 s

During era two, I started working with industry data.

> Click: grey literature.

> Click: black literature.

> Click: the last line.

---

## 8 · Era two · 2015–2020 · Industry data and GitHub · Barrow Island monitoring data — 35 s

One of the most valuable datasets was the Barrow Island monitoring data that was required for

> Read the slide.

This is one coral from that program, photographed through the dredging campaign, with the
turbidity record above it. You can see sediment settling, bleaching, and recovery.

> Click: the last line.

---

## 9 · Era two · 2015–2020 · Industry data and GitHub · Dredging thresholds — 45 s

From those data we could fit concentration–response curves in the field rather than in a
laboratory.

> Click: ROC curves.

> Click: the impact zones.

> Click: the last line.

The code behind them cannot be separated from data I'm not able to share.

---

## 10 · Era two · 2015–2020 · Industry data and GitHub · Industry work and packages — 65 s

Era two was really two strands. On the left is the industry work: the data and the
regulatory stakes, with code that only works on data I can't distribute.

> Click: the packages column.

Alongside it I started putting packages on GitHub.

FSSgam began as a function for one paper and became a package because people kept asking
for it.

epower is a toolbox for the power of before–after control–impact designs, from an
industry-funded project with BMT.

Both are public and installable, and no regulation depends on either.

They could become packages because they were built on data I could share.

There were still no tests, and neither was on CRAN.

> Click: the last line and the separation graphic.

Separating a method from confidential data well enough to release it is a lot of work, and
this I think does remain a problem in open source software.

---

## 11 · Era three · 2021 onwards · Packages on CRAN — 30 s

In era three I finally started being involved with packages on CRAN. For me this started
with bayesnec, built by Diego Barneche and I in 2021. This was followed by my building an
ssddata package, and becoming a co-collaborator on ssdtools.

> Click: the first time.

---

## 12 · Era three · 2021 onwards · Species sensitivity distributions — 60 s

ssdtools is some of my more recent work that has had the biggest impact.

> Read the slide.

They are derived from a species sensitivity distribution, or SSD. Each point is the toxicity
estimate for one species, which is what bayesnec (my other software) was built to estimate.
You fit a distribution and read off the concentration that protects, here, 95% of species.

There is no theoretical basis for choosing one distribution, and ssdtools solves this by
averaging over several distributions.

---

## 13 · Era three · 2021 onwards · Evaluation of `ssdtools` — 90 s

ssdtools was originally written by Joe Thorley and Carl Schwarz. The project's job was to
evaluate whether ssdtools could replace Burrlioz in the Australian guideline framework.

With a stated aim of collective agreement between the Australian and Canadian experts.

We compared the two on benchmark data sets, and on simulated data with a known true value, so
we could measure bias and coverage. ssdtools performed better, and including more
distributions improved its estimates. The recommendation to adopt it has since been
approved, and this is now in the Australian and New Zealand guidance.

> Click: open source.

This project is a good example of where open source software shines.

With a closed desktop program, the discussion ends up relying on trust in whoever wrote it.

> Read the slide.

> Click: the Shiny app.

---

## 14 · Since June 2026 · AI-assisted coding — 5 s

That brings me to the last few months.

---

## 15 · The change since June — 60 s

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

## 16 · `FSSgam`, 2018 to 2026 — 50 s

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

## 17 · Routine work and judgement — 40 s

The left column is work that used to be put off for the next deadline, and now gets done.
The right column has not changed. If anything it matters more, because I'm producing more
code for each hour of my own attention.

When we evaluated ssdtools against Burrlioz, we asked for the source code, benchmarks, and
simulations with a known answer. I don't get to lower that standard because a model wrote the code. The
methods I used for checking someone else's software are the ones I now use for this.

---

## 18 · Points to take away — 40 s

Two things I'd like to leave you with.

First, the tests, documentation and continuous integration that determine whether
research software outlives its project now take far less time. If you are using AI to work
faster, spend some of the time saved on this work.

Second, we still don't have a good pattern for building open, reusable tools on data that
can't be shared. That gap is where a large amount of high-quality industry data stops being
useful to anyone except the client. If you've worked on this problem, I'd like to talk to
you.

---

## 19 · Contacts and acknowledgements — 15 s

Thank you. The packages, the code for every figure in this talk, and the log of how I used
AI to prepare it are on GitHub. I'm happy to take questions in the session Q&A.

> The talk repository is private. Make it public before the talk, or drop the second
> sentence.

---

## 20 · Threshold setting with ROC curves

> Backup for questions on how the dredging thresholds were set.

For any threshold, the proportion of impact sites above it is the true positive rate, and
the proportion of control sites above it is the false positive rate. Varying the threshold
across its range traces out the ROC curve. The high-power threshold detects most impacts at the expense of
more false alarms; the low-alarm-rate threshold is exceeded only when mortality is
probable.

---

## 21 · PC95 by distribution

> Backup for questions on model averaging.

The same boron data, fitted with each of the six distributions in turn. The guideline value
ranges from 1.07 to 1.77 mg/L, and there is no theoretical basis for choosing between them.
The model average weights each fit by its AICc.

---

## 22 · Estimates of "no effect"

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
guideline values from laboratory toxicity data across many species. The slide *Dredging
thresholds* shows how the thresholds were set, and the backup slide on ROC curves explains
the method further.

**"Did open source get you onto the ssdtools project?"**
No. Years of work in the field, the publication record, and convening workshops with the
people who set these guidelines got me onto it. The software skills mattered once I was there.

**"Why R and not Python?"**
The regulatory community, the statistics and the reviewers were already in R, and `ssdtools`
and `bayesnec` sit on packages such as `brms`, Stan and `fitdistrplus` that would be a lot of
work to reproduce.
