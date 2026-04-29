---
fields: [goal, goal_status]
applies_to: [person]
related: [layer]
---

# Goal and goal status

A paired fields file covering what the user is trying to do with a relationship (`goal`) and where the relationship currently stands against that intent (`goal_status`). Status only has meaning when a goal is set; the two belong together.

## goal

```yaml
field: goal
applies_to: [person]
type: string
required: false
valid: maintain | deepen | reconnect | repair | transition
default: null
```

### What it captures

What the user is actively trying to do with this relationship. Optional. Absence means no active intent - the agent uses layer default cadence and does not frame suggestions around a specific aim.

Each value is an *achievable* thing the agent can help progress on. States (stepping back, remembering someone unreachable) are not goals and don't live here.

### When to set one

When the user expresses active intent in conversation. "I want to be closer to Sam" → `deepen`. "I've lost touch with Priya and want to pick it back up" → `reconnect`. If no such intent has been expressed, leave goal absent.

### When to change one

When the user's active intent shifts, or when the goal has been achieved. Never changed silently. When `goal_status` has been `needs-attention` across multiple check-ins, the agent raises whether the goal still fits - don't assume it's wrong, just ask the question.

### Per-person specifics

The goal value is a category. The specifics for this particular person (who, what, when, what the user is trying) live in a `## Goal` section on the person page, not in frontmatter. Prose, no structure. Present iff a goal is set.

### Values

#### maintain

Sustain this relationship at its current level. Keep contact happening at roughly the typical rhythm for the layer.

- **Cadence**: layer default.
- **Mode**: whatever fits; no preference.
- **Nudge**: standard. Surface when the user is due for contact by layer cadence; nothing more.

#### deepen

Move this relationship closer than it currently is.

- **Cadence**: more frequent than layer default.
- **Mode**: prefer higher-commitment modes (in-person, call) over low-commitment (message) when the user has capacity.
- **Nudge**: slightly elevated. Suggest specific kinds of contact that build closeness (shared activity, deeper conversation) rather than check-ins.

#### reconnect

Restart contact after a lapse. The relationship was once present and has gone quiet; the user wants it back.

- **Cadence**: more frequent than layer default while rebuilding.
- **Mode**: lowest-commitment first (message, voice note), then call, then in-person. Rebuild the habit gradually. Re-entry pressure is the main failure mode.
- **Nudge**: moderate. Low-pressure framing; acknowledge that restarting is the work.

#### repair

Address something specific that damaged the relationship.

- **Cadence**: user-driven. The agent does not prescribe timing; readiness is personal.
- **Mode**: whatever the user chooses; the agent offers concrete repair-specific suggestions when asked (acknowledgement, a bid for connection, a specific apology).
- **Nudge**: none proactive. Never nudge the relationship as if nothing happened.

#### transition

Build an intentional rhythm after a shared context ended - leaving a job, a team reshuffle, a course finishing, a shared life stage closing.

- **Cadence**: layer default once the new rhythm is established; slightly elevated while it is being built.
- **Mode**: explicit invitations that do not rely on the old context. "Coffee?" rather than "see you at the office."
- **Nudge**: moderate. The failure mode for context-dependent relationships is disappearance the moment the context ends, not slow fade; raise this more actively in the early weeks after the transition.

## goal_status

```yaml
field: goal_status
applies_to: [person]
type: string
required: false
valid: on-track | needs-attention
default: null
```

### What it captures

Where the relationship stands against the active goal. Agent-written during check-ins (or when goal changes). Present only when a goal is set; absent otherwise.

Two values, not three. Whether something is "in motion" (a planned contact, a recent decision) is queryable from the data on demand - it doesn't need its own status value. Distinguishing "off track but doing something" from "off track and stalled" matters for *what the agent says next*, not for whether the person belongs in a "needs attention" view.

### Values

#### on-track

The goal is being progressed toward (or, for `maintain`, the rhythm is holding). Nothing for the user to do right now.

#### needs-attention

The goal is not being met. Could be because nothing is planned, or because what was planned isn't producing movement. The agent reads the data (planned contacts, recent check-in decisions, notes) to know which case it is and frames the conversation accordingly - but the status is just the binary "is this person where you want them to be."

### When the agent narrates

The agent speaks in plain prose, not the label. "Sam: off track, nothing planned" or "Tim: off track, but you've got coffee booked" - both render as `goal_status: needs-attention` in frontmatter. The agent works out the in-motion-or-not detail from planned contacts and recent check-ins at the moment of speaking.

### When it gets written

- During check-ins, as part of per-person review.
- When goal changes: agent re-assesses against the new goal.
- Never by the user directly. Agent-produced from the data, confirmed with the user before writing.

### When it gets cleared

- When goal is removed. Status follows goal.

## Agent guidance

- Read goal + goal_status together. Status gives you the trajectory read; goal gives you what the user is aiming for. Low signal from either alone.
- Goal informs *framing* and *suggestion* but does not override capacity. Low capacity wins over every goal.
- When goal is absent, behave as if `maintain` for cadence, but do not frame suggestions as goal-directed - the user has not set an intent, and framing suggestions as "toward your goal" is wrong.
- Never change a goal without confirming in conversation.
- Never write `goal_status` without the user's confirmation. Assess from data, propose to user, confirm before writing.
- Speak in plain language, not the label. "Sam: off track, nothing scheduled" beats "Sam needs attention." The label lives in frontmatter; the agent narrates in prose.
- Watch the pattern across check-ins. A person with goal `deepen` / `reconnect` / `repair` whose status has stayed `needs-attention` across multiple reviews and where the agent can see no planned contact is the worth-raising case - ask whether the goal still fits, or offer help getting movement started. Don't prescribe; ask.
- `maintain` goals can also be `needs-attention`. If contact has fallen below the layer's typical and nothing's planned, a `maintain` relationship isn't being maintained. Same logic.
