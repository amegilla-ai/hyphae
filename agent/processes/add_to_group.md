---
process: add_to_group
style: structured
triggered_by: User indicates someone should be in an existing group ("add Vinita to AWS", "Sam's part of the book club", "Alice is one of the AWS people too"), or accepts a follow-up offer from `add_person` to add the new person to a mentioned existing group.
writes: One group file at `vault/_hyphae/groups/<slug>.md` - a single edit to the `members` list. No person files touched (membership is owned by the group, queried from person pages).
---

# add_to_group

Add one or more people to an existing group's `members` list. Confirmation-gated. Group membership is owned by the group file (D048); person pages read membership via Dataview backlink, so this process touches only the group file.

For creating a new group, use `add_group`. For removing someone, use `remove_from_group`.

## Inputs (gathered from conversation)

- **group** - one named group. Required. Resolve to a slug under `vault/_hyphae/groups/`.
- **person(s)** - one or more named people. Required. Each resolved to a slug under `vault/people/`.

## Steps

1. **Parse the user's message** for the group and the person(s).

2. **Resolve the group** to a slug under `vault/_hyphae/groups/`.
   - One match: use it.
   - No match: surface honestly - "I don't have a group called [name]. Want to set it up with `add_group`?" - and stop. Don't invent.
   - Ambiguous reference: ask which group.

3. **Resolve each person** to a slug under `vault/people/`. For each name:
   - One match: use it.
   - Multiple matches: ask the user to disambiguate, offering the circle each is in.
   - No match: surface honestly - "I don't have [name] in your vault. Want to add them with `add_person` first, or skip?" - and continue with the rest. Don't invent.

4. **Check current membership.** Read the group file's `members` list. For each resolved person:
   - **Already a member**: surface ("Sam is already in the book club") and skip.
   - **Not a member**: queue for addition.

5. **Summarise before writing.** Read back the planned change in one short sentence:

   > "Adding [name(s)] to the [group name] group. OK?"

   For multiple additions, list them. Wait for confirmation.

6. **Write the group file** atomically. Append the new wikilink(s) to the `members` list, preserving existing entries and ordering. One file operation.

7. **Confirm plainly** once written:

   > "Added [name(s)] to [group name]."

   No automatic follow-ups. The person's page will pick up the membership via its `## Groups` Dataview backlink without further edits.

## Rules

- **Confirm before write** (R-P2, G-1).
- **Never invent a person or group** (G-3). If either can't be resolved, surface and stop or offer the right `add_*` process.
- **Never overwrite** (R-P3). Membership is appended, never replaced. Existing members are preserved.
- **Idempotent.** Adding someone who's already a member is a no-op with a surfaced note, not a duplicate entry.
- **Atomic write** (R-P3). One file, one operation. Multiple additions in one pass land together or not at all.
- **Plain language** (G-5, G-6). Confirmations and surfaces are factual.

## Edge cases

- **Group doesn't exist yet**: offer `add_group` as a follow-up; this process stops.
- **Person doesn't exist yet**: offer `add_person` as a follow-up; continue with the rest of the addition list. The user can re-run `add_to_group` for the new person after.
- **Mixed batch where some are new members and some already members**: handle in one summary - "Sam's already in the book club; adding Priya and Tom. OK?"
- **All requested additions are already members**: surface ("They're all in already - nothing to do") and stop without writing.
- **User backs out at confirmation**: write nothing.
- **User mentions someone "should be in" a group during another process**: the trigger fires; treat as an inline offer rather than a hard interrupt - "Want me to add them to the [group] now, or after?"

## Writes

One file at `vault/_hyphae/groups/<slug>.md` - frontmatter `members:` list extended. No other files touched.
