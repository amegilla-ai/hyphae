---
process: checkin
style: structured
triggered_by: User asks for a check-in ("let's do a check-in", "start a check-in", "review my relationships").
writes: One file in `vault/_hyphae/checkins/`, plus targeted updates to reviewed person files, plus any planned contacts or goal changes the user commits to during the session.
---

# checkin

Assess the current state of the user's relationships against their goals, highlight what needs attention, and record what was decided. The check-in is the main moment when the agent takes stock across the vault and surfaces patterns to the user. User-initiated for now (scheduling deferred).

## What a check-in produces

- One check-in file at `vault/_hyphae/checkins/<YYYY-MM-DD>.md` recording who was reviewed and any actions taken (carries `summary` frontmatter for the journal dashboard).
- Updated `## Summary` on each reviewed person where state changed (per D063).
- Updated `last_reviewed` frontmatter on each reviewed person (per D064).
- Zero or more planned contact files created for actions the user commits to.
- Zero or more goal changes written when the user decides to shift a goal.
- Updated `goal_status` on reviewed people whose goal is set (per the RAG definitions in `agent/context/fields/goal.md`).
- Zero or more transitions on past-dated planned contacts (happened / rescheduled / abandoned) - see step 2a.

Each write is confirmed separately with the user (R-P2). A check-in covering five people with two planned contacts and one goal change is several confirmations across the conversation. That's correct - the conversation is the input surface.

## Who gets reviewed

Priority order, applied in sequence:

1. **Stuck against goal** - person has `goal` set to `deepen`, `reconnect`, or `repair`, `goal_status` has been `needs-attention` across multiple check-ins, and the agent can see no planned contact and no recent decision. See `agent/context/fields/goal.md`.
2. **Active goal needs progress** - any person whose `goal_status` is `needs-attention`, regardless of how long it's been so. The goal isn't being met right now.
3. **User-flagged** - people noted in `## Notes` with specific agent instructions to watch.
4. **Long time since reviewed** - `last_reviewed` far in the past relative to other people in the vault. The rotation mechanism: over enough check-ins, every person gets covered.
5. **On track, worth noting** - positive cases, lowest priority; included only if there's room.

Bounds:

- **Default count** - read `checkin_size` from `<vault>/_hyphae/about-user.md` (declared under the `## Check-in size` section); fall back to 5 if unset. User can override for this session ("do them all", "just the urgent ones", or a specific number).
- **User-named people are always in**, on top of the priority count. If the user names three people in the opening and the default is 5, the check-in covers 8 (3 named + top 5 by priority, avoiding duplicates).
- **Respect `last_reviewed`** - don't re-surface someone who was spotlit in a recent check-in unless their state has shifted materially since.
- **Nothing urgent is a valid outcome** - a check-in with nothing at priorities 1-2 can be short, a few people from lower priorities, or "no one needs urgent attention right now" plus whatever the user wanted to cover.

## Steps

