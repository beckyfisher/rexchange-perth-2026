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
[`slide-outline.md`](slide-outline.md). The timing markers add to about 14.2 minutes, in a
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

## 11 · Era three · 2021 onwards · CRAN · Packages on CRAN — 30 s

In era three I finally started being involved with packages on CRAN. For me this started
with bayesnec, built by Diego Barneche and I in 2021. This was followed by my building an
ssddata package, and becoming a co-collaborator on ssdtools.

> Click: the first time.

---

## 12 · Era three · 2021 onwards · CRAN · Species sensitivity distributions — 60 s

ssdtools is some of my more recent work that has had the biggest impact.

> Read the slide.

They are derived from a species sensitivity distribution, or SSD. Each point is the toxicity
estimate for one species, which is what bayesnec (my other software) was built to estimate.
You fit a distribution and read off the concentration that protects, here, 95% of species.

There is no theoretical basis for choosing one distribution, and ssdtools solves this by
averaging over several distributions.

---

## 13 · Era three · 2021 onwards · CRAN · Evaluation of `ssdtools` — 90 s

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

## 15 · The change since June — 45 s

> Read the slide.

I now work with Claude Code or Codex, and my impression is that I'm about five times more
productive.

That is an impression, so I asked the AI to measure it, based on my GitHub commits.

On any one day I worked on these packages, I used to change about 12 files.

Since the end of July it has been 86, mostly in bayesnec, so that is actually 7 times more
productive.

The biggest change is not in the source code, but in the work around the code: the tests,
documentation and continuous integration.

These are some of the things that determine whether software will still be running and useful
in five years from now.

---

## 16 · `FSSgam`, 2018 to 2026 — 60 s

FSSgam's first commit was in September 2018, and it went seven years
and nine months without a test file or continuous integration. There was always a more
pressing deadline.

Both arrived on the 20th of June this year.

> Click: four days.

Over the next four days there were thirty-two commits, nine test files, documentation, a
pkgdown site and CRAN preparation.

> Click: two bugs.

Writing the tests found two bugs that had been there since 2018. A deprecated argument gave
the right warning and then did nothing. Two fields of the output came back NULL, because the
code read the wrong element names. Anyone using those features got the wrong result,
with no warning.

> Click: CRAN.

With a little extra work, most of it done by Claude,

> Read the slide.

> If running long, drop this slide and say the bugs paragraph over the previous one.

---

## 17 · Routine work and judgement — 50 s

The left column is work that used to be put off for the next deadline, and now gets done.

> Click: still mine.

The right column has not changed. If anything it matters more, because I'm producing more
code for each hour of my own attention.

> Click: the standard.

When we evaluated ssdtools against Burrlioz, we asked for the source code, benchmarks, and
simulations with a known answer. I don't get to lower that standard because a model wrote the code. The
methods I used for checking someone else's software are the ones I now use for this.

> Click: a rapidly evolving space.

I think

> Read the slide.

It is for me.

---

## 18 · `bayesnec`, June to October 2026 — 75 s

Things got very busy for the last month or so. I had to prepare a software training course I
was teaching at a conference, and decided to add some significant functionality to bayesnec
at the same time. Things rapidly escalated to the point where I was struggling to read and
check everything being done.

> Click: bugs in the original code.

Every feature or bug fix I tackled resulted in Claude finding more bugs and flaws, many of
them written by humans into the original software.

> Read the slide.

> Click: issues.

I ended up in an endless loop of trying to resolve issues, with Claude or Codex opening even
more issues as fast as they were closed.

> Click: predev.

I couldn't find the time to review everything before merging it to dev, so for now I resorted
to making a predev branch and parking it.

> Click: the limit.

I'm not exactly sure where things will go from here.

> Read the slide.

---

## 19 · Points to take away — 55 s

Three things I'd like to leave you with.

First, the tests, documentation and continuous integration that determine whether
research software outlives its project now take far less time. If you are using AI to work
faster, spend some of the time saved on this work.

> Click: data that cannot be shared.

Second, we still don't have a good pattern for building open, reusable tools on data that
can't be shared. That gap is where a large amount of high-quality industry data stops being
useful to anyone except the client. If you've worked on this problem, I'd like to talk to
you.

> Click: your review.

Third, AI is now producing more than we can realistically review. We need new ways of
thinking about what reviewing that should look like. For me, it is about understanding what
would show if it was wrong, and building simulations and tests to demonstrate that.

But I think this is a moving space that we are going to see some developments for in the
future.

---

## 20 · Contacts and acknowledgements — 15 s

Thank you. The packages, the code for every figure in this talk, and the log of how I used
AI to prepare it are on GitHub. I'm happy to take questions in the session Q&A.


<!-- END GENERATED -->

## Anticipated questions

Questions are taken at the session Q&A at 3:00pm, after the Posit talk. Slide names are given
rather than numbers.

**"How long have you been working this way?"**
Since 20 June 2026, so about four months. The FSSgam work was in the first fortnight, so it
wasn't a matter of having become good at it.

**"Five times is a big claim. How did you measure it?"**
Not directly. Five times is my impression of overall productivity, and I won't defend the
number. What I measured, on *The change since June*, is files changed on a day I worked on
these packages: about 12 before June, 29 in the first five weeks, and 86 since the end of July.
Source code files a day went up about five times. But a file changed is not the same as useful
work, most of the recent volume is bayesnec, and some of that is parked unreviewed on predev.
The composition is the clearer result: tests went from 3% of the files changed to about 16%.
The largest change is in work I previously wasn't doing at all. My output of new statistical
methods did not go up five times.

**"How did you decide a commit was AI-assisted?"**
By date. Everything since 20 June, when I stopped writing code by hand, counts as done with an
AI assistant. The first measurement, in July, used the `Co-Authored-By: Claude` trailer, but
Claude Code and Codex commit as me and not all of it is marked: 887 of the 1,070 commits since
20 June carry the trailer. The scripts are `R/git-evidence.R` for July and
`R/git-evidence-periods.R` for now, in the talk repository, and their output is committed.

**"Isn't that mostly one package?"**
Since the end of July, yes: bayesnec is 80% of the commits and 84% of the files changed. The
first five weeks are spread over four repositories, 78 commits on 11 working days, and show the
same shift towards tests. That is also why there is a slide on one package followed end to
end, FSSgam, where the change does not depend on how I drew the categories.

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
thresholds* shows how the thresholds were set.

**"Did open source get you onto the ssdtools project?"**
No. Years of work in the field, the publication record, and convening workshops with the
people who set these guidelines got me onto it. The software skills mattered once I was there.

**"Why R and not Python?"**
The regulatory community, the statistics and the reviewers were already in R, and `ssdtools`
and `bayesnec` sit on packages such as `brms`, Stan and `fitdistrplus` that would be a lot of
work to reproduce.
