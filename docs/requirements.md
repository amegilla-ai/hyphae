# Hyphae - Product Requirements
## v1.0 (agent-native rewrite, 2026-04-13)

> **Status:** Rewritten for agent-native direction. The previous version was framed around screens, forms, and flows for a React PWA; that architecture is archived. This version frames requirements as user outcomes, agent processes, vault states, and guarantees. The design principles (P1-P7) carry forward unchanged because they describe the product's soul, not its mechanics.

---

## Document structure

1. Design principles (P1-P7)
2. User outcomes (what a user should be able to achieve)
3. Agent processes (the named playbooks the agent follows)
4. Vault states (what the vault should faithfully represent)
5. Guarantees (what the system must always be true of)
6. Out of scope for v1

---

## 1. Design principles

These principles govern every feature decision. Where a requirement conflicts with a principle, the principle wins.

**P1: Scaffolding, not coaching.**
The system externalises social maintenance. It does not teach users how to be a good friend. Every feature should reduce friction, not add cognitive load.

**P2: High aspiration, execution support.**
Assume the user wants to maintain and deepen their relationships. The barrier is never motivation - it is follow-through. Never question why a user cares about someone.

**P3: No failure states.**
There is no such thing as a failed relationship in this system. There are only relationships at different points in their natural life. Language reflects this at all times.

**P4: Non-judgmental by design.**
No shame, no guilt, no streaks, no scores that compare users to a standard. Progress is defined by the user's own goals.

**P5: Quality over quantity.**
The system never encourages more contacts or more relationships. It encourages better attention to the relationships that matter most to the user.

**P6: Privacy first.**
All relationship data lives in the user's local vault. The agent's LLM is the privacy boundary - local models keep data on device; cloud models send vault excerpts per turn, clearly disclosed.

**P7: Lowest possible friction.**
Every interaction should be completable in a short conversation. Forms are never required. Free text is always welcome, never mandated.

---

## 2. User outcomes

What a user should be able to do, expressed as end states - not as screens or clicks. Each outcome is achieved through conversation with the agent; the agent reads and writes the vault.

### O-1: Add a person

A user can introduce a new person to the system through natural conversation. The agent captures enough to place them in a Dunbar circle, infers or asks for the goal, and creates the person file. No form.

### O-2: Log a contact

A user can tell the agent about a recent interaction in natural language. The agent creates a contact event file with date, mode, quality (if offered), and the participants. Group events (multiple people) are handled as one event referencing all participants.

### O-3: See who needs attention

A user can ask "who should I reach out to?" and receive a small, capacity-calibrated list of people, with the reason each is surfaced (cadence, goal, check-in pattern). Never an exhaustive list, never pressuring.

### O-4: Reflect in a check-in

A user can request a check-in and work through a short reflection: current capacity, any relationships that feel particularly good or difficult, any specific people they want to spotlight. The agent records the check-in file and may offer a handful of gentle suggestions at the end.

### O-5: Change how a relationship is treated

A user can change a person's goal (maintain → deepen, deepen → reconnect, etc.), move them between circles, or adjust how they want the agent to treat them. Each change is a conversation; the agent confirms before writing.

### O-6: Understand a specific person

A user can ask the agent about anyone in the vault. The agent reads the person's file, their contact history, their check-in appearances, and responds with a grounded summary - never inventing facts.

### O-7: Read and edit directly in Obsidian

A user can open any vault file in Obsidian and read it as human-written markdown. They can edit frontmatter via Obsidian's properties panel, add notes in prose, drop in photos, link to external notes. The agent and the user are both valid writers; the vault is the shared source of truth.

### O-8: Look back over time

A user can ask for a monthly or longer-period review of their relationships. The agent generates a report (stored in `vault/_hyphae/reports/` when persisted, ephemeral when one-off) showing patterns: which relationships are thriving, drifting, ambivalent, or fading.

### O-9: Let a relationship fade

A user can decide a relationship should step back. The agent respects this: no further nudges, no guilt-shaped language. Captured by the absence of an active goal (D065) - letting a relationship fade is the default state when no goal is set, not a specific value to record.

### O-10: Honour someone no longer reachable