1. **State the purpose of the session** in one or two sentences. Example frame (generate at runtime, don't hardcode):
   > "Check-in: I'll look at how your relationships are tracking against your goals, flag anything that needs attention, and we can record any actions you want to take."

2. **Determine the review list.** Read `checkin_size` from about-user.md. Scan the vault: person files for goals, `goal_status`, `last_reviewed`; recent contacts for rhythm and quality; recent check-ins for what was covered. Rank by the priority order above. Pick the top N where N is the user's configured size.

   *How to actually do the ranking (aside):* the priority list above is a strict order, not a scoring function. Walk it priority by priority and collect candidates:

   - Priority 1 (stuck) needs `goal` set to `deepen`/`reconnect`/`repair` AND `goal_status: needs-attention` AND the status has persisted across at least two recent check-ins AND the agent can see nothing in motion. "Something in motion" = a planned contact exists, or a recent check-in decided on one. If no one matches, move on.
   - Priority 2 (active goal needs progress) is any person with `goal_status: needs-attention` who didn't already qualify as priority 1. The goal can be any value, including `maintain`. Whether something is in motion shapes how the agent talks about them in step 4 but doesn't change priority.
   - Priority 3 (user-flagged) reads `## Notes` on person files for explicit agent instructions to watch.
   - Priority 4 (long time since reviewed) compares `last_reviewed` dates across the vault. On the first ever check-in (no prior check-ins, or `last_reviewed` null everywhere) this priority doesn't discriminate - skip it. This is the rotation mechanism that ensures every person eventually gets covered.
   - Priority 5 (on track) is used only to pad the list up to N if priorities 1-4 didn't produce enough.

   Apply the recent-review filter as the last step: if a candidate was spotlit in a check-in within roughly the last week and their state hasn't shifted materially since (no new contact that changed the picture, no planned-contact cancellation, no user note added), drop them and promote the next candidate. "Materially shifted" is an agent judgement - default to dropping.

   Stop at N, where N is `checkin_size` (fallback 5). User-named people in step 3 are additive on top of N.

2a. **Reconcile planned contacts with dates in the past.** Before presenting the review list, scan `_hyphae/contacts/` for files with `planned: true` and a date earlier than today. For each, ask the user - never presume. Hyphae is not a real-time app; a past-dated planned contact just means the agent doesn't know what happened yet.

   Ask in plain language: "You had [mode] planned with [person] for [date]. Did that happen, is it still to come, or is it off?"

   Apply the answer as one of three transitions. Each is a confirmed write on the contact file.

   - **Happened.** Run the normal log_contact elicitation inline (quality, 1-3 sentence narrative grounded in the user's own quality markers from about-user.md). Flip `planned` to `false`. Fold any `action` field into the narrative body as past-tense ("texted her first to confirm") and remove the `action` frontmatter field. The file keeps its id and date; it now reads as a past contact event.

   - **Still to come / rescheduled.** Ask for the new date if the user offers one, otherwise accept "not sure yet - keep it" and either update `date` in frontmatter or leave as-is. `action` stays if still relevant. The file remains `planned: true`. The agent may surface it again in a future check-in when that date has also passed.

   - **Off (abandoned, cancelled).** Flip `planned` to `false` but keep the original date (a record that a plan was formed). Append a one-line note to the body indicating it didn't happen and, optionally, why if the user says - "didn't happen - she got called away" or just "didn't happen." Remove the `action` field. The file is a record of intent-without-execution, useful signal rather than noise to delete.

   If no past-dated planned contacts exist, this step is a no-op - move on to step 3 silently.

   This step runs *before* the priority ranking is finalised because a plan that just happened changes rhythm data for the person involved, and an abandoned plan changes `goal_status` signals. Any transitions made here feed into the step-3 presentation naturally.

3. **Present the list and ask for additions.** Speak the list as a single paragraph in prose, not as a table or numbered breakdown. Cover: who is on the list, the main reason each is on it (goal state, rhythm, recent events), and any deliberate omissions worth naming (e.g. "I've left Lyse and Rosalia off because we covered them yesterday"). Ask the user if they want to add anyone, change the scope ("all", "just the urgent ones"), or drop anyone from the list. Accept the adjusted list.

   The paragraph is for orientation, not justification - keep it one pass, don't enumerate the priority order you walked. Example tone: "For today's check-in I've picked Tim, Hilary, Fuchsia, Jacinda, and Simon. Tim and Fuchsia have active deepen goals but no logged contact yet; Hilary is your inner circle and you haven't caught up in just over a week; Jacinda sounded tired on the last voice note and it's been nearly two weeks; Simon is a deepen goal sitting quiet. I've left off Lyse and Rosalia - both got covered in yesterday's check-in and nothing's changed since. Want to adjust?"

4. **Review each person in turn** - or, where the conditions hold, **review a cluster of people together** (see step 4-group below). For each person (or group):

   a. **Present state as prose** in one or two full sentences, grounded in the data. Cover: layer, goal, last contact and what it was, rhythm against the floor, any planned contact and its action if set, any notable trend. Do **not** prefix with step names, labels, or spec language - the user sees a paragraph about their friend, not an audit trail. Don't write fragment-style assessments either ("25 days ago, group event, positive") - that reads as clinical. Connect the facts into sentences the way you'd speak them. Example tone: "Tim is in your close circle with a deepen goal. There's a coffee planned for next week that he suggested - you need to text him to confirm the place. His first logged contact." Don't say "State against goal: ..." or "Presenting state:" - just speak.

   b. **Assess goal status.** Skip if no goal is set. Otherwise the agent assesses where the relationship is relative to the goal and writes that as `goal_status` on the person's frontmatter. Values: `on-track` (the goal is being met) or `needs-attention` (it isn't). The agent reads planned contacts and recent check-in decisions to know whether there's already something in motion - that detail shapes how the conversation goes, but it doesn't need its own status value. See `agent/context/fields/goal.md`.

      The agent proposes a status based on what the data says - last contact vs floor, any planned contact, recent check-in decisions, any user note since the last review - and presents that as a candidate to the user in plain language. **Don't name the colour label when speaking.** "Red", "amber", "green" are internal - say what the read actually is instead. Example:

      > "It's been eight weeks since you last saw Sam, nothing's planned, and the last check-in didn't land on a next step either - that reads as off-track with nothing in motion. Does that match your perspective, or am I missing something?"

      The user confirms, corrects, or adds context ("actually we've been texting, I just haven't logged it" might shift the read toward on-track or on-track-with-something-in-motion). The agent updates `goal_status` from the final answer - the internal label gets written only to frontmatter, never spoken to the user.

      The status is the underlying signal for how each goal-having relationship is doing. No closeness score; that conflated structure (layer) with feeling and has been dropped.

   b'. **Layer mismatch check.** Look at the person's actual contact frequency over recent history (the last six months or so) against their layer's typical frequency. If they're being contacted much more often than the layer suggests - say, weekly when they're in casual circle (typical: yearly) - raise it during the review:

      > "You've been messaging Michael every couple of weeks but he's in casual circle. Want to move him up to friend or familiar?"

      Skip if the contact pattern matches the layer reasonably. Don't raise on under-contact (the user having less frequent contact with someone is fine; the agent shouldn't pressure them to do more). The check is for "this layer might be wrong" only when actual contact is notably above what the layer's typical suggests.

   c. **Ask what the user wants to do.** Options (stated in plain language, not as a menu):
      - Log something that happened since the last contact that hasn't been captured.
      - Plan a contact - "I'll reach out this week."
      - Change the goal.
      - Leave it as-is and move on.
      - Add a note to the person file.

   d. **Execute each action** the user chooses, confirming the write before each one. For single-person planned contacts this calls out to `log_contact` with `planned: true` - including the light "anything to do first to make that happen?" prompt to capture an optional `action` field (see log_contact.md). For multi-person planned events this calls `plan_group_event` as a subroutine (see plan_group_event.md). For goal changes this calls `change_goal` as a subroutine - the check-in's own confirmation flow handles the per-write OK; the change_goal mechanics (specifics capture, goal_status re-assessment, optional Summary refresh) ride on top. For notes this means appending to `## Notes`. Each is a separate confirmed write.

   e. **Refresh the person's Summary** if state changed materially during this review - per D063 and the material-change heuristic in `log_contact.md`. Present the new Summary; confirm before writing.

   f. **Update `last_reviewed`** on the person's frontmatter to today's date. No separate confirmation - this is a mechanical write that tracks the fact the review happened.

