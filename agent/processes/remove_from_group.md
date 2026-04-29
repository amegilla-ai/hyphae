---
process: remove_from_group
style: structured
triggered_by: User indicates someone is no longer part of an existing group ("Sam's not in the book club anymore", "drop Vinita from AWS", "Alice left the team").
writes: One group file at `vault/_hyphae/groups/<slug>.md` - a single edit to the `members` list. No person files touched. The person's page Groups query updates automatically once the group file changes.
---

# remove_from_group

Remove one or more people from an existing group's `members` list. Confirmation-gated. Group membership is owned by the group file (D048); the person's `## Groups` Dataview backlink picks up the change without further edits.

For deleting a group entirely, that's a separate (not yet specified) operation - direct file delete in Obsidian works as a stopgap. For adding, use `add_to_group`.

## Inputs (gathered from conversation)

- **group** - one named group. Required. Resolve to a slug under `vault/_hyphae/groups/`.
- **person(s)** - one or more named people. Required. Each resolved to a slug under `vault/people/`.

## Steps

1. **Parse the user's message** for the group and the person(s).

2. **Resolve the group** to a slug under `vault/_hyphae/groups/`.
   - One match: use it.
   - No match: surface honestly - "I don't have a group called [name]" - and stop. Don't invent.
   - Ambiguous reference: ask which group.

3. **Resolve each person** to a slug under `vault/people/`. For each name:
   - One match: use it.
   - Multiple matches: ask the user to disambiguate, offering the circle each is in.
   - No match: surface honestly. The person can't be removed from the group if they aren't in the vault at all - though they can still be in the group's `members` list as a stale entry. Read the group's `members` and check whether the *slug* the user named appears even if the person file is missing; if so, treat as a removal of a stale entry. Otherwise stop.

4. **Check current membership.** Read the group file's `members` list. For each resolved person:
   - **Member**: queue for removal.
   - **Not a member**: surface ("Sam isn't in the book club to begin with") and skip.

5. **Surface the consequence** if the person currently has *only* this group in their membership *and* the user's removal would leave them in zero groups. Mention it as observation, not warning - the user may not care, or they may. Keep it factual.

6. **Summarise before writing.** Read back the planned change in one short sentence:

   > "Removing [name(s)] from the [group name] group. OK?"

   For multiple removals, list them. Wait for confirmation.

7. **Write the group file** atomically. Remove the named wikilink(s) from the `members` list, preserving existing entries and ordering. One file operation.

8. **Confirm plainly** once written:

   > "Removed [name(s)] from [group name]."

   No automatic follow-ups. The person's page picks up the change via its `## Groups` Dataview backlink without further edits.

## Rules

- **Confirm before write** (R-P2, G-1). Removals are deliberate; even small ones get the confirmation beat.
- **Never invent** (G-3). If a name can't be resolved at all, surface and stop.
- **Never overwrite** (R-P3). The group file is edited, not rewritten - existing members not in the removal list are preserved.
- **Idempotent.** Removing someone who isn't a member is a no-op with a surfaced note.
- **Atomic write** (R-P3). One file, one operation. Multiple removals in one pass land together or not at all.
- **Don't delete the person.** Removing from a group never touches the person file. The person continues to exist in the vault.
- **Don't moralise the consequence** (G-5, G-6). State the fact ("they'd be in no groups after this"); don't editorialise ("they'd be untethered" - never).

## Edge cases

- **Group doesn't exist**: stop. No-op.
- **Person isn't in the group**: surface and stop (or skip if part of a batch).
- **Stale entry** (wikilink in `members` points to a person file that doesn't exist): allow the removal as a cleanup operation. Surface that the person file isn't in the vault, but accept the user's intent to clean up the membership list.
- **All requested removals leave members empty**: surface ("That'd leave the group with no members - want to keep the group as-is, or remove it entirely?") and don't auto-delete the group. Group deletion is a separate operation; stop with the empty-members state if confirmed.
- **User backs out at confirmation**: write nothing.
- **User says someone "left X" or "isn't there anymore"**: treat as the trigger; resolve to a removal. Don't auto-add them somewhere else; if a successor group is in play (e.g. someone left team A and joined team B), the user runs `add_to_group` for B as a separate beat.

## Writes

One file at `vault/_hyphae/groups/<slug>.md` - frontmatter `members:` list shortened. No other files touched.
