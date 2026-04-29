---
process: add_group
style: structured
triggered_by: User introduces a group ("add a group for the book club", "set up the allotment crew"), or accepts the follow-up offer from `add_person` when a mentioned group doesn't exist yet.
writes: One file in `vault/_hyphae/groups/<slug>.md`. No person files touched.
---

# add_group

Create a new group through conversation. A group file holds membership (`members` list of person wikilinks) plus a short description. Person pages render membership as a backlink query, so `add_group` touches one file only.

## Topics, field content, and destination

| Topic | Destination |
|---|---|
| Group name | `name` frontmatter + filename slug |
| Members | `members` frontmatter (resolved to `[[person-slug]]` wikilinks) |
| About (what the group is) | `## About` body |

Frontmatter fields not tied to a topic: `id` (generated).

## Steps

1. **Parse the user's opening message** and skip any topics they've already covered (name, members, description).

2. **Name and slug.** Confirm the display name with the user and derive a lowercase-hyphenated slug. Check `vault/_hyphae/groups/` for a collision: if a group with the same slug exists, ask for a different name or a disambiguator.

3. **What the group is.** Ask one short question for a one-line description that answers "what is this group?" - who they are, how they're connected, the shared context. Accept skip. The answer goes into `## About` as a single short paragraph.

4. **Members.** Ask who's in the group. Accept a list in one utterance or name-by-name. For each name:
   - Resolve against `vault/people/**/*.md`.
   - **One match**: use it.
   - **Multiple matches** (e.g. two Sams): ask the user to disambiguate, offering the circle each is in.
   - **No match**: surface honestly - "I don't have [name] in the vault yet; want to add them after, or skip for now?" - and continue without them. Don't chain `add_person` inline.
   - **Empty list is valid** - the user can create the group now and add members later. Confirm once before writing ("no members yet, fine to add them later?").

5. **Construct the frontmatter:**
   - `id` - `g_` plus 8 random hex chars, generated fresh.
   - `name` - from step 2.
   - `members` - list of `[[person-slug]]` wikilinks from step 4 (empty list if none).

6. **Construct the body** from the group template at `agent/templates/group.md`:
   - `## About` - the one-line description from step 3, or left empty if the user skipped.

7. **Construct the filename and path.** `vault/_hyphae/groups/<slug>.md`.

8. **Summarise before writing** in one short sentence:

   > "Adding group '[name]' with [N] members: [short list or 'no members yet']. OK to save?"

   Wait for confirmation.

9. **Write the file** - frontmatter first, a blank line, then the body.

10. **Confirm plainly and offer follow-ups** once written:

    > "Added [name] group."

    Offer follow-ups only when relevant:
    - **If the user mentioned someone not in the vault** during step 4: offer `add_person` for each unresolved name, one at a time.
    - **If the user mentioned a recent or planned group event**: offer `log_contact` with the `group` field set.

    Offer, don't chain.

## Rules

- **Confirm before write** (R-P2, G-1).
- **Never invent members** (G-3). If a name can't be resolved, surface it and move on.
- **Never overwrite** (R-P3). Slug collision = refuse and ask for a different name.
- **Don't create person files implicitly.** Unresolved members are offered as `add_person` follow-ups, not chained inside this process.
- **Neutral voice** (G-5, G-6). State facts, no wellness-coded softeners.
- **Respect silence.** Every question accepts skip; an empty-members group is valid.
- **One question at a time**, never batch.
- **Atomic write** (R-P3) - one file, one write.

## Edge cases

- **Group of one**: ask once ("that's a group of one - sure?") before writing. Usually a sign the user meant a person, not a group.
- **All members are in the same circle folder**: no special treatment; groups cross circles freely.
- **A person mentioned is already in another group**: no conflict; people can belong to multiple groups.
- **User starts the process and backs out**: write nothing, confirm the draft is discarded.
- **User says "the usual crew" or similar vague membership**: ask for specific names; don't guess.
- **Changing membership after creation** (add/remove a member later): out of scope here. Direct edit in Obsidian works, or a later `update_group` process will cover it.

## Writes

One file at `vault/_hyphae/groups/<slug>.md`. No person files touched.