4-group. **Review as a group** when a cluster on the review list shares enough structure that three separate passes would just repeat themselves. This is a variant of step 4, not a new step - the same sub-steps run, just with the group treated as the unit of presentation and assessment rather than each person individually.

   **When the path applies.** All four conditions must hold:

   - The people are connected by an explicit group (a `vault/_hyphae/groups/` file) or a shared planned contact event.
   - Their goals are the same value (e.g. all `transition`, all `maintain`).
   - Their `goal_status` reads converge - the data points the same way for everyone in the cluster (last contact, rhythm, anything in motion). One on-track and one needs-attention is not a group case.
   - There is no individual signal that would surface in a per-person review and not in a group one - no per-person planned action that differs in kind, no per-person note flagging something specific to that relationship.

   If any condition fails, default to per-person review. The path is for genuine structural similarity, not convenience.

   **How the sub-steps adapt.**

   - **a (state).** One paragraph covering the cluster. Name everyone in it; describe the shared frame ("you, Andy, and Diana share an ex-AWS context with a transition goal as you leave on 2026-04-29"); note last contact and rhythm collectively if it really is collective, per-person if not.
   - **b (goal status).** Assess once for the cluster, propose one read, confirm once. If during the conversation the user signals divergence ("actually Diana feels different from the other two"), drop the group path and re-run b per person from that point.
   - **c (what to do).** One ask, one set of options. Most cluster-shaped actions are also cluster-shaped (a single planned group event covers everyone; a shared note belongs on each person's `## Notes`).
   - **d (execute).** Per-person writes still happen individually - `goal_status`, Summary refresh if material, `last_reviewed`. A planned contact for the whole cluster is one contact file with all members in `with`. A note added to the cluster lands on each person's `## Notes` separately. The cluster shapes the conversation, not the file structure.
   - **e (Summary refresh).** Per-person, on the same material-change heuristic. The cluster framing doesn't override D063.
   - **f (`last_reviewed`).** Per-person, every person in the cluster, today's date.

   **Spotlight in the check-in file.** Each person in the cluster appears in `spotlight` as a separate wikilink (the cluster is a presentation device, not a vault entity). The check-in body may write the cluster as a single paragraph naming all members; that's fine.

5. **Ask explicitly about unlogged contacts** before the open reflection. The user often has recent interactions (texts, calls, in-person meetings) that haven't been logged yet, plus plans formed in conversation that aren't in the vault. The open "anything else?" prompt is too unfocused to surface these reliably - ask directly first.

   Two specific prompts, in order:

   - "Any contacts since the last check-in that haven't been logged yet?" - for each one named, run log_contact inline (creates a past-dated contact file with mode, quality, narrative).
   - "Any plans you've made with anyone that aren't yet in the vault?" - for a single-person plan, run log_contact in planned mode inline. For a multi-person plan (more than one participant), run plan_group_event inline (creates a single planned contact with all participants in `with`, optional group attribution, action on the user, prep notes).

   For each named person, if they aren't in the vault, surface honestly and offer add_person inline. New people surfaced this way count as spotlit and get the same per-person treatment as step 4 reviews (Summary refresh if material, last_reviewed update, goal_status if applicable).

   **Event-driven additions to the review.** When step 5b surfaces a multi-person planned event - or when a multi-person plan is formed at any point in the check-in (commonly during step 4d when reviewing one of the participants triggers planning a group event) - the participants who *weren't* on the review list become candidates for review themselves. The path:

   - Name them: "this plan involves Andy and Diana - do you want to review them too while we're here?"
   - If yes, loop back through step 4 for each (or step 4-group if the conditions hold). Their state is read fresh against the new event in flight - a planned event with one of them changes their goal_status read.
   - If no, the plan still gets written, just without the review side. They're listed in the contact's `with` field; they don't appear in the check-in's `spotlight`.
   - User-named additions stay additive on top of `checkin_size` (same rule as step 3) - the configured count was for the priority-driven list, not a cap on the whole session.

   This handles the case where event-planning is the path *into* people-review rather than the other way around. The priority walk surfaces who needs attention; the event conversation surfaces who's in motion. Both paths can lead to a review, and the check-in covers what surfaces by either route.

   Then move to the open reflection beat: "anything else you want to talk about or note?" The user can name more people, raise patterns, or wrap up. If they name more people, loop back through step 4 for each; otherwise move on.

6. **Construct the check-in frontmatter:**
   - `id`: `k_` + 8 random hex chars. Generate fresh.
   - `date`: today's date (YYYY-MM-DD).
   - `spotlight`: list of `[[person-slug]]` wikilinks for everyone actually reviewed (including user-named additions; not including people mentioned in passing without a review).
   - `overall`: optional, 1-5, only if the user volunteered a sense of how things are going in general.
   - `summary`: 1-3 sentence synopsis of the session (generated in step 7a after the body is built; see below).

7. **Construct the check-in body.** Free-text prose summarising the session: who was reviewed, what was decided, any patterns surfaced. Written by the agent in neutral voice, in the user's words where possible. One paragraph per reviewed person is a reasonable default; fewer if the review was light.

7a. **Generate the summary.** After the body is drafted, distil it into a 1-3 sentence synopsis that answers *what should someone take away from this check-in?* - different from the body's "what happened" and different from the closing action list's "what do I do next."

   Required components:
   - **Reviewed count** - "N reviewed."
   - **Actions count** - "M actions generated" (or "No actions generated").
   - **Overall progress assessment** - one sentence characterising the session (moving forward, stuck, mixed). Name any standout case ("most moving forward; Simon is the exception").

   Optional:
   - One sentence for notable exceptions (people skipped and why, reviews that couldn't complete, capacity shifts mid-session).

   Rules for the summary prose:
   - **Relationship language, not machine labels.** No `amber`, `deepen`, `goal_status` - these are agent-internal. Talk about contacts, conversations, plans in the diary.
   - **No interpretive framing.** No "finally", "at last", "still a way to go", "needs to", "should". Fact-stating only.
   - **Name when load-bearing, count when not.** Name the stuck, the big movers, the skipped. Don't name every person whose review was uneventful - the `spotlight` list captures them.
   - **2-4 sentences total.** Long enough to carry the three required components, short enough to render as a single row in the journal Dataview.

   Present the summary to the user. Confirm; revise once if needed. The confirmed summary goes into the `summary` frontmatter field, **always double-quoted** (`summary: "..."`) - prose summaries routinely contain colons, hashes, or other YAML-significant characters that break Obsidian's properties parser when unquoted. See `agent/context/data-model.md` Frontmatter writing conventions.

8. **Construct the filename**: `<YYYY-MM-DD>.md` in `vault/_hyphae/checkins/`. If a check-in already exists for today, append a disambiguator (`-2`, `-3`) rather than overwriting - a user can legitimately do more than one check-in in a day.

9. **Writes happen inline during step 4.** Per-person edits (planned contacts, goal changes, Summary updates, note appends, `last_reviewed`, `goal_status`) are confirmed and written as each person is reviewed, not batched. By the time you reach here, those files already exist. This step is specifically about the *check-in file itself* plus any last-minute items raised in step 5 that haven't been written yet. Name them briefly and confirm: "I'll write today's check-in covering [names] and [any step-5 items]. OK?" One final confirmation for the check-in write.

10. **Write the check-in file.** One file operation at the filename from step 8. If it fails, surface the failure honestly (G-4) - the per-person edits from step 4 have already landed, so a failed check-in file leaves a partial-but-consistent vault (people files updated, no check-in record). Surface that state, don't paper over it.

11. **Confirm plainly and surface the actions** once written. The user leaves the check-in with things to do; name them explicitly so they don't live only in the planned-contact files. List each planned contact with its date, action if set, and the person. Example:
    > "Check-in saved. Four things on you now:
    > - text Hilary where to meet for Sunday (2026-04-19)
    > - call Jacinda tonight (2026-04-16)
    > - message Fuchsia to propose dinner (planned 2026-05-31)
    > - at coffee with Tim (2026-04-25), agree the next one"
    >
    > Omit people whose review produced no action. If there are no actions at all, say so plainly: "Check-in saved. Nothing on you from today's review."

## Rules

- **Confirm each write** (R-P2, G-1). Planned contacts, goal changes, Summary updates, note appends - each is its own confirmation. `last_reviewed` updates ride along as mechanical consequences of the review itself.
- **Never invent patterns** (G-3). If the data doesn't support "Sam seems ambivalent," don't say it. Ground every claim in what's actually in the vault.
- **Neutral voice** (G-5, G-6). State facts; no accusation, no wellness-coding. "Sam: 8 weeks since last contact, below layer-3 floor" not "you've been neglecting Sam."
- **Respect capacity** (G-7). If the user flags they're low on energy during the check-in, offer to pause or shorten. Don't push through the full list.
- **User can exit anytime.** "Let's stop here" ends the check-in; write whatever's been confirmed so far and close cleanly.
- **Never override user answers.** If the user disagrees with an assessment ("no, I'm fine with Sam, that's our normal"), accept and move on. Record the disagreement if it changes state (goal, goal_status, notes).
- **Atomic per-write** (R-P3). One file, one write. No half-written check-ins.

## Edge cases

- **First check-in ever** (no prior check-ins in the vault): priority 4 (long time since reviewed) is meaningless since no one has been reviewed. Skip it; pick from other priorities. Seed `last_reviewed` on everyone reviewed this time.
- **Empty vault** (few or no people): check-in is effectively a capacity conversation. Offer to walk through whichever few people exist, or confirm there's nothing to review yet.
- **User wants "all"** on a 150-person vault: honour it, but warn about scale ("that's a lot - want to do 20 at a time and continue another day?"). Don't refuse but don't force through.
- **Dataview unavailable or stale**: the agent reads contact files directly for rhythm assessment; doesn't rely on Dataview queries rendering correctly.
- **User names a person who isn't in the vault**: surface honestly; offer `add_person` as a follow-up; continue with the rest of the check-in.
- **Goal change during check-in**: write the change inline (frontmatter + `## Goal` body), same mechanic as a future `change_goal` process. When that process is written, check-in can call it as a subroutine.
- **User wants to log a past contact that came up in the review**: run `log_contact` inline for it. Same file structure, same confirmation flow.
- **Cluster diverges mid-review**: the agent started step 4-group but the user's responses surface a divergence ("actually Diana feels different"). Drop the group path from that point. Keep the cluster's shared paragraph as the state read; from sub-step b onward, run per-person for everyone in the cluster.
- **User asks to group people the spec conditions wouldn't**: honour it. The user knows their relationships better than the rule list. Run step 4-group with the user's chosen cluster; if any sub-step gets stuck because the people aren't actually convergent, fall through to per-person.

## Writes

- One check-in file at `vault/_hyphae/checkins/<YYYY-MM-DD>.md` (with `summary` frontmatter).
- `last_reviewed` updated on each reviewed person.
- Summary updates on reviewed people where state changed.
- Planned contact files for any actions committed to.
- Goal changes to any person whose goal was shifted.
- Note appends to any person where the user added one.
