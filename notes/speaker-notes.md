# Speaker notes — full narration

These are the same notes embedded in `talk/index.qmd` as `::: {.notes}` blocks (press `s`
in the rendered deck), gathered here as continuous prose for rehearsal and for editing
without touching the slides.

**Do not read this aloud verbatim.** It is written at speaking length so the timings are
honest, but the delivery should be looser than the text.

---

## 1 · The sewage outfall at your local beach — 0:45

> Open cold. Do not introduce yourself yet — earn the next nineteen minutes first.

The sewage outfall at your local beach discharges under a licence. So does a produced-water
stream off the North West Shelf. Both of them are licensed against a number — a safe
concentration, contaminant by contaminant.

Exceed it and operations get modified, or shut down, sometimes at enormous expense. Set it
too high and you quietly lose the receiving environment.

Somebody has to be able to defend that number — to the regulator, to the proponent, and
eventually, possibly, to a court.

That number comes out of an R package.

*(beat)*

Some of you in this room maintain packages. I'd like you to sit with that for a second.

---

## 2 · Where the number comes from — 1:00

Thirty seconds of ecotoxicology, and then I'll leave it alone, I promise.

This is a species sensitivity distribution — an SSD. It is the workhorse of water quality
guideline derivation in Australia, New Zealand, Canada, the EU and the US.

Each black dot is a single species. Somebody ran a toxicity experiment on it. You fit a
distribution through those points, and you read off the concentration that protects, say,
95% of the community. That's your guideline value. In Australia the default ones are called
DGVs, and the way I describe them is: they are the environmental equivalent of the 0.05
blood alcohol limit. Below it you're assumed to be fine. Above it, things stop.

Which is a great deal of weight to hang on twenty-odd dots and a curve.

---

## 3 · Which curve, though? — 1:00

And here is the problem that turned me into a software developer.

Same data. Six perfectly defensible distributions. Six different legal limits.

There is no theoretical basis — none — for preferring one of these distributions over
another. It isn't as though there's a mechanism that says toxicity has to be log-normal. So
the choice of distribution is doing real regulatory work, and historically it was being made
on more or less aesthetic grounds.

The statistical answer is: don't choose. Model-average over all of them, weighted. That's
the orange line.

The *software* answer is that until very recently, the tool mandated for this in Australia
fitted exactly one distribution — and you couldn't see inside it.

---

## 4 · Divider: Part one — 0:10

So how does a person with no programming training end up responsible for that?

Badly. Badly is the answer. Let me show you the shape of it.

---

## 5 · Fifteen years, three eras — 0:50

The y-axis here is the only thing I want you to take from this slide. It isn't
sophistication. It's *how far the thing could travel*.

Same person throughout. And honestly, much the same statistics — I understood mixture
distributions in 2012 about as well as I do now. What changed was entirely about
distribution, maintenance, and trust.

For context: I'm a quantitative ecologist. I have a PhD in marine biology. I have had
exactly zero formal training in programming. What I had was a solid grasp of applied
statistics and a supply of real problems.

---

## 6 · Era one: the lone scripter — 1:15

This is the paper I am least embarrassed by and the software I am most embarrassed by.

ElicitN was a tool for eliciting expert judgement in a rigorous, repeatable way — we used it
to produce the first expert-based estimate of global coral reef diversity. The statistics
were genuinely novel and it went into *Environmental Modelling & Software*.

The software was fifty-seven R scripts. Twenty-five doing statistics, and thirty-two more
driving a Tcl/Tk graphical interface, because I had decided the experts needed a GUI. You
ran it by `source()`-ing a control script called `wElicitN.r`. You obtained it by emailing
me, or off SourceForge.

Not a package. No tests. No version control. Nothing anywhere that would tell me — or anyone
else — if it broke.

And it worked. It genuinely, properly worked.

And then R changed, and Tcl/Tk changed, and the hard drive it was developed on went away,
and within about five years that software was effectively dead. The paper is still cited.
The tool is a fossil.

> **15-min cut:** drop the "how you ran it" detail. Keep: 57 scripts, zip file, dead in
> five years.

---

## 7 · The science outlived the software — 0:30

> Pause. Let it land.

This is the lesson I would hand to anybody starting out: your paper will outlive your code
by about a decade, and nobody warns you about that.

