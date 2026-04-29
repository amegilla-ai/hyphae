---
process: change_goal
style: structured
triggered_by: User signals a shift in intent for a relationship ("I want to start deepening with Sam", "I'm letting the Priya thing go", "the reconnect with Walter is done - we're back in rhythm"), or accepts a check-in offer to revisit a goal that has stayed red across multiple reviews.
writes: One person file - frontmatter (`goal`, `goal_status`) and the `## Goal` body section. May trigger a `## Summary` refresh if the change is material. No other files touched.
---

# change_goal

Change a person's goal value, the per-person specifics in `## Goal`, and re-assess `goal_status` against the new goal. Confirmation-gated. The user always sets intent; the agent proposes wording and confirms before writing.

## Inputs (gathered from conversation)

- **person** - the person whose goal is changing. Resolve to a slug under `vault/people/`.
- **new goal value** - one of `maintain`, `deepen`, `reconnect`, `repair`, `transition`, or absent (no active intent). The user says it in plain language; the agent maps to a value. See `agent/context/fields/goal.md` for the per-value descriptions.
- **goal specifics** - one to three sentences capturing what the user is actually trying to do with this person, for the `## Goal` body section. Specific, observable, time-bound where possible. Empty if no goal is set.
- **goal_status** - re-assessed against the new goal once the change lands. Same rules as the check-in process. Agent-proposed, user-confirmed.

## Steps

1. **Parse the user's message.** They've named a person and signalled a shift. Extract: who, what direction (set / change / clear), and any specifics they've already given.

2. **Resolve the person** to a slug under `vault/people/`. If multiple matches, ask which. If no match, surface honestly and offer `add_person` as a follow-up; do not invent.

3. **Read the current state.** Open the person file: current `goal`, current `goal_status`, current `## Goal` body, current `## Summary`. Hold these so you can compare and so the user can correct if memory and file disagree.

4. **Confirm the new goal value.** Say back what you understood in plain language (not the machine label) and propose a value. Example:

   > "You're saying you want to settle into a regular rhythm with Sam now you're not in the same office - that reads as a deepen goal (move closer than you are now) rather than maintain (hold the current level). Match your perspective?"

   The user confirms, corrects ("no, just maintain"), or sharpens ("more like reconnect - we'd lapsed").

   - If the new value is the same as the current one, surface that ("Sam's already on deepen") and ask whether the specifics are what's actually changing. If yes, jump to step 5. If the user wanted a different value, take the corrected answer.
   - If the user wants to **clear** the goal (no active intent), confirm and skip to step 7 with `goal` to be removed, `## Goal` body emptied, and `goal_status` cleared.

5. **Capture goal specifics.** Read the per-value agent guidance in `goal.md` for the new value, and draw a follow-up question from it. Goal specifics are concrete and observable; vague specifics ("just want to be better friends") rot fast. Press once for a more specific framing if the answer is too abstract; accept what the user gives on second pass.

   Compose the specifics as one to three sentences for the `## Goal` body. Use the user's own framing where possible. State the intent and any concrete first move. Don't restate the machine label.

6. **Assess goal_status against the new goal.** The new goal changes the trajectory question, so old status doesn't carry. The status is binary: `on-track` if the goal is being met, `needs-attention` if not. Read the data to know which:

   - Is rhythm and recent quality consistent with the goal?
   - Is there a planned contact with this person?
   - Did a recent check-in (≤ 8 weeks) capture a decision about them?
   - Does `## Notes` or `## Goal` carry a recent commitment?

   If the goal is being met, it's `on-track`. If not, it's `needs-attention`. The agent uses the planned-contact / recent-decision detail to shape the conversation (whether to ask "what would help?" vs "is the planned thing still right?"), but the status value is the binary.

   Speak the read in plain language, not the label. Example:

   > "There's a coffee planned with Sam for next week and you're going to message him first - that's needs-attention but with a plan in motion. Does that match?"

   User confirms or corrects. Agent updates `goal_status` from the final answer.

