---
process: log_contact
style: structured
triggered_by: User reports an interaction (past or planned) with one or more people.
writes: One file in `vault/_hyphae/contacts/` - created for new events, or updated in-place when the user is confirming a previously-planned event.
---

# log_contact

Record a contact event. One file per event, regardless of how many people were involved.

## Inputs (gathered from conversation)

- **with** - one or more people. Required. Resolve each to an existing person file.
- **date** - YYYY-MM-DD. Required. Ask if the user hasn't given one. Past tense without a date is not an implicit "today" - "I had coffee with Sam" could be this morning or last week. Only treat it as today if the user explicitly says so ("just now", "today", "this morning", "earlier"). Vague phrases ("recently", "the other day", "last week") always need a clarifying question.
- **mode** - free text. Required. Common values: `in-person`, `message`, `call`, `voice-note`, `async`, `channel` (ongoing shared-space contact like a Discord server or WhatsApp group). User can also write anything else they prefer (`letters`, `crossword-by-post`, whatever fits). Infer from what the user said ("we had coffee" -> `in-person`, "texted" -> `message`). Prefer a common value when one fits so trend queries work.
- **planned** - bool. True if the event is future; false/absent if past. Infer from tense and date.
- **action** - free text. Optional, only meaningful when `planned: true`. What the user needs to do to make the contact happen ("text her first", "book the restaurant", "check my calendar"). Captured if the user volunteers it; the agent also asks one light prompt when planning a contact - "anything to do first to make that happen?" - which accepts skip without pushing. The prompt exists because ND executive function means "I'll reach out" as a commitment often silently fails to happen; making the prep step concrete helps it land. Folded into the narrative body and removed from frontmatter when the contact becomes past (update branch).
- **quality** - two layers: a frontmatter label (`positive`, `neutral`, `negative`, or omitted - internal machine labels, never shown to the user) and a body narrative in the user's words. Only relevant for past events. Derived by the agent from what the user said plus at most one follow-up question. See `agent/context/fields/quality.md` for the full model, the vocabulary mapping, the prompt bank, and how to use the user's quality parameters from `about-user.md`.
- **group** - wikilink to a group slug. Optional. Set when the user references a group by name ("book club", "family dinner") and a matching group file exists.
- **notes** - free text for the body. Optional. For past events, this includes the one-to-three sentence quality narrative composed from the user's words (see `agent/context/fields/quality.md`). For planned events, usually empty unless the user adds context.

## Steps

1. **Parse the user's message** for the fields above. Do not ask for fields the user has already given or that can be inferred.
2. **Resolve each person** mentioned to a slug under `vault/people/`:
   - Search across all circle folders.
   - If one match: use it.
   - If multiple matches (e.g. two Sams): ask the user to disambiguate, offering the circle each is in.
   - If no match: tell the user the person isn't in the vault yet and ask whether to run `add_person` first. Do not invent a person.
3. **Resolve the group** if one was mentioned, the same way against `vault/_hyphae/groups/`.
   - **Group resolved and user named no individuals**: expand the group's `members` list into `with`. Confirm back ("dinner with food-lovers - that's Fuchsia, Mary and Sandor. Same cast, or different?"). The user can drop or add names before writing.
   - **Group resolved and user also named individuals**: use the named list for `with`; still set `group` so the event is traceable to the group. Don't auto-expand.
   - **Group not found**: offer `add_group` as a follow-up, or skip the `group` field and continue with just the named individuals.