Peer review interrogated my statistics extremely thoroughly. It asked precisely zero
questions about whether the software would still run in 2017.

---

## 8 · Era two: packages, and the discipline they impose — 1:25

Era two starts, honestly, with a filing problem.

FSSgam began life as a function I'd written for one paper — full-subsets model selection.
Then people emailed asking for it. Then they emailed asking why it didn't work on their
data. Making it a package was self-defence.

Here is the part I think is under-said at open-science meetings. I did not go to GitHub in
order to collaborate. I went to GitHub because I needed a way to send somebody a thing that
worked, that I could then fix without re-emailing a zip file. The collaboration came later,
and frankly it came as a surprise.

And `R CMD check` — I want to be sincere about this — is the most patient and least
political reviewer I have ever worked with. It has never once told me that my approach is
interesting but might be better suited to a more specialist journal. It just tells me,
consistently and immediately, exactly what is wrong.

> **15-min cut:** drop the FSSgam origin anecdote. Keep GitHub-as-delivery and `R CMD check`.

---

## 9 · The data most of you will never see — 1:30

A detour, but it matters for the argument.

We talk about white literature — peer-reviewed papers. And grey literature — reports,
theses, things that are public but not indexed. I've started calling the third tier black.
It's industry monitoring data. Compliance data. It is real, it is enormous, it is high
quality precisely because a regulator is watching — and it is confidential.

One example. A single capital dredging campaign at Barrow Island: over fifteen hundred
individual coral colonies, tagged and scored every fortnight, for five hundred and thirty
days. Water quality logged every ten minutes across three separate pressure pathways.

I have never seen a research funding programme that comes anywhere close to being able to
pay for that.

And here is the tension that sits at the centre of my whole career: I cannot give you that
data. I genuinely cannot.

But I can give you the method. Open code is how black data becomes public good. The dataset
stays confidential. The thing we learned to do with it does not have to.

> **15-min cut:** drop the ten-minute logging detail. Keep 1,500 corals / 530 days.

---

## 10 · What that data bought: a number, without an SSD — 1:05  *(first to cut)*

> **This slide carries a technical distinction that matters.** The dredging thresholds are
> not SSD-based and never were — that work predates my SSD involvement entirely. Don't let
> the two strands blur.

Here's what we did with it, and it is a completely different route to a regulatory number.

No SSD here. An SSD needs toxicity estimates for a lot of species. At Barrow Island we had
one receptor that mattered — coral, the habitat-forming organism — one site, one campaign.
An SSD wasn't available to us, and wouldn't have been the right tool anyway.

So instead we built the dose–response relationship *in situ*. Dredging exposure metrics on
one axis; on the other, the Bayesian posterior probability of non-zero coral mortality at
each site relative to the controls.

And then, to get a threshold out of that, we used ROC curves. Because a threshold is a
decision rule, and decision rules have error rates. A false positive costs a proponent
money. A false negative costs you a reef. Those two are not symmetric and they are not
really commensurable, and almost nobody sets thresholds with that in mind.

So you pick your operating point deliberately. A high-power threshold — cheap to trigger,
tells you mortality is *possible*. A low-alarm-rate threshold — hard to trigger, tells you
mortality is *probable*. Different management actions hang off each one.

That's Fisher et al. 2018 in the *Journal of Applied Ecology*, and it long predates any of
my SSD work. Two quite different statistical routes, both ending in a number that stops a
vessel.

And the transferable point for you: any time your software emits a threshold, somebody
downstream is making a decision with asymmetric costs — and you probably have more influence
over how that goes than you think you do.

> **If you cut this slide,** add a clause to slide 9 so the black-data slide still has a
> payoff: *"— and what we got out of it was a set of in-situ dredging thresholds, derived
> from ROC curves rather than from an SSD."*

---

## 11 · Era two, part two: the ecotoxicology pivot — 1:35

Around 2020 I moved properly into statistical ecotoxicology — so, back to the SSD strand —
and hit the same shape of problem one level down.

Remember that every dot on that SSD is one species' "no effect" estimate. It turns out
there are at least four things this field calls "no effect", and only one of them actually
means it.

The NEC is a genuine threshold — a parameter in a model that says below here, nothing
happens. The NOEC is the highest concentration somebody happened to test that wasn't
statistically distinguishable from the control — which makes it a fact about your
experimental design rather than about the organism. And the EC10 is, by definition, a ten
per cent effect. We are calling a ten per cent effect "no effect".