A user can record a person as no longer reachable (death, estrangement, distance without contact possibility). The agent never suggests reaching out, but may surface anniversaries or gentle reminders to remember if the user wants that. Not modelled as a goal; future design work will settle the right field (likely a small status indicator on the person file, distinct from both goal and connection).

### O-11: Handle a group

A user can have groups (family, work friends, book club) that span multiple people. A group event counts as contact for everyone in it. The agent understands group-level cadence as well as individual cadence.

### O-12: Know what's private

A user understands, unambiguously, what data stays on device and what is sent where. Model hosting choice is visible and changeable.

---

## 3. Agent processes

Named playbooks the agent follows for recurring requests. Each one lives as a file in `agent/processes/`. This section enumerates the processes v1 requires; the playbook for each is in the process file itself.

### Processes v1 delivers

| Process | Triggered by | Writes |
|---|---|---|
| `add_person` | User introduces someone new | A new person file in the appropriate circle folder |
| `log_contact` | User reports an interaction | A new contact event file |
| `plan_group_event` | User wants to plan a multi-person event | A new planned contact event file with multi-entry `with` |
| `add_group` | User wants to create a group | A new group file in `vault/_hyphae/groups/` |
| `add_to_group` | User adds a person to a group | Update to a group file's `members` |
| `remove_from_group` | User removes a person from a group | Update to a group file's `members` |
| `change_goal` | User changes a relationship goal | Update to a person's frontmatter and `## Goal` body |
| `checkin` | User requests a check-in | A new check-in file plus targeted edits to reviewed people |
| `describe_person` | User asks about someone | Conversation only; no writes |
| `init_vault` | First session - no `.hyphae-vault` pointer | New vault folder structure plus `.hyphae-vault` at repo root |
| `lint` | User asks to check the vault | Conversation only; reports drift, offers to walk through fixes |

### Surfaced via dashboards rather than as named processes

- **Who needs attention** - the home page's "Needs attention" Dataview block surfaces people with `goal_status: needs-attention`, sorted by `last_reviewed`. No conversational process needed; the user reads the dashboard.

### Deferred post-v1 (see `docs/roadmap.md`)

- `move_person`, `rename_person` - structural edits with wikilink updates.
- `monthly_report` - depends on `describe_person` being exercised enough to know what a good summary looks like.
- `suggest_action` - agent proposes concrete next actions when the user has a goal but doesn't know what to do.

### Process requirements that apply to all

- **R-P1:** Every process is defined as a markdown file in `agent/processes/`, with inputs, steps, and what it writes documented.
- **R-P2:** Any process that writes to the vault confirms in conversation before writing, unless explicitly marked as trusted (e.g. agent-initiated logging on direct user instruction).
- **R-P3:** Writes are atomic file writes - no partial state. If a process fails midway, the vault is in a consistent state.
- **R-P4:** No process writes to vault-owned paths (`about-user.md`, `state/`, `archive/`).
- **R-P5:** By default, processes write to the dummy vault during development. Promotion to writing against the real vault is a deliberate per-process decision after validation.

---

## 4. Vault states

What the vault must faithfully represent. Frontmatter is intrinsic; body holds views.

### Person files

- **R-V1:** Each person file carries at minimum: `id`, `created`, and `cssclasses`. Optional semantic fields: `goal`, `goal_status`, `last_reviewed`.
- **R-V2:** `id` is immutable. Renaming a file or changing a display name does not change the ID.
- **R-V3:** `layer` is derived from folder path - never stored in frontmatter.
- **R-V4:** The body contains the current template shape: Summary (Dataview), optional Goal section (present iff `goal` is set in frontmatter), Notes, Groups (Dataview backlink).

### Contact events

- **R-V5:** Each event carries: `id`, `date`, `with` (one or more wikilinks), `mode`, `planned` (bool). Optional: `quality`, `group`.
- **R-V6:** A contact event references at least one person via `with`.
- **R-V7:** Wikilinks use slug form, resolving to actual files in `people/`.

### Check-ins

- **R-V8:** Each check-in carries: `id`, `date`, `capacity`. Optional: `overall`, `spotlight`.
- **R-V9:** Body contains free-text reflection.

