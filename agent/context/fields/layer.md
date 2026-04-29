---
fields: [layer]
applies_to: [person]
type: int
required: false
derived: true
derived_from: folder
valid: 1-5
---

# Layer

Which of the five Dunbar circles this person belongs to.

## Where it lives

**Not in frontmatter.** Layer is derived from the folder path. Moving a person file between circle folders is the only way to change their layer. See D049.

| Folder | Layer | Cumulative size |
|---|---|---|
| `people/A. inner-circle (2)/` | 1 | 2 |
| `people/B. close-circle (5)/` | 2 | 5 |
| `people/C. friend-circle (15)/` | 3 | 15 |
| `people/D. familiar-circle (50)/` | 4 | 50 |
| `people/E. casual-circle (150)/` | 5 | 150 |

Sizes are cumulative, not disjoint - layer 2 contains the 5 closest people *including* the 2 innermost. In the vault a person lives in one folder (their tightest layer), but the agent should treat a layer-2 person as also a member of layers 3, 4, and 5 when reasoning about sizes or averages.

## The layers

Each layer has a distinct function, not just a size and typical contact frequency. What going quiet looks like differs by layer too.

### 1 - inner (up to 2)

A partner, and possibly a best friend. The people most central to your life. **Contact is usually daily.** Hyphae splits these out from Dunbar's innermost 5 because their function is different - they're not a group, they're the closest one or two.

### 2 - close (up to 5)

The people you'd turn to in a crisis. You could ask them for real help - emotional, practical, financial. Going quiet with these people costs more than at any other layer. **Typical contact: at least weekly.**

### 3 - friend (up to 15)

The people you do ordinary social life with - meet for dinner, go out for the evening, hang out on a weekend. Going quiet with everyone in this layer thins out everyday social life. **Typical contact: every 4-5 weeks.**

### 4 - familiar (up to 50)

People you see through repeating contexts - hobby groups, work adjacencies, online communities, neighbourhood regulars - or people you'd invite to a BBQ or a birthday party. Contact happens because of the context or the event, not because you're making individual plans. **Typical contact: every 6 months.**

### 5 - casual (up to 150)

People who are still friends - you'd show up for each other at a wedding or funeral - but you don't see each other often. Extended family, previous colleagues and classmates, long-standing friends, online friends. **Typical contact: at least once a year. Below that, contact this rare often means the relationship has effectively lapsed.**

Frequencies are typical patterns Dunbar observed at each layer - how often people *do* contact others at that distance, not how often they *must*. Hyphae uses them as floors the agent watches against, but they aren't validated minimums; each user's actual contact pattern is their own (see Social fingerprint below). Layers 1 and 2 share "at least weekly" because the research figure for the innermost 5 is weekly; they differ in function (daily-presence vs crisis-support), not frequency.

## Time allocation

Dunbar's research also gives us how humans *actually* distribute social time across the 150:

- ~40% on the innermost 5 (layers 1-2 combined)
- ~20% on the next 10 (layer 3 minus layers 1-2, so the additional people reaching to 15)
- ~40% across the remaining 135 (layers 4-5)

The agent doesn't need to enforce these; they're a useful sanity check. If the user is spending 90% of their social time at layer 5, something is off.

## Social fingerprint

Contact rhythm is user-specific. Two people can both be in layer 2 and one is contacted ten times a month, the other two times. Both are healthy if that's the user's normal pattern with each person. The floor numbers above are population-level research observations; the agent should learn the *user's* pattern with *this* person over time. Two reads worth noticing in conversation: contact has gone notably below Dunbar's typical for the layer, or notably below the user's own typical with this person. Neither is a problem on its own - both are context the agent can mention during a check-in, never grounds for pushing.

There are also two stable whole-network patterns: some people have a few very close friendships and many weak ones; others have more close and fewer weak. The agent should not pressure users toward any particular pattern. The layer sizes are capacities, not targets.

## Neurodiversity context and wellbeing

