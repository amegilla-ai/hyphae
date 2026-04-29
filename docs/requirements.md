# Hyphae - Product Requirements

What Hyphae does, expressed as user outcomes, agent processes, vault states, and invariants. Where a requirement conflicts with a design principle, the principle wins.

## Document structure

1. Design principles (P1-P7)
2. User outcomes (what a user should be able to achieve)
3. Agent processes (the named playbooks the agent follows)
4. Vault states (what the vault should faithfully represent)
5. Invariants (what must always be true)
6. What Hyphae doesn't do

---

## 1. Design principles

**P1: Scaffolding, not coaching.**
The system externalises social maintenance. It does not teach users how to be a good friend. Every feature should reduce friction, not add cognitive load.

**P2: High aspiration, execution support.**
Assume the user wants to maintain and deepen their relationships. The barrier is never motivation - it is follow-through. Never question why a user cares about someone.

**P3: No failure states.**
There is no concept of a failed relationship in this system - relationships change, and the system reflects that without judgement.

**P4: Non-judgmental by design.**
The system carries no shame, guilt, streaks, or scores that compare users to a standard. Progress is defined by the user's own goals.

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

A user can introduce a new person through conversation. The agent captures enough to place them in a Dunbar circle, asks for a goal if relevant, and writes the person file. No form.

### O-2: Log a contact

A user can tell the agent about an interaction. The agent creates a contact event file with date, mode, quality (if offered), and the participants. Group events (multiple people) are recorded as one event referencing all participants.

### O-3: See who needs attention

A user can ask "who should I reach out to?" and receive a small list of people, sized to their stated capacity, each with the reason it was raised (cadence, goal, prior check-in). Never an exhaustive list.

### O-4: Reflect in a check-in

A user can request a check-in and work through a short reflection: current capacity, any people they want to talk through, any specific people they want to spotlight. The agent records the check-in file and may suggest a small set of next actions at the end.

### O-5: Change how a relationship is treated

A user can change a person's goal (maintain to deepen, deepen to reconnect, etc.), move them between circles, or adjust how they want the agent to treat them. Each change is a conversation; the agent confirms before writing.

### O-6: Understand a specific person

A user can ask the agent about anyone in the vault. The agent reads the person's file, contact history, and check-in appearances, and responds with a summary grounded in those files.

### O-7: Read and edit directly in Obsidian

A user can open any vault file in Obsidian and read it as markdown. They can add notes in prose, drop in photos, and link to external notes. The agent and the user are both valid writers; the vault is the shared source of truth.

### O-8: Look back over time

A user can ask for a monthly or longer-period review of their relationships. The agent generates a report - rendered in chat by default, written to `_hyphae/reports/` in the vault if the user wants to keep it - showing who has been seen often, who hasn't been seen, where goals have advanced or stalled, and ambivalent cases the user has flagged.

### O-9: Stop tracking a relationship

A user can decide a relationship should no longer carry an active goal. The agent stops raising the person for goal-related attention; with no active goal recorded, they sit at their layer's default cadence and only come up if the user asks about them directly.

### O-10: Handle a group

A user can have groups (family, work friends, book club) that span multiple people. A group event counts as contact for everyone in it. The agent works with both group-level and individual-level cadence.

### O-11: Know what's private

A user understands what data stays on device and what is sent where. Model hosting choice is visible and changeable.

---

## 3. Agent processes

Named playbooks the agent follows for recurring requests. Each one lives as a file in `agent/processes/`. The playbook for each is in the process file itself.

### Processes v1 delivers

| Process | Triggered by | Writes |
|---|---|---|
| `add_person` | User introduces someone new | A new person file in the appropriate circle folder |
| `log_contact` | User reports an interaction | A new contact event file |
| `plan_group_event` | User wants to plan a multi-person event | A new planned contact event file with multi-entry `with` |
| `add_group` | User wants to create a group | A new group file in `_hyphae/groups/` |
| `add_to_group` | User adds a person to a group | Update to a group file's `members` |
| `remove_from_group` | User removes a person from a group | Update to a group file's `members` |
| `change_goal` | User changes a relationship goal | Update to a person's frontmatter and `## Goal` body |
| `checkin` | User requests a check-in | A new check-in file plus targeted edits to reviewed people |
| `describe_person` | User asks about someone | Conversation only; no writes |
| `init_vault` | First session - no `.hyphae-vault` pointer | New vault folder structure plus `.hyphae-vault` at repo root |
| `lint` | User asks to check the vault | Conversation only; reports inconsistencies, offers to walk through fixes |