Whichever one your software computes becomes the input to the SSD, and therefore becomes
the guideline value.

So we built `bayesnec` — Bayesian concentration-response modelling, model averaging again,
this time over curve shapes rather than distributions. And along the way David Fox and I
defined a new statistic, the NSEC, because having the software made it testable.

That's the direction of causation I want to flag. The software didn't implement the method.
The software made the method possible.

> **15-min cut:** name NEC and EC10 only. Keep the causation point — it's the whole reason
> the slide exists.

---

## 12 · `ssdtools`: the part I did not expect — 1:25

And then this happened, which I still find slightly absurd.

I was brought into a joint Australian–Canadian project, funded by what is now DCCEEW, to
evaluate whether `ssdtools` — an open-source R package originally written by Joe Thorley
and Carl Schwarz in British Columbia — could replace Burrlioz 2.0, which was the mandated
tool in Australia. Burrlioz fits one distribution family. It's closed.

We didn't argue about it. We benchmarked it. Real datasets first, and then simulated
datasets where we knew the true answer, so we could actually measure bias and coverage.
`ssdtools` won. And notably: including *more* candidate distributions beat including fewer,
which is not the intuition most people start with.

The final report ran to a hundred and eighty-three pages. The recommendation was adopted.
An open-source R package is now the default tool for deriving water quality guideline
values across three jurisdictions — and I'm a contributor to it.

> **15-min cut:** drop the collaborator names; they're on the slide.

---

## 13 · You cannot get three regulators to agree on a black box — 1:10

> This is the keystone, and it now closes act two. If you only keep one slide from act two,
> keep this one.

The reason the Australian and the Canadian experts could reach collective agreement is that
every single one of us could read the source, run the benchmarks, and disagree in public
about specific lines of code.

Try running that process on a compiled desktop application whose internals nobody outside
the vendor can inspect. You can't. You end up arguing from authority, and then the outcome
depends on who is in the room.

So: open source in a regulatory setting isn't primarily about cost. It isn't even primarily
about reproducibility. It is a governance mechanism. It is the thing that makes multi-party
agreement structurally possible.

And I'd add one practical rider. The Shiny front end matters as much as the package does. A
regulator in a state agency is not going to sit down and write R. `shinyssdtools` is how the
open method actually reaches the person making the decision. Open source that only reaches
people who already write R isn't finished.

---

## 14 · Divider: Part two — 0:05

Right. The bit you're actually here for.

---

## 15 · I have not written a line of code in about a year — 0:40

Since subscribing to Claude Code I have essentially not written code by hand. And I'd
estimate I am about five times more productive.

Now — I want to be careful here, because "5×" is exactly the kind of claim that makes a room
of experienced developers fold their arms, and they are right to.

So let me be specific about where it actually comes from. Because it is *not* where I
assumed it would be.

---

## 16 · The speed-up is not in the typing — 1:25

> Say out loud that this chart is my own estimate, not a measurement. Don't let it pass as
> data.

That chart is illustrative — it's my own sense of where my effort goes, not something I
measured.

Typing was never the bottleneck. I could always type. Badly, but I could type.

The bottleneck was that an entire category of work was, in practice, *not worth doing*.
Test coverage on a package with one user — me. Vignettes. Refactoring something that already
works. Setting up CI. Responding properly to a CRAN note instead of the minimum. Every one
of those had a real, immediate cost and a diffuse, deferred benefit. And so every one of
them lost, every single time, to the next paper.

What has actually changed is that the tax on doing it properly collapsed. The unglamorous
work — which is precisely the work that determines whether software is still alive in five
years — got cheap.

And look at the right-hand end of that bottom bar: nearly half my time now goes on the
problem itself. That is the trade I made. It is a much better trade than "I type faster".

---

## 17 · What actually changed — 1:00

Left column: things that used to lose to the next deadline, every time. They don't now.

Right column: unchanged. Completely unchanged.

And I'd argue the right column got *more* important, not less — because I am now producing
considerably more code per unit of my own attention. The ratio of code to scrutiny has moved
in a dangerous direction, and the only thing holding it in place is domain judgement.

If you take one practical thing from this talk: the statistical judgement is the moat. Not
the syntax.

---

## 18 · The awkward symmetry — 1:10

Here's the thing that keeps me honest.

