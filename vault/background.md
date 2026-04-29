## Why this matters

A meta-analysis of 70 studies by Holt-Lunstad and colleagues found that social isolation and loneliness raise the risk of dying early by 26-29% - a risk comparable to smoking 15 cigarettes a day. The mental health effects are larger still: medium-to-large impacts on depression, anxiety, suicidality, and overall wellbeing.

Among neurodiverse adults the numbers are higher. Over 50% of autistic adults experience severe social isolation. 50-60% of children with ADHD have peer relationship difficulties that persist into adulthood. Loneliness, depression, and anxiety run substantially higher than in the general population.

## Why ND brains find social maintenance hard

Maintaining relationships requires executive functions: time awareness, initiation, working memory, social tracking. In neurodiverse brains, these often work differently.

- **ADHD:** working memory failures, time blindness ("a relationship can feel recent when months have passed"), out-of-sight-out-of-mind, initiation deficits, inconsistent follow-through. CHADD's research on ADHD social difficulties is clear that the gap is *deploying* social skills, not lacking them.
- **Autism:** social anxiety (around 50% meet criteria for clinical diagnosis), the "double empathy problem" (social difficulties are bidirectional - non-autistic people struggle to understand autistic communication just as much as the reverse), social exhaustion from masking, sensory sensitivities that make particular modes (phone calls, large gatherings) costly.
- **Dyslexia:** written communication is effortful, working memory and word-finding affect conversational recall.
- **Dyspraxia/DCD:** organisational and processing-speed challenges extend to social planning.

The research across all of these points to the same compensatory mechanism: **external structure**. Calendars and contacts apps were built assuming the internal trackers are present. When they aren't, those tools end up unused.

## Dunbar's circles

The five-layer structure in Hyphae comes from Robin Dunbar's research on the size and structure of human social networks. The numbers come from 23 studies across cultures and historical periods, with sample sizes ranging from thousands to tens of millions of people.

| Layer | Size (cumulative) | Function | Typical |
|---|---|---|---|
| Inner | 2 | Daily presence; partner, possibly a best friend | Daily-ish |
| Close | 5 | The people who'd help you in a crisis | Weekly |
| Friend | 15 | Ordinary social life | Every 4-5 weeks |
| Familiar | 50 | Shared-context friends | Every 6 months |
| Casual | 150 | Wider network, family you don't see often, ex-colleagues | Yearly |

The cadences are typical contact frequencies Dunbar observed at each layer - how often people *do* contact others at that distance. They're observations, not validated minimums. Each user's actual contact pattern with each person is their own *social fingerprint* (Dunbar's term). Two people in your close layer can be contacted ten times a month and twice a month - both are normal patterns within the same layer.

Time follows a steeply weighted distribution: roughly 40% of social time goes to the closest 5, 20% to the next 10, 40% to the remaining 135.

## How ND patterns differ

Recent ND-specific research informs the app and our design further:

- **Networks are smaller and more compressed.** Autistic adults' networks average around 7-8 people (Lei, Qian & Kim 2025). The intimacy and socialising layers often collapse into one.
- **Cadences should be windowed, not strict.** Roberts and Dunbar's contact research was measured over 18+ months; the weekly-monthly thresholds are derived from time-allocation, not validated minimums. ND research on autistic burnout (Raymaker, Mantzalas) supports rolling windows over rigid weekly expectations - "seen at least once in the last 4-6 weeks" fits better than "seen this week."
- **Bimodal contact is normal.** ADHD: intense contact when someone is present, long gaps when they're not. Autism: low in-person frequency paired with high digital frequency (Discord, group chats, parallel-play gaming). Both are real contact.
- **Some friendships pick up where they left off.** Monotropism research documents autistic friendships that survive long gaps because they're interest-anchored rather than contact-anchored. They look like a lapsed relationship on the cadence read but aren't.
- **Layers 4-5 aren't ceremonial.** For autistic adults especially, layer 4-5 is "people I encounter in repeating contexts" (work, hobby groups, online communities) rather than "people I'd invite to a wedding" (Milton 2025).
- **Social withdrawal during low capacity makes things worse over time.** Recovery research supports reduced demand and low-commitment modes during burnout. Going fully silent makes things worse over time.

## Design choices

- **External scaffolding.** The gap is in executive function. Hyphae records, displays, and suggests. Teaching social skills isn't its job.
- **Active contact maintains closeness.** Roberts and Dunbar found that closeness without contact still declines over time. Hyphae uses Dunbar's typical cadences as a reference for whether contact is happening.
- **Concrete next actions.** ND brains often struggle to start tasks even when the motivation is there. A specific next step ("text Sam tonight to suggest Saturday") is easier to act on than a vague intention ("stay in touch with Sam"). Hyphae captures the specific step at planning time.
- **Capacity is finite and variable.** Capacity here means the energy you have available for social connection. It varies week to week for everyone but more sharply for ND people, especially during burnout. Pushing when capacity is low has a measured cost. The agent reads what the user says about capacity and softens the response when it's low.
- **No streaks or volume gamification.** Research shows the mental health benefits of friendship plateau at 2-4 close friends - you don't get more wellbeing from 50 friends than from 4. So Hyphae doesn't try to maximise contact volume. There are no streaks, no "you've connected with X people this month" prompts, no encouragement to add more.
- **Goals optional and per-person.** Most relationships don't have an active intent beyond keeping them going. Goals exist for the cases where the user is actively trying to deepen, reconnect, or repair.
- **No deficit language.** Neurodiversity-affirmative framing throughout. The challenge is the mismatch between how the user's brain works and the implicit expectations of neurotypical social life.
- **Low-commitment modes count.** Voice notes, async messages, sharing a meme - all real contact, especially during low capacity.
- **A coding agent as the interface.** Research backs the premise that form-based tools are high friction for ND users. The conversation interface is Hyphae's answer; a coding agent that already runs locally is the simplest way to deliver it.
- **Plain markdown files.** You own the data. Read it, edit it, sync it, archive it, leave the project at any time.

## For more

Robin Dunbar, *Friends: Understanding the Power of Our Most Important Relationships* (2021) - the lay introduction to the layered-network research that underpins Hyphae.

Deeper reading in the cloned repo:

- `docs/about.md` - the project's purpose and audience
- `docs/theoretical-foundations.md` - full research review with citations
- `docs/research-summary.md` - paper-by-paper summary
- `docs/nd-dunbar-research.md` - ND-specific research review and design implications
- `docs/5whys.md` - root-cause analysis