7. **Decide whether to refresh `## Summary`.** Per D063, Summary describes the *current state of the relationship*. A goal change is usually a material shift (the new aim is now part of current state), so default to offering a Summary refresh. Two paths:

   - **Refresh**: draft a new Summary paragraph that reflects layer, the new goal in plain words, the rhythm or recent contacts, any planned contact. Show the user old and new. Confirm before writing.
   - **No refresh**: skip if the new goal doesn't change the at-a-glance picture (e.g. specifics tweaked, value unchanged). Move on.

   This is its own confirmation - the user can accept the goal change and decline the Summary refresh, or vice versa.

8. **Summarise the writes before committing.** Read back what's about to land:

   > "Updating Sam's file: goal moves from maintain to deepen, status goes to amber, Goal section gets the rhythm specifics. Summary refreshes to reflect the new aim. OK?"

   Wait for confirmation. The user can split the writes (e.g. "yes to the goal but leave Summary alone") and the agent honours that.

9. **Write the person file** atomically. Single file operation:
   - Frontmatter: update `goal` (or remove the key if cleared); update `goal_status` (or clear if goal cleared); leave `last_reviewed` unless this change is happening inside a check-in (the check-in updates that field per its own rules).
   - `## Goal` body section: replace with the new specifics, or empty if cleared.
   - `## Summary` body section: replace if step 7 was confirmed; leave alone otherwise.

10. **Confirm plainly** once written:

    > "Updated - Sam is on deepen now."

    No further action by default. If the user wants a planned contact to start moving on the new goal, offer `log_contact` (planned) as a follow-up - don't chain it.

## Rules

- **Confirm before write** (R-P2, G-1). Goal changes are deliberate; never silent.
- **Never invent intent** (G-3). If the user hasn't said it, don't write it. "I think you might want to deepen with Sam" is not a basis for a goal change.
- **Never override user disagreement.** If the agent proposes `deepen` and the user says no, that's the answer. Take the corrected value, don't argue back.
- **Plain language** (G-5, G-6). Never name the colour status when speaking; never speak the machine label for goal in place of the user's own framing.
- **One question at a time.** Don't bundle "what's the new goal AND what are the specifics AND should I update Summary" - each is a confirmable beat.
- **Atomic write** (R-P3). One file operation. Don't write the frontmatter and then ask about Summary - either both land or neither does.
- **Goal specifics are concrete.** Press once for specificity if the user offers a vague framing; accept what they give on second pass. Don't browbeat.
- **Status follows goal.** Removing the goal removes status. Never carry status without a goal.

## Edge cases

- **Goal achieved** (e.g. reconnect after rhythm has been restored over multiple cycles). User says "we're back in rhythm" - propose `maintain` as the natural successor. Confirm. The reconnect goal had a definite end point; maintain holds the gain.
- **Goal abandoned** (user is letting the relationship fade). Clear the goal entirely (no successor); `goal_status` clears too. Capture the change in Summary if the user wants the file to reflect the step-back, otherwise leave Summary alone. The `letting-fade` state lives in *absence of goal*, not as a goal value (D058).
- **Repair goal landing**. The "thing" has been addressed and the user wants to step back from active repair work. Propose `maintain` if the relationship is going to continue, or clear the goal if the user is letting it settle without specific intent. Don't push a particular path.
- **Transition goal landing**. The new rhythm is established; user usually moves to `maintain`. Propose maintain explicitly so the user can confirm. Don't auto-flip.
- **Goal change inside a check-in**. The check-in process calls `change_goal` as a subroutine for any per-person goal shift it surfaces. The check-in's own confirmation flow handles the writes - this process becomes the inline mechanic, not a separate confirmation pass.
- **User wants to change the goal value to the same value but tweak specifics**. Skip step 4's value-confirmation; treat as a specifics-only edit. Step 5 captures the new specifics; step 7 may or may not refresh Summary; step 9 writes only the `## Goal` body.
- **User has just used `add_person` and wants to set/change the goal immediately**. add_person already captures goal at creation; if they're refining within the same conversation, treat as an edit on a fresh file rather than a "change."

## Writes

One person file at `vault/people/<circle>/<slug>.md`. Frontmatter (`goal`, `goal_status`) + `## Goal` body always; `## Summary` body when refresh confirmed in step 7. No other files touched.