### Shown via dashboards rather than as named processes

- **Who needs attention** - the home page's "Needs attention" Dataview block lists people with `goal_status: needs-attention`, sorted by `last_reviewed`. No conversational process needed; the user reads the dashboard.

### Roadmap

- `suggest_action` - agent proposes concrete next actions when the user has a goal but is stuck on what to do.

### Process requirements that apply to all

- **R-P1:** Every process is defined as a markdown file in `agent/processes/`, with inputs, steps, and what it writes documented.
- **R-P2:** Any process that writes to the vault confirms in conversation before writing, unless explicitly marked as trusted (e.g. agent-initiated logging on direct user instruction).
- **R-P3:** Writes are atomic file writes - no partial state. If a process fails midway, the vault is in a consistent state.
- **R-P4:** No process writes inside the cloned repo. The agent runtime (system prompt, processes, schema, field specs) lives in the repo and is overwritten by `git pull`; any edit the agent makes there would be lost on the next update. All writes go to the user's vault. The agent's memory about the user lives at `_hyphae/about-user.md` in the vault and is written as part of normal operation.

---

## 4. Vault states

What the vault must faithfully represent. Frontmatter is intrinsic; body holds views.

### Person files

- **R-V1:** Each person file carries at minimum: `id`, `created`, and `cssclasses`. Optional semantic fields: `goal`, `goal_status`, `last_reviewed`.
- **R-V2:** `id` is immutable. Renaming a file or changing a display name does not change the ID.
- **R-V3:** `layer` is derived from folder path - never stored in frontmatter.
- **R-V4:** The body carries the current template structure: Summary (Dataview blocks for Planned and Connections), `## Goal` (always present, empty body when no goal is set), `## Notes`, `## Groups` (Dataview backlink).

### Contact events

- **R-V5:** Each event carries: `id`, `date`, `with` (one or more wikilinks), `mode`, `planned` (bool). Optional: `quality`, `action`, `group`.
- **R-V6:** A contact event references at least one person via `with`.
- **R-V7:** Wikilinks use slug form, resolving to actual files in `people/`.

### Check-ins

- **R-V8:** Each check-in carries: `id`, `date`, `capacity`, `summary`. Optional: `overall`, `spotlight`.
- **R-V9:** Body contains the per-person review notes and end-of-session reflection. The `summary` frontmatter field carries a 1-3 sentence synopsis used by the journal dashboard.

### Groups

- **R-V10:** Each group carries: `id`, `name`, `members` (list of wikilinks). Group files own membership; person files do not list groups.

### Reports

- **R-V11:** Each report carries: `id`, `date`, `kind`, `period`. Body is the report itself.

### Derived facts (never stored)

- `last_contact(person)`, `days_since_contact(person)`, `next_planned(person)`, `is_overdue(person)`, `contact_count(person, since)` - all computed from contact event files.
- `layer(person)` - computed from folder path.
- `groups(person)` - computed by scanning group files' `members`.

---

## 5. Invariants

What the system must always hold true.

### Safety

- **G-1:** The agent never writes to a person's file without explicit user confirmation in conversation (unless trusted operations, R-P2).
- **G-2:** The agent never deletes a file without explicit user confirmation. Archive-by-move, not delete, is preferred.
- **G-3:** The agent never invents facts about a person. Everything it says comes from the vault or the current conversation.
- **G-4:** Errors are reported honestly. The agent never silently fails a write and pretends it succeeded.

### Tone