The floor cadences and layer functions above are calibrated to general-population Dunbar research. Neurodiverse users commonly show patterns that differ from these expectations. That difference is not in itself a problem.

**The principle: the user defines their own rhythm and their own network. The agent's job is not to enforce population norms - but it *is* to watch for wellbeing.**

What that means in practice:

- **Respect the user's choices** about number of people, cadence with each person, layer population, mode of contact. Population norms are reference, not prescription. A network of 10 with most contact happening in a Discord server is as valid as a network of 100 at weekly coffees.
- **Push back gently when a pattern suggests the user is avoiding something that costs them.** Examples worth raising: sustained isolation from the close circle during a difficult period; long silence from people the user has explicitly said they want closer to (goal: `deepen` or `reconnect`); repeated negative-quality contacts with someone the user feels stuck with; full social withdrawal extending well beyond the burnout research window.
- **Never frame pushback as guilt.** Neutral voice rules apply. Present as observation + invitation: "Sam: 6 weeks since last contact. You've mentioned work has been heavy. Want to think about who you'd reach out to right now?" Not "you should call someone."
- **Wellbeing is the north star, autonomy is the method.** The agent holds both at once. Respecting autonomy doesn't discharge the wellbeing role; defending wellbeing doesn't override autonomy.

### Patterns the agent reads in context

These are patterns of healthy ND contact the agent should recognise and not mistake for a lapsed relationship. Reading a person in context means checking these before flagging. None of them exempt the user from wellbeing checks - they just change what "healthy" looks like.

- **Smaller total networks** (autism). 7-15 people is common. Layer 4-5 may be functionally empty; not a gap.
- **Compressed middle layers** (autism). Intimacy often sits in 1-3 people; layer 3's socialising function often migrates into context-communities (hobby groups, Discord, interest-based activities) rather than individual friendships.
- **Bimodal contact rhythm** (ADHD, AuDHD). Intense contact then long absences. Object permanence and time blindness drive this. Variance itself is signal, not noise.
- **Digital and asynchronous channels** (autism, AuDHD). Voice notes, group chats, parallel-play gaming, async communities. Count symmetrically with in-person.
- **Mode preferences** (dyslexia). Text-heavy communication is costly; voice and in-person may carry more weight than written.
- **Planning and logistics costs** (dyspraxia, ADHD). Flaky-looking cancellations may not reflect relationship strength.
- **Time and date tracking** (dyscalculia, ADHD time blindness). Missed anniversaries and date-computations are genuinely hard; not indifference.
- **High-stakes setting avoidance** (anxiety, Tourette's, sensory). Absence from large events is not absence from the relationship. See `quality.md` on separating setting cost from relationship cost.

User declarations in `<vault>/_hyphae/about-user.md` (optional - user may set personal layer capacities and neurodiversity context, or leave blank) inform how the agent reads each person's history. Absence of declaration is not absence of consideration - the agent reads patterns either way.

See `docs/nd-dunbar-research.md` for the research behind this section.

## How layer changes

The user (or agent, with confirmation) moves the file into a different circle folder. That single action is the layer change - there's no separate field to update.

## Agent guidance

- Parse the folder path to know a person's layer.
- Use Dunbar's typical frequencies as a reference for "how often people at this distance usually keep in touch." Compare against observed history with the individual to read where this particular relationship sits. Frame conversationally - "haven't heard from X in a while" - never "you're behind."
- Use function per layer to inform *what* to suggest, not just how often. A layer-2 nudge is about availability for difficult things; a layer-4 nudge is about events ("invite them to something").
- If contact frequency is consistently much higher than Dunbar's typical for the person's layer, ask whether the layer still fits - they may belong in a tighter circle. (The reverse - much lower contact than Dunbar's typical - is not a layer mismatch by itself; could just be the user's pattern with this person.)
- Never enforce time-allocation percentages. Use them only as a sanity check if the user explicitly asks "how am I spending my social time?"
- Respect individual variation. Two close friendships and the rest weak is a valid pattern; twelve close friendships and no weak ties is also valid.
