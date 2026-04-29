---
process: add_person
style: structured
triggered_by: User introduces someone new ("I want to add Alex", "I met someone called Priya", "can you add my brother Tom").
writes: One file in `vault/people/<circle-folder>/<slug>.md`.
---

# add_person

Introduce a new person to the vault through conversation. The agent asks only what it needs to manage the relationship going forward, one question at a time, and every question accepts "not sure" or "skip." There's no form.

## Topics, field content, and destination

Before asking about each topic below, the agent reads the relevant field file and generates the question wording at runtime from what the field file currently says. Don't hardcode question strings - they'd go stale when field files change. Pointers only.

| Topic | Field content to consult | Destination of the answer |
|---|---|---|
| Name | - | Filename slug (`<slug>.md`) |
| How user knows them | - | `## Notes` (stable context) |
| Layer (closeness) | `agent/context/fields/layer.md` - Values section and Neurodiversity context | Folder path + referenced in `## Summary` (current state) |
| Current rhythm | `agent/context/fields/layer.md` - cadence floors and social fingerprint sections | `## Summary` (current state) |
| Goal | `agent/context/fields/goal.md` - the five values and their descriptions | `goal` frontmatter field (or omitted if no active intent) + referenced in `## Summary` |
| Goal specifics (if goal set) | `agent/context/fields/goal.md` - per-value agent guidance | `## Goal` body section (D060) |
| Anything else going on for them | - | `## Notes` (stable context) |

`## Summary` is a synthesised paragraph describing the current state of the relationship (layer, rhythm, active goal if any). It evolves as the relationship does - later processes rewrite it. `## Notes` holds stable biographical and contextual facts that persist across changes.

Frontmatter fields not tied to a topic: `id` (generated), `created` (today), `cssclasses` (fixed).

## Steps

1. **Parse the user's opening message** and skip any topics they've already covered. If they've given you name, layer, goal, or context in their first sentence, don't re-ask for it.

2. **Name and slug.** Derive a lowercase-hyphenated slug from the name, confirming with the user if anything is ambiguous. Then check for a collision across `vault/people/**/*.md`: if a file with the same slug exists and it's the same person, stop - they're already in the vault; if it's a different person, ask the user for a disambiguator before going further.

3. **How they know them.** One line about how the user knows this person is enough; goes into `## Notes`. While parsing the answer, notice any group-like references ("book club", "the D&D group", "from Acme") - these feed the group offer in step 14 rather than triggering a mid-flow question now.

4. **Layer.** Read `agent/context/fields/layer.md` first, then ask about closeness in plain words grounded in the Values descriptions - never by circle number. Map the answer to a circle folder using the table at the top of `layer.md`. If the user is unsure which layer fits, draw a clarifying question from the value descriptions in the field file.

5. **Current rhythm.** Read `agent/context/fields/layer.md` first, specifically the cadence floors and social fingerprint sections, and ask how often and how the user is usually in touch with this person. This seeds the user's typical pattern so the agent has a reference when reading their later contact history. "Just met, no pattern yet" is a complete answer; capture whatever the user offers as prose for `## Notes`.

6. **Goal.** Read `agent/context/fields/goal.md` first, then ask what the user is trying to do with this relationship, framing the five values as plain-language options. Map the answer to a goal value, and accept "nothing specific" or "not sure yet" - both leave `goal` absent, and that's fine. Don't push.

7. **Goal specifics (only if a goal was set in step 6).** Read the per-value agent guidance in `goal.md` for the specific goal the user chose, and draw the follow-up question from it. Capture the answer as one to three sentences of prose for the `## Goal` body section.

8. **Anything else going on.** Ask whether anything in the person's life right now should inform how the agent thinks about them - health, a difficult life phase, work intensity, something else the user wants to flag. Accept skip; any answer goes into `## Notes`.

9. **Construct the frontmatter:**
   - `id` - `h_` plus 8 random hex chars, generated fresh.
   - `goal` - from step 6, or omit the key entirely if absent.
   - `goal_status` - not set at add_person time. Written by the first check-in that reviews this person (or by `change_goal` when a goal is added later).
   - `created` - today's date in YYYY-MM-DD.
   - `cssclasses` - includes `hyphae-collapse-props`.