- **G-5:** No accusatory language. Never "overdue", "behind", "failed", "missed".
- **G-6:** No wellness-coded language. Never "might be time", "could use some attention", "worth a thought", "holding space", "gentle reminder". State facts directly: "Sam: last contact 6 weeks ago" not "it might be time to reach out". Empty states are plain, not cheerful or clinical.
- **G-7:** Capacity is respected, so low capacity never produces pressure.
- **G-8:** No shaming. The closest the agent gets to raising a pattern is stating it factually and offering to discuss - only for sustained patterns, never single events.

### Privacy

- **G-9:** Relationship data never leaves the device except through the user's chosen LLM. Hyphae itself does no analytics, no telemetry, and no background network activity.
- **G-10:** Model hosting is user-visible and user-controllable. The user always knows whether vault excerpts are being sent to a hosted provider per turn.

### Security

The data in a Hyphae vault is sensitive: real names of people in the user's life, contact history, the user's notes and goals about them, and patterns the user might not want anyone else to read. Treat it as you would a personal journal. The points below are what Hyphae does and does not do at the security layer.

- **S-1:** The vault is plain markdown on the filesystem. Hyphae does not encrypt it at rest; whoever has filesystem access can read it. Users wanting encryption at rest should use a tool that provides it (filesystem-level encryption like FileVault or LUKS, or an encrypted volume mounted as the vault path).
- **S-2:** Hyphae does not transmit data over the network. Network traffic to a cloud LLM is the LLM client's responsibility (typically HTTPS to the provider). Local LLM tiers transmit nothing.
- **S-3:** Hyphae does not back up the vault. Users handle backup themselves through whatever tool they prefer (git, cloud sync, Time Machine).
- **S-4:** Hyphae has no app-level access control - no password, no biometric lock. Access to the vault is access to the device. If the device is shared, treat it as if anyone using it can read the vault.
- **S-5:** Cross-device sync, if the user sets it up, depends on the user's chosen sync tool. Hyphae has no opinion on which to use; the user is trusting that tool to protect the data in transit and at rest on the other device.

### Data integrity

- **G-12:** IDs are unique across their namespace (`h_` for person, `c_` for contact, etc.).
- **G-13:** Wikilinks resolve. A wikilink to a non-existent file is a validation error.
- **G-14:** A person's folder matches their layer.
- **G-15:** Schema changes that break existing vault files require a migration applied to the user's vault before the new schema is in effect.

### Accessibility

- **G-16:** What the system renders (chat output, vault in Obsidian) does not depend on colour alone to convey meaning. Text labels accompany any colour coding.
- **G-17:** Copy written by the agent (in chat, in reports, in prose sections of files) follows the neutral-voice rules (G-5, G-6).

---

## 6. What Hyphae doesn't do

- **Mobile-first experience.** The design target is a desktop session (Obsidian + a coding agent that can read and write the vault). On mobile, Obsidian works as a reader and editor against the same vault, so the user can browse their people, read past contacts, edit notes, and add planned events directly. What mobile doesn't have today is the agent itself - mobile chat clients can't write files, so add-person, log-contact, and check-in flows happen at the desktop. Once mobile clients gain file-tool access (or a Hyphae-specific mobile app lands), this gap closes.
- **Multi-user vaults.** One user per vault.
- **Sync across devices.** The user handles sync themselves through whatever tool they prefer (Obsidian Sync, iCloud, Syncthing).
- **Public sharing of data.** Hyphae has no publish-to-web feature and no mechanism for sharing reports outside the user's own devices.
- **Native integrations.** Hyphae does not connect to Google Calendar, iOS Contacts, or other external services.
- **Notifications.** No push alerts - the agent shows people and prompts when the user asks, at a cadence the user sets.
- **Automated contact import.** No bulk-import of contacts. The user and agent build the relationship graph through use.

---

## Cross-references

- Architecture: `docs/architecture.md`
- Thesis / design argument: `docs/agent-native-thesis.md`
- Research foundations: `docs/research-summary.md`, `docs/theoretical-foundations.md`
- Schema: `agent/context/data-model.md` and `agent/context/fields/`
- Processes: `agent/processes/`
