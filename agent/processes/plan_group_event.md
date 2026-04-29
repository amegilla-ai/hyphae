---
process: plan_group_event
style: structured
triggered_by: User wants to plan a multi-person event ("let's plan dinner with the AWS gang", "I want to organise drinks with Beth, Bruno and Martin", "the ex-MSFT crew should get together").
writes: One planned contact file in `vault/_hyphae/contacts/`, optionally triggering reviews of participants via the checkin event-driven path.
---

# plan_group_event

Capture a multi-person event as one planned contact, with the right participants, group attribution if any, and an action on the user. Formalises the pattern that recurs in check-ins: AWS farewell, six-way night-out, ex-MSFT dinner, cross-group meetups.

This process only fires when the event has a date or the user intends to set one in this conversation. "We should organise something eventually" without a date stays in the relevant person's `## Notes` until it firms up - don't write a contact file with a placeholder date.

## Inputs (gathered from conversation)

- **Participants** - one or more people. Required. Resolve each to an existing person file. Non-vault attendees (a partner, a friend's friend) are noted in the body, not added to `with`.
- **Group** - optional wikilink to a group file. Set when the participants map cleanly to an existing group, even if not all members are attending. Don't invent groups - offer `add_group` if the user names a group that doesn't exist.
- **Date** - YYYY-MM-DD. Required. If the user only has a rough idea ("sometime in June"), ask for their best guess - the file can be moved later.
- **Mode** - usually `in-person` for group events; messages/calls work too. Required.
- **Action on the user** - free text. The prep step the user owns to make it happen ("send the invite", "book a place", "prep cards and a speech"). Captured if volunteered, asked once with the standard light prompt otherwise.
- **Notes** - free text for the body. Optional. Used to capture: actions other participants own (Abhi books the venue, Andy brings the wine), non-vault attendees (Beth's husband Ian), or context the user wants on the event itself.

## Steps

1. **Parse the user's message** for the fields above. Skip anything already given.

2. **Resolve participants.** For each named person, search across `vault/people/`:
   - One match: use it.
   - Multiple matches: ask which one.
   - No match: tell the user honestly. Offer `add_person` as a follow-up; let the user choose whether to do it now or proceed without that person.

3. **Resolve the group, if any.**
   - **User named a group:** check `vault/_hyphae/groups/` for a matching file. If one exists, set `group`. Then check the group's `members` against the named participants - if the user named individuals and the group has additional members not on the list, raise it once: "the AWS group has Andy, Diana, Abhi, Vinita - you've named the first three. Add Vinita too, or just the three?" Accept the user's call.
   - **User named a group that doesn't exist:** offer `add_group` as a follow-up. If the user declines, skip the `group` field and proceed with the named individuals.
   - **User named no group, but the participants map to one:** if all named participants are members of the same existing group, raise it once: "Beth, Bruno and Martin - they're not in a group, but should this be tracked under a new group like 'oz-pub' or similar?" Accept skip; default to no group attribution. Don't push.

4. **Date.** If the user gave a date, use it. If they're vague ("sometime in June"), ask for their best guess. The file can move later if the date firms up.

5. **Mode.** Default to `in-person` for events that obviously are. For ambiguous cases ("a chat with the team"), ask once.

6. **Action on the user.** If volunteered, use it. Otherwise ask the standard light prompt: "anything to do first to make that happen?" Accept skip.

7. **Other participants' actions or context.** Ask once: "anyone else doing prep for this - venue, gift, anything you want to track here?" Accept skip. Whatever the user gives lands in the body, not in `action` (which is the user's prep only).

8. **Construct the frontmatter:**
   - `id`: `c_` + 8 random hex chars. Generate fresh.
   - `date`: from input.
   - `with`: list of `[[person-slug]]` wikilinks, one per resolved participant.
   - `mode`: from input.
   - `planned`: `true`.
   - `action`: include only if the user gave one. The user's prep, not other participants'.
   - `group`: include only if resolved.

9. **Construct the body** as one to three sentences in plain language. Cover: what the event is, who else is attending who's not in `with` (non-vault people), other participants' actions if any, any context the user wants. Empty body is fine if there's nothing to add.

10. **Construct the filename**: `<YYYY-MM-DD>-<primary-slug>.md` where `primary-slug` is the group slug if a group is set, otherwise the first person in `with`. If the filename collides, append a disambiguator (`-2`, `-3`).

11. **Summarise before writing.** Read back in one short paragraph: who, when, where if known, what's on you. Example: "Logging the AWS farewell on 2026-04-29 with Andy, Diana and Abhi - in-person, action on you to prep cards and a speech, Abhi's booking the venue. OK to save?" Wait for confirmation.

12. **Write the file.** Frontmatter first, blank line, then the body.

13. **Confirm plainly** once written: "Logged - the [event] is in." If a group was attributed, mention it.

14. **Offer event-driven reviews.** If the conversation is happening inside a check-in (the agent is partway through `checkin`), check whether any participants weren't on the existing review list. Per the checkin event-driven additions path: name them and ask if the user wants to review them while they're here. Outside a check-in, this step is a no-op - skip.

## Rules

- **Confirm before write** (R-P2, G-1).
- **Never invent a person or group** (G-3). If a name doesn't resolve, surface honestly and offer `add_person` or `add_group`.
- **One file per event.** A six-person dinner is one contact file with six entries in `with`, not six files.
- **No date, no file.** If the user is just brainstorming, leave the idea in the relevant person's `## Notes` until they're ready to commit a date. Don't write a placeholder.
- **Action is the user's prep only.** Other participants' prep goes in the body. The frontmatter `action` field is what the user has to do.
- **Atomic write** (R-P3). One file, one write.
- **Neutral voice** (G-5, G-6). State facts; no wellness-coding.

## Edge cases

- **Group event with attendees who aren't in the vault** (a friend's partner, a colleague's friend): name them in the body, don't add to `with`. The contact file tracks the user's relationships; non-vault people are context.
- **Partial-group event** (some but not all group members attending): set `group` to the group wikilink so the event is traceable; `with` lists only the actual attendees. The full group's `members` list is unaffected.
- **Cross-group event** (members from two groups): set `group` to whichever group is the closer fit, or omit if neither fits cleanly. Mention the cross-group nature in the body.
- **Event has multiple prep steps for the user** ("book the venue and prep a speech and bring cards"): captured as one compound `action` string. The current data model doesn't break it down further - the granularity-of-action item in the roadmap covers when this becomes painful.
- **Event date moves** before it happens: rename the file to the new date, update `date` in frontmatter. The check-in step 2a reconciliation handles this when it surfaces.
- **User wants to brainstorm participants and then write the event:** that's fine - run steps 2-7 conversationally, only write at step 11. The user can adjust the participant list across the conversation; nothing's committed until confirmation.

## Writes

One file at `vault/_hyphae/contacts/<YYYY-MM-DD>-<primary-slug>.md`. No other files touched. May trigger event-driven reviews via the checkin process if running inside one.
