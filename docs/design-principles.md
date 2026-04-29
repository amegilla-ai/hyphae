# Hyphae - Design Principles

---

## 1. Product principles (non-negotiable)

These come from the research and requirements. They govern every product decision.

- **Scaffolding, not coaching.** External structure for execution gaps, not advice on how to be a better friend.
- **No failure states.** Nothing in the system implies the user has done something wrong. Ever.
- **Quality over quantity.** Never encourage more contacts or more relationships - encourage better attention to the ones that matter.
- **Lowest possible friction.** Every interaction completable through a short conversation. Free text always welcome, never required.
- **Designed for the most complex user.** ADHD + autism + dyslexia simultaneously. If it works for them, it works for everyone.
- **Privacy first.** Relationship data lives in the user's local vault. Model hosting choice determines what crosses the device boundary, and that choice is always visible and user-controlled.

### Product principles added 2026-04-13

Surfaced during the agent-native redesign.

- **Fields must earn their place.** Every piece of state the system carries has to defend itself. Can it be derived? Can it be inferred from observed data? Can the agent just ask when it needs to know? If yes to any, drop it. Applied today to `contact_mode`, `energy_cost`, `tags`, `groups`, `layer`, `name` - each was a plausible field that couldn't defend itself. Generalises beyond fields: applies to any stored state, any "just in case" scaffolding, any speculative structure.

- **Prefer conversation over form.** When tempted to add a field, ask: could the agent just ask the user when it needs to know? The answer is often yes. Fields are for *intrinsic* facts the system needs every turn. One-off information belongs in conversation and ends up as prose, not structure.

- **Format follows fact, not audience.** Each fact lives in one place, in the format that fits the fact. Operational specs (schemas, tool contracts, processes) are terse and structured. Rationale and narrative are prose. Same principle, one fact, one place - the audience-split was the wrong frame. See `docs/architecture.md` for the full treatment.

- **Frontmatter for intrinsic facts; body for views.** Never store a derivable fact. The person page shows the user's sense of connection, their recent contacts, their planned contacts - but these are views over the actual source data (contact event files, check-in files), not stored values. See D035.

---

## 2. What this is not

Useful to state explicitly to prevent scope creep:

- Not a productivity dashboard - no streaks, no totals, no performance metrics
- Not a social network - no feed, no likes, no follower counts
- Not a therapy tool - warm but not clinical, supportive but not prescriptive
- Not a gamification app - no points, no badges, no completion percentages on relationships
- Not a data-heavy analytics tool - two relationship states maximum per person in any summary view

---

## Cross-references

- Copy rules and accessibility baseline for anything the system renders: `CLAUDE.md`
- Architecture and the three content categories (agent-shaped, human-shaped, bridging): `docs/architecture.md`
- Decisions register: `docs/decisions.md`
- The full argument for the architecture: `docs/agent-native-thesis.md`