### Groups

- **R-V10:** Each group carries: `id`, `name`, `members` (list of wikilinks). Group file owns membership; person files do not list groups.

### Reports

- **R-V11:** Each report carries: `id`, `date`, `kind`, `period`. Body is the report itself.

### Derived facts (never stored)

- `last_contact(person)`, `days_since_contact(person)`, `next_planned(person)`, `is_overdue(person)`, `contact_count(person, since)` - all computed from contact event files.
- `layer(person)` - computed from folder path.
- `groups(person)` - computed by scanning group files' `members`.

---

## 5. Guarantees

Invariants the system must always hold.

### Safety

- **G-1:** The agent never writes to a person's file without explicit user confirmation in conversation (unless trusted operations, R-P2).
- **G-2:** The agent never deletes a file without explicit user confirmation. Archive-by-move, not delete, is preferred.
- **G-3:** The agent never invents facts about a person. Everything it says about someone comes from the vault or the current conversation.
- **G-4:** Errors are surfaced honestly. The agent never silently fails a write and pretends it succeeded.

### Tone

- **G-5:** No accusatory language. Never "overdue," "behind," "failed," "missed."
- **G-6:** No wellness-coded language. Never "might be time," "could use some attention," "worth a thought," "holding space," "gentle reminder." State facts directly: "Sam: last contact 6 weeks ago" not "it might be time to reach out." Empty states are plain, not cheerful or clinical.
- **G-7:** Capacity is respected. Low capacity never produces pressure.
- **G-8:** No shaming. The closest the agent gets to surfacing a pattern is stating it factually and offering to discuss - only for sustained patterns, never single events.

### Privacy

- **G-9:** Relationship data never leaves the device except through the user's chosen LLM. No analytics, no telemetry, no background network activity from Hyphae itself.
- **G-10:** Model hosting is user-visible and user-controllable. The user always knows whether vault excerpts are being sent to a hosted provider per turn.
- **G-11:** Optional cloud model use is opt-in per session or per install, never silently enabled.

### Data integrity

- **G-12:** IDs are unique across their namespace (`h_` for person, `c_` for contact, etc.).
- **G-13:** Wikilinks resolve. A wikilink to a non-existent file is a validation error.
- **G-14:** A person's folder matches their layer (D049 invariant).
- **G-15:** Schema changes that break existing vault files require a migration in `dev/migrations/` (D041).

### Accessibility

- **G-16:** The system's rendered surfaces (chat, vault in Obsidian) do not depend on colour alone to convey meaning. Text labels accompany any colour coding.
- **G-17:** Copy written by the agent (in chat, in reports, in prose sections of files) follows the neutral-voice rules (G-5, G-6).

---

## 6. Out of scope for v1

- **Mobile-first experience.** v1 assumes a desktop workflow (Obsidian + chat client).
- **Multi-user vaults.** One user per vault.
- **Native mobile apps.** Mobile access only via Obsidian's mobile app and whatever chat client works on mobile.
- **Sync across devices.** User handles sync themselves (Obsidian Sync, iCloud, Syncthing, whatever they prefer).
- **Public sharing of data.** No publish-to-web, no shared reports outside the user's own devices.
- **Native integrations.** No Google Calendar, no iOS Contacts sync in v1. (Considered for post-v1.)
- **Notifications.** No push alerts. The agent surfaces when asked. Cadence is user-paced, not system-imposed.
- **Multi-vault support.** One vault per user, managed by the user.
- **Automated contact import.** v1 assumes the user and agent jointly build the relationship graph through use. No bulk-import of contacts.
- **Finished eval harness.** We have an approach sketch (scenarios, expected behaviours) but no implementation. First-class eval is post-v1 work.

---

## Cross-references

- Architecture: `docs/architecture.md`
- Thesis / design argument: `docs/agent-native-thesis.md`
- Decisions register: `docs/decisions.md`
- Research foundations: `docs/research-summary.md`, `docs/theoretical-foundations.md`
- Schema: `agent/context/data-model.md` and `agent/context/fields/`
- Processes (when written): `agent/processes/`
- Dev model: `dev/README.md`