10. **Construct the body** from the person template at `agent/templates/person.md`, filling in as follows:
    - `## Summary` - a one-paragraph prose summary of the *current state of the relationship*: layer, rhythm, goal in plain words if set. Two or three sentences, agent-voice. Not biographical. This paragraph evolves as the relationship does - later processes (log_contact, change_goal, check-ins) rewrite it when material things change. Goes above the two Dataview queries (Planned and Connected) from the template.
    - `## Goal` - the template carries this heading always. If a goal was set, fill it with the goal specifics prose from step 7; otherwise leave the section empty for later.
    - `## Notes` - stable context: how the user knows them (step 3), anything notable from step 8 (travels a lot, unwell, etc.). Persists across changes; add_person and later processes append rather than rewriting.
    - `## Groups` - the Dataview backlink query from the template.

11. **Construct the filename and path.** The file is `<slug>.md` inside the circle folder chosen in step 4, giving a full path of `vault/people/<circle-folder>/<slug>.md`.

12. **Summarise before writing** in one or two short sentences that reflect the user's own framing back, so they can correct anything before the write happens. Template:

    > "Adding [name] to your [circle] - [how they know them]. Goal is [goal in plain words, or 'nothing specific for now']. OK to save?"

    Wait for confirmation.

13. **Write the file** - frontmatter first, a blank line, then the body.

14. **Confirm plainly and offer follow-ups** once written:

    > "Added [name] to your [circle]."

    Then offer follow-ups based on what the user mentioned during the conversation, without chaining them automatically:

    - **If they mentioned a group** ("she's in the book club"): check `vault/_hyphae/groups/` for a matching group file. If one exists, offer to add the person: "You mentioned the book club - want me to add her to the members?" Membership edits on an existing group are a direct frontmatter update; add_person itself writes no group file.
    - **If they mentioned a group that doesn't exist yet**: offer `add_group` as a follow-up - "You mentioned the book club - want to set that group up now?"
    - **If they mentioned an interaction**: offer `log_contact` as a follow-up: "You mentioned you saw them last weekend - want me to log that too?"

    Offer, don't chain. The user says yes or no and add_person is done either way.

## Rules

- **Confirm before write** (R-P2, G-1). Every new person is a deliberate addition, not an implicit one.
- **Never invent details** (G-3). If the user didn't say it, it doesn't go in the file. `goal` absent is the default, not `maintain`.
- **Never overwrite** (R-P3). If a slug collision isn't resolved to "same person," refuse and ask for a different slug.
- **Plain language for layer** - never ask "which circle?" by number.
- **Neutral voice throughout** (G-5, G-6). State facts, no wellness-coded softeners.
- **Respect silence.** Every question accepts "not sure" or "skip," and an incomplete person file is fine; more can land later.
- **One question at a time**, never batch.
- **Atomic write** (R-P3) - one file, one write, no partial state.
- **Don't create contact events** as part of add_person. Even if the user mentions a recent interaction, offer `log_contact` as a follow-up rather than doing it implicitly.

## Edge cases

- **Only a first name** ("add Priya"): a first-name slug is fine if there's no collision. If a Priya already exists, ask for a surname or disambiguator.
- **User volunteers a lot at once** ("Priya is a close friend from uni, we haven't talked in a year, I want to reconnect, she got married last year and I missed it"): extract everything you can from the single utterance - name, layer, goal, goal specifics, notes - and only ask follow-ups for what's still genuinely missing.
- **User has just met the person**: default layer to casual (5) unless they say otherwise, rhythm is "just met, no pattern yet," goal is usually absent.
- **User describes someone distant but wants them closer** (a lapsed friendship): the layer reflects the current state and the goal reflects the intent, so familiar (4) with goal `reconnect` is a coherent pair.
- **"My brother Tom"**: ask the user what name to use as the slug rather than picking one yourself.
- **User starts the process and backs out**: write nothing and confirm the draft is discarded.
- **Existing person with the same name in a different circle**: surface it - "You already have Sam in your friend circle. Same person, or different?" - and proceed from the answer.

## Writes

One file at `vault/people/<circle-folder>/<slug>.md`. No other files touched, no contact events created.
