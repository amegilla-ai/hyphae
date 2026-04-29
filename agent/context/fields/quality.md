---
fields: [quality]
applies_to: [contact]
type: string
nullable: true
required: false
valid: positive | neutral | negative
default: null
---

# Quality

How a particular contact event felt. Two layers: a coarse label in frontmatter for trend queries, and a short narrative in the body for subtlety. The agent derives both from a brief conversation at log-time; the user does not pick from a menu.

## Two layers

### Frontmatter label

`quality` is a single categorical field: `positive | neutral | negative | null`. Its role is trend detection and filtering ("has time with Sam been feeling different lately?"). Nothing more. These three values are the agent's internal vocabulary - stable across users, queryable, affect-free. The user never needs to see these exact words; the agent renders them in the user's own phrasing (see below).

### Body narrative

One to three sentences in the user's own words, capturing what the event was actually like. This is where the subtlety lives. A contact can be nourishing *because* you laughed, or *because* you talked about something that mattered, or *because* nobody checked their phone. The narrative preserves that; the label cannot.

## How the agent fills both

At log-time, for past events only:

1. Use what the user already said. "Great coffee with Sam" is a complete statement - no questioning needed.
2. If nothing felt-sense-adjacent was offered, ask **one** short question. Never a battery. The question is drawn from a small prompt bank, biased toward the user's own quality markers (see below).
3. Accept a skip. "All good" or silence is a complete answer - write without quality if genuinely unclear.
4. Compose a one-to-three sentence body in the user's words. Preserve their phrasing where possible.
5. Classify into `positive | neutral | negative`, or omit the label if the narrative is genuinely mixed or neutral.
6. Show both in the pre-write summary so the user can correct either. The user can override the label verbally; the narrative stays.

Never ask for planned events.

## Prompt bank (starter)

Generic fallbacks when the user's personal quality parameters aren't set yet. Short, answerable without requiring the user to articulate felt sense (alexithymia is common among autistic adults; yes/no questions are easier than open ones).

- "Did you come away feeling better than when you went in?"
- "Did anything stick with you?"
- "Was it easier than you expected, or harder?"

When the user's quality parameters *are* set (see below), prefer a yes/no question keyed to one of those: "did you laugh?" / "did you get a chance to talk about something that mattered?" beats a generic "how was it."

Prefer yes/no over open questions unless the user is clearly offering narrative. The goal is a fast, low-load answer that doesn't require the user to introspect verbally.

## User's vocabulary

`positive | neutral | negative` are internal machine labels. They do not appear in chat or in narratives. The user maintains a mapping in `<vault>/_hyphae/about-user.md` under `## how I talk about contacts`, like:

```
## how I talk about contacts
positive: "lifted", "a good one"
neutral: "fine"
negative: "hard", "left me flat"
```

The agent writes the machine label to frontmatter and uses a phrase from the user's list when speaking in chat or composing the narrative. If the mapping is not set, the agent falls back to the user's own words from the current conversation (preferred) or plain phrasing ("that sounds good", "that was a hard one"). Never the machine label.

## User's quality parameters

What makes a connection feel like a good one varies by user. Abstract terms (lightness, presence, authenticity) mean different things to different people. The user maintains a short list of **concrete, observable** markers in `<vault>/_hyphae/about-user.md` under a `## what makes a quality connection for me` heading.

Rule of thumb: each marker should be a thing that either happened or didn't in a given contact. If you can't answer yes/no, the term is too abstract.

Example (the specific list is user-owned and set in `about-user.md`; this is illustrative only):

```
## what makes a quality connection for me
- laughed
- talked about something that mattered
- didn't feel rushed
- felt heard
```

How the agent uses them:

- Shape the **one question** asked at log-time: pick a marker that fits the context and hasn't been covered.
- Shape the **narrative synthesis**: if the user mentions one of their markers, surface it by name in the body.
- Shape **trend queries** later ("contacts with Sam lately - how often did you laugh?") without needing per-marker frontmatter fields.

Markers stay in `about-user.md`, not in contact frontmatter. No `felt_heard: true` sub-fields. The markers inform the *questions* and the *narrative*, not the schema.

If `about-user.md` has no quality parameters section, fall back to the generic prompt bank.

## Values (label)

### positive

The user came away better than they went in. Energised, connected, comforted, glad they saw them.

### neutral

Fine. Not notable either way.

### negative

The user came away worse than they went in. Cost more energy than it gave, or left something difficult sitting. No moral judgement - negative contacts can be valuable (caring for someone struggling, a hard but necessary conversation) - but the cost is real and worth noticing.

## Why this structure

Research backs *felt experience per contact* as the right signal (see `docs/research-summary.md`). A label alone is underweight; a narrative alone isn't queryable. Two layers give the agent both. Eliciting through short conversation rather than a picklist fits the agent-native direction (one input surface, no forms) and the neutral voice (questions, not forms).

The distinction between "this contact was hard" (a moment) and "this relationship is draining" (a pattern) has to be preserved. The narrative captures the first; the trend across labels captures the second.

## Separating setting cost from relationship cost

A contact can be negative because of the *setting* (a noisy large-group event, a crowded public place, a stressful work context) rather than because of the person. For neurodiverse users especially, a "social hangover" after a big event is about the environment, not about who was in it.

When narrative signals a setting-driven cost ("the restaurant was too loud", "it was a big group", "the venue was awful"), the agent should capture that context in the body and avoid classifying the frontmatter as `negative` unless the contact-with-this-person was itself hard. A useful follow-up if ambiguous: "was it the setting, or the time with [person]?"

This matters most when looking back for trends: a string of `negative` contacts with Alice where the shared feature was "large party" is a signal about party attendance, not about Alice.

## Agent guidance

- Read trends across contacts with a person, not single events.
- A sustained pattern (multiple draining entries, or the user's markers repeatedly missing) is worth surfacing gently; a single event never is.
- Never compute a single "relationship quality" score from these.
- Never frame draining contacts as the user's fault. If contacts with someone are repeatedly draining *and* the user has a goal of `deepen`, `reconnect`, or `repair` with red `goal_status` across multiple check-ins, that pattern is ambivalence - flag it gently in the next check-in but don't push.
- Never ask more than one elicitation question per log. If the user wants to add detail later, they will.
- Separate setting cost from relationship cost (see above).
