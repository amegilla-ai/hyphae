---
process: describe_person
style: structured
triggered_by: User asks about a specific person ("tell me about Sam", "what's going on with Priya", "remind me where I'm at with Tim", "give me the picture on Andy"), or implicitly references one in a way that needs grounding before the conversation can continue.
writes: Nothing. Read-only.
---

# describe_person

Compose a grounded answer about a specific person from their vault footprint. Reads the person file, the contacts they appear in, the groups they belong to, and any check-ins that spotlit them. Synthesises into prose at the depth the user asked for. No writes.

The job is to *describe what's there*, not to interpret, advise, or nudge. Suggestions and assessments come from other processes (check-in, change_goal, who_needs_attention). Here the agent is a reader, not a coach.

## Inputs (gathered from conversation)

- **person** - one named person. Required. Resolve to a slug under `vault/people/`.
- **depth** - inferred from the question. Default is brief (3-5 sentences). The user can ask for more ("the full picture", "everything") or less ("one line"). When the user's question implies a focus (e.g. "where am I at with the goal", "how's the rhythm holding up"), narrow the answer to that.

## Steps

1. **Resolve the person.** Search `vault/people/**/*.md` for the slug. Multiple matches: ask which (offer the circle each is in). No match: surface honestly - "I don't have anyone called [name] in your vault. Want to add them?" - and stop. Don't invent.

2. **Read the vault footprint** for that person. The agent needs the same source material a human would skim:
   - The person file (frontmatter + all body sections).
   - Contact files in `_hyphae/contacts/` where this person appears in `with`. Both past and planned.
   - Group files in `_hyphae/groups/` whose `members` include this person.
   - Check-in files in `_hyphae/checkins/` whose `spotlight` includes this person, ordered most recent first. Take at most the three most recent for a brief description; more for the full picture.

   Do this read in one pass; don't lazy-load mid-answer.

3. **Pick the depth.** Read the user's question for cues:
   - "Who is X?" / "Tell me about X" / "Remind me about X" -> brief default (3-5 sentences).
   - "What's going on with X?" / "How are things with X?" -> brief, weighted toward current state and recent activity.
   - "The full picture on X" / "Everything you have on X" / "Walk me through X" -> long form.
   - "One line on X" / "Quick: who's X?" -> tight, two sentences max.
   - Focused question ("where's the goal at?", "how's the rhythm?", "what did we say last check-in?") -> narrow to the focus, ignore the rest.

4. **Compose the description.** Use the source material; do not invent. Structure depends on depth:

   - **Tight (1-2 sentences)**: layer + the single most defining fact. "Sam's in your friend circle, your closest mate from the Sydney years."

   - **Brief (3-5 sentences, default)**: layer + goal in plain words (if set) + last contact (when, mode, quality if logged) + next planned (date, action if set) + any standout stable context from `## Notes`. One paragraph.

   - **Long form**: layer, goal and goal specifics from `## Goal`, current state from `## Summary`, recent contact rhythm (last 3-5 contacts with mode and quality), upcoming planned contacts, group membership, stable context from `## Notes`, latest check-in mention if relevant. Two or three short paragraphs is plenty - long form does not mean exhaustive.

   - **Focused**: speak only to the focus. If the user asked about the goal, draw from frontmatter + `## Goal` + the goal_status read; ignore biographical context unless it's directly relevant.

5. **Speak the source, not the schema.** Translate machine labels into the user's vocabulary:
   - Goal: "deepen" -> "you're trying to get closer"; "reconnect" -> "rebuilding contact after a lapse"; "transition" -> "moving the relationship onto a new footing"; "maintain" -> "holding the rhythm steady"; "repair" -> "addressing something that went wrong."
   - Goal status: never name the colour. "On track", "off track but with something in motion", "off track with nothing scheduled."
   - Layer: speak the function, not the number. "Friend circle - the people you'd invite to a party"; "casual circle - wider network." Or just "in your friend circle" if context makes the meaning obvious.
   - Quality: "positive" -> "a good one"; "negative" -> "rough", "didn't go well", or whatever the user's narrative actually said. Prefer the user's own phrasing from the contact body where present.
   - Dates: "8 weeks ago" or "last Wednesday" beats "2026-02-25" most of the time. Use the date when precision matters (a planned contact you need to remember).