The entire `ssdtools`-versus-Burrlioz exercise was me insisting on a standard of evidence.
Show me the source. Show me the benchmarks. Show me the bias and the coverage on data where
we already know the truth.

I do not get to relax that standard just because the code was written by a model instead of
by a vendor. If anything it is more pressing, because the failure modes are less familiar
and the output is a great deal more fluent. Fluent-and-wrong is a genuinely new hazard, and
our instincts aren't calibrated for it yet.

So: same standard. Simulate. Benchmark. Check coverage. Verify against the published
implementation. It turns out the methods I already had for interrogating somebody else's
software are exactly the methods I need for this.

> **If cutting slide 19,** append: "— and I log every AI-assisted session to the repository,
> because reproducibility now has to cover how the code came to exist, not just how to run
> it."

---

## 19 · Provenance, out loud — 0:55  *(second to cut)*

Briefly, because I think this is under-discussed and this is the right room for it.

I keep a prompt log. Every AI-assisted session on a project gets written to a `prompts/`
folder in the repository — what I asked, what came back, what I then did about it. This talk
included; it's in the repo, alongside the code that made every figure you've seen.

Partly that's a publication-disclosure question, and I expect journals to catch up on it.
But mostly it is the same instinct as recording which instrument you used. Reproducibility
has quietly expanded: it used to mean "can somebody re-run this". It now also has to mean
"can somebody reconstruct how this came to exist".

I don't think we have collectively worked out the right standard yet. I would rather
over-record while we do.

---

## 20 · Three things I'd tell 2012 me — 1:10

> Land these deliberately. Slow down. This is the last thing they'll remember.

One. **Regulation runs on software**, and most of the people writing that software have no
idea of the blast radius. If you work in a regulated domain — health, finance, environment —
go and find out what your code is load-bearing for. It is almost always more than you think.

Two. **Open code is a multiplier on data you can't share.** That isn't a compromise
position; in industry-partnered science it is the whole game.

Three. **You do not need to be a programmer to start.** I had no training. I had applied
statistics and problems that mattered. That was enough — and starting badly in public beats
not starting.

And the last one. The unglamorous maintenance work was always the work. It just got cheap
enough that there is no longer an excuse.

---

## 21 · Thank you — 0:25

Thank you. Everything is open — the packages, the code behind every figure in this deck, and
the prompt log for how the deck itself got made.

Happy to take questions. I'm especially interested if anybody here works on software that's
load-bearing for a regulation and has thought about what verification ought to look like now.

---

## Anticipated questions

**"Five times is a big claim — how did you measure it?"**
I didn't, and I say so on the slide. It's a subjective estimate and the honest version is
that the multiplier is largest on work I previously wasn't doing at all. Nothing in my
throughput of *novel statistical methods* went up 5×; my throughput of tests, documentation
and maintenance did.

**"How do you verify code you didn't write?"**
Exactly the way we verified Burrlioz: simulate data with a known answer, measure bias and
coverage, benchmark against the existing implementation. It's the standard ecotoxicology
already had for software; it transfers directly.

**"Doesn't this deskill the field?"**
It removes a barrier that was filtering on the wrong thing. I was never a good programmer
and the field lost nothing by my being slow at it. What it would lose is people who can't
tell when an answer is wrong — and that skill is unaffected by this technology, which is
precisely why it's now the scarce one.

**"Is your work confidential? Can we see the data?"**
No to the data, in most cases. Yes to the methods and the code, always. That's the point of
slide 9.

**"Are the dredging thresholds SSD-based?"**
No — and this is worth being precise about, because the talk shows two different routes to a
regulatory number. The dredging work (Fisher et al. 2018, *J. Appl. Ecol.* 55:415) derived
thresholds from *in situ* dose–response relationships and ROC curves, for a single
habitat-forming receptor at a single site. It predates my SSD work entirely. The SSD strand
— `ssdtools`, `bayesnec` — is about national default guideline values derived from
laboratory toxicity data across many species. Same destination, completely different
machinery.

**"Why R and not Python?"**
Because the regulatory community, the statistics, and the reviewers were all already in R,
and because `ssdtools` and `bayesnec` sit on top of an ecosystem — `brms`, `Stan`,
`fitdistrplus` — that would have been a large amount of work to reproduce. It's a network
effect argument, not a language-quality one.