4. **Capture mode.** Prefer a common value (`in-person`, `message`, `call`, `voice-note`, `async`, `channel`) if one fits. If the user's phrasing genuinely doesn't match a common value, use their wording.
5. **Check for a matching planned contact (past events only).** When the user reports that something happened ("I had the call with Dad", "we got coffee yesterday"), search `vault/_hyphae/contacts/` for entries where `planned: true`, `with` includes the same person(s), and `date` is within ±7 days of the reported date.
   - **One match:** ask "I have [mode] with [person] planned for [date]. Update that one rather than creating a new entry?" Default to yes on confirmation. If the user confirms, switch to the update path (see "Update branch" below).
   - **Multiple matches:** list them briefly and ask which one, or "none - make a new entry."
   - **No match:** proceed with creation.
   - **Skip the check** if the user explicitly says "new contact" or "separate from the planned one," or if the reported date is clearly not the planned one (e.g. >7 days off and the user hasn't flagged it).
6. **Fill remaining optional fields** only if the user offered them. Do not interrogate.
7. **Quality elicitation (past events only):**
   - If the user already said how it felt, use that. No question.
   - Otherwise ask **one** short question, drawn from the prompt bank in `agent/context/fields/quality.md`. Prefer a question keyed to one of the user's quality parameters in `<vault>/_hyphae/about-user.md` if set; otherwise use a generic prompt.
   - Accept skip/silence as a complete answer. If genuinely unclear, omit the label and write a minimal narrative (or none).
   - Compose a one-to-three sentence narrative in the user's own words. Preserve their phrasing where possible.
   - Classify internally into `positive | neutral | negative`, or omit the label if genuinely mixed/unclear. Never show these machine labels to the user; render in the user's vocabulary from `about-user.md` (or plain phrasing if unset).
8. **Construct the frontmatter** (creation path):
   - `id`: `c_` + 8 random hex chars. Generate fresh; do not reuse.
   - `date`: from input.
   - `with`: list of `[[person-slug]]` wikilinks.
   - `mode`: from input.
   - `planned`: true or false; omit if false and you prefer to keep frontmatter lean.
   - `action`: include only if `planned: true` and the user gave one (either volunteered or in response to the light "anything to do first?" prompt). Omit otherwise.
   - `quality`: include only if classified in step 7 and event is past. Value is the machine label (`positive | neutral | negative`), never the user's phrasing.
   - `group`: include only if resolved.
9. **Construct the filename**: `<YYYY-MM-DD>-<primary-slug>.md` where `primary-slug` is the first person in `with`, or the group slug if a group event. If the filename already exists, append a short disambiguator (`-2`, `-3`).
10. **Path**: `vault/_hyphae/contacts/<filename>` during development (dummy vault write target). See R-P5.
11. **Summarise before writing**. Read back in one short sentence, using the user's vocabulary (not the machine label): "Logging: coffee with Sam, 2026-04-14, positive - you laughed and left feeling lighter. OK to save?" Wait for confirmation. The user can override the quality reading or the narrative verbally.
12. **Write the file**. Frontmatter first, blank line, then the narrative body.
13. **Seed or refresh the person's Summary.** For each person in `with`, read the person file:
    - **If `## Summary` has no prose paragraph** (just the Dataview queries, or blank): seed it. Draft a one-paragraph Summary from what you know - layer, goal if set, this contact plus any prior ones, whatever's available. Confirm with the user before writing.
    - **If a Summary paragraph already exists**: only refresh if this contact is materially new signal. See *Material change* below. If no trigger fires, leave Summary alone.
    Never write Summary without the user's explicit OK.
14. **Confirm plainly** once written: "Logged - your coffee with Sam is in." Never "saved successfully" or clinical acknowledgements. If Summary was updated in step 13, that shows up as a separate confirmation in step 13 rather than here.

## Update branch (when step 5 matched a planned contact)

Instead of creating a new file:

1. **Read the planned file** identified in step 5. Preserve its `id`.
2. **Update frontmatter**:
   - `planned`: remove the key (or set to `false`). The default for past events is planned absent.
   - `date`: replace with the actual date if different from the planned date. Note the shift in the narrative ("pushed to Tuesday").
   - `mode`: replace if the actual mode differed from the planned one.
   - `quality`: set from step 7 (machine label).
   - `action`: if present, remove from frontmatter. Fold its content into the narrative body (step 4) so the prep step persists as part of the event's history rather than as a pending commitment.
   - `with` and `group`: leave unless the actual event had different participants.
3. **Update the filename** if the date changed: rename to `<actual-date>-<primary-slug>.md`. If the new filename collides, append a disambiguator.
4. **Append or set the body** to the one-to-three sentence narrative from step 7. If the planned file had an `action`, weave it into the narrative naturally ("Texted her first to set it up, then we talked for an hour about...") rather than appending as a separate line.
5. **Summarise before writing**, same format as step 11 but framed as an update: "Updating the planned coffee with Sam - sounds like a good one, you laughed and left feeling lighter. OK to save?"
6. **Write the file** atomically.
7. **Seed or refresh the person's Summary** - same check as step 13 of the creation path. Seed if empty; refresh only on material change if present.
8. **Confirm plainly**: "Updated - your coffee with Sam is in." If the file was renamed, mention the new name.

## Rules

- **Confirm before write** (R-P2, G-1). Even for trusted users, this process is not marked trusted by default.
- **Never invent a person** (G-3). If `with` can't be resolved, stop and offer `add_person`.
- **Never overwrite an existing file**. If the target path exists, add a disambiguator to the filename.
- **Write to the dummy vault** unless the session has been promoted to write against the real vault (R-P5).
- **Neutral voice** in any confirmation or question (G-5, G-6). State facts; no accusation, no wellness-coding.
- **Atomic write** (R-P3). One file, one write. No partial state.
- **Summary updates are confirmed separately.** A contact write and a Summary refresh are two decisions; the user gets to accept or decline each independently.

## Material change (for Summary refresh in step 13)

Per D063, `## Summary` on a person's page describes the *current state of the relationship*. It should stay current, not get rewritten on every contact. A contact is "materially new signal" - and therefore warrants a Summary refresh offer - when any of the following holds:

- **Lapse broken.** The new contact is the first in a stretch that Summary was describing as a gap ("haven't been in touch lately", "it's been a while"). Summary should now reflect the restart.
- **Quality trending differently from what Summary implies.** Summary implies a good rhythm; the last 2-3 contacts (including this one) are consistently `negative`. Or the reverse.
- **Mode shift** that changes the picture materially. Summary says "weekly calls"; the last handful have been text-only. Or a new mode joins the mix (channel, in-person after years of message-only, etc.).
- **Progress toward (or away from) an active goal.** For `deepen`: a contact that widens activities, deepens conversation, or raises frequency above the existing rhythm. For `reconnect`: any contact after a lapse. For `repair`: a contact that addresses the thing (or conspicuously avoids it). Summary should reflect the trajectory.
- **Explicit user cue during the conversation.** "Things have been different with her lately", "we've been talking more since X" - the user is telling you Summary is out of date.

When none of these hold, don't offer a Summary change. Most routine contacts won't trigger it, and that's correct - Summary exists to hold the current picture, not to be churned by every event.

When a refresh *is* warranted:
1. Draft a replacement Summary paragraph (one paragraph, current state of the relationship, same voice as add_person).
2. Show the user the old and new side-by-side (or just the new, if the diff is obvious): "Summary for Sam is currently '[...]'. Want me to update it to '[...]'?"
3. Accept or decline. If declined, leave Summary alone and move on. If accepted, write the person file with the new Summary paragraph in place.

## Edge cases

- **Multiple people, one event**: one file, `with` lists all of them. Do not write one file per person.
- **Group event**: set `group` to the group wikilink; `with` still lists each participant individually so per-person queries work.
- **User logs something much older** (e.g. "I saw Priya in November"): ask for the approximate date; accept partial precision by asking "do you remember roughly which week?" and landing on a best-guess date. Note the approximation in the body.
- **User logs an intention** ("I'm planning to call Dad Sunday"): `planned: true`, omit `quality`, confirm and write.
- **User logs a past event that was planned** ("I had that call with Dad", "we did get coffee"): step 5 matches the planned entry; take the update branch so there's one file per event, not two. If the user pushes back and wants a new entry, honour that.
- **Planned event was a group, actual contact was individual**: don't update the group planned entry - create a new individual contact. The planned group event stays as-is unless the user says otherwise.
- **Planned and actual dates are far apart (>7 days)**: don't auto-match. Ask: "I see a planned coffee with Sam two weeks ago - is this the same one, or new?"
- **User logs and wants to add quality later**: write without quality now; they can edit the file in Obsidian or ask the agent to update it.
- **Person exists in the real vault but not the dummy vault** (common during dev): tell the user honestly. Do not silently create a stub.

## Writes

One file at `vault/_hyphae/contacts/<YYYY-MM-DD>-<slug>.md`. Either a new file (creation path) or an update to an existing planned file (update branch). No other files touched.