6. **Don't fill silence with synthesis.** If a section is empty, say so when relevant ("Nothing in their Notes") or just leave it out. Don't invent a Summary if the file doesn't have one. Don't infer a goal that isn't set ("they're probably a deepen for you" - never).

   In particular, **never extrapolate emotional weight** from neutral facts. The contact file says "she's unwell, but good to see her"; the description says "she's unwell" - not "which sat heavy" or "and that was hard." The user's narrative is the source; if they didn't write the feeling, don't add it. Quote phrasing if useful; never colour beyond it.

7. **Surface gaps the user might want to act on**, but as observation, not nudge:
   - File missing required fields (no `id`, broken `created`).
   - Empty `## Summary` on someone with logged contact history.
   - Goal set but `goal_status` null and they haven't been spotlit recently.
   - Planned contact with a date in the past.
   These are factual ("their Summary is empty - the data is there, just not synthesised") not directive ("you should write a Summary"). The user decides whether to act.

8. **End with an offer, not a question.** Brief and tight descriptions can end as plain statements. Long form can close with one optional offer if a natural follow-up exists - "Want me to log a contact, plan something, or change the goal?" - but only if the description surfaced a real prompt. Don't fish.

## Rules

- **Read-only.** No file is written by this process. Ever.
- **Never invent** (G-3). If a fact isn't in the vault, don't include it. "Probably", "I think", "they seem to be" are tells - rewrite as "the file doesn't say" or omit.
- **Match the user's framing.** If they speak warmly, speak warmly. If they speak briskly, be brisk. The vault holds neutral facts; the rendering matches the user's register.
- **Plain language for layer, goal, status** (G-5). The machine labels are agent-internal.
- **Don't moralise** (CLAUDE.md neutral voice rules). "Six weeks since you last spoke" - don't add "which is a long time."
- **Person-page content belongs to the user.** `## Notes` are *your notes about Sam*, not "Sam's notes." Same for `## Goal`, `## Summary`. Never attribute to the person.
- **Goal is the user's intent, not the relationship's state.** "Your aim with Sam is to deepen" - never "Sam is deepening" or "the relationship is transitioning." Goals belong to the user; the agent narrates them as such. Same for goal specifics in `## Goal` body and the framing of any planned-contact action - state the user's aim, not an inferred motion of the relationship or the other person.
- **Default to `they/them`** unless the user has used a specific pronoun for this person, or the file declares one explicitly. Names don't imply gender.
- **One person at a time.** "Tell me about Sam and Priya" - either ask which to start with, or describe each in turn as separate beats. Don't conflate.

## Edge cases

- **Person doesn't exist in the vault**: surface honestly, offer `add_person`. Don't describe from name alone.
- **Person exists but the file is nearly empty** (just frontmatter, no Summary, no contacts logged): say what's there ("In your friend circle, no goal set, no logged contacts - they're recently added or undescribed") and offer to seed Summary or log a contact if the user has material to add.
- **User asks about someone they haven't logged anything for in years**: long-lapsed. Describe what's there, including the gap; do not editorialise about the gap. The user's the one who decides what it means.
- **Multiple people with the same first name**: ask which. "I have a Sam in your close circle and a Sam in your familiar circle - which?"
- **User asks about a group ("tell me about the book club")**: out of scope for this process. Direct read of the group file is the lightweight path; a future `describe_group` process can formalise it.
- **User asks something hybrid ("what's going on with Sam and Priya - are they on good terms with each other?")**: split into separate descriptions, each grounded in their own file. Don't synthesise across files for inter-person dynamics that aren't recorded - say "the vault doesn't track that directly" if asked.
- **Dataview-rendered queries on the person page**: those render in Obsidian; the agent reading this process reads the underlying contact files directly (per the check-in spec's edge case). Don't quote the Dataview block; quote what it would resolve to.

## Writes

None. The process is read-only.
