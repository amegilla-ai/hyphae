# Data model

Authoritative schema for the Hyphae vault. Terse, operational. Rationale lives in `docs/`.

## Principle

Frontmatter holds **intrinsic** facts (who, what circle, what goal). The body holds **views** (Dataview queries, backlinks, computed summaries). Never store a derivable fact - compute it. See `docs/decisions.md` D035.

## Two-tier schema

- **Semantic fields** (the ones with meaning the user needs to understand) live as one file each in `agent/context/fields/`. Frontmatter for validation; body for meaning. The agent loads them on demand; the user reads them in Obsidian; the validator parses their frontmatter.
- **Structural fields** (ids, names, dates, tags, wikilinks, bools with no semantic weight) live as rows in this document's tables below. The validator reads them here.

Together these cover every frontmatter key across all file types.

## Semantic fields

Each file carries its own frontmatter spec. Dashboard: `vault/_hyphae/fields.md`.

| File | Covers | Applies to |
|---|---|---|
| `agent/context/fields/layer.md` | `layer` | person |
| `agent/context/fields/goal.md` | `goal`, `goal_status` | person |
| `agent/context/fields/quality.md` | `quality` | contact |
| `agent/context/fields/capacity.md` | `capacity` | checkin |

`connection_score` and `connection_intent` were dropped from the data model (the file `agent/context/fields/connection.md` has been removed); their role is covered by layer + goal + goal_status.

## File types

| Type | Path | Filename |
|---|---|---|
| Person | `vault/people/<circle>/` | `<slug>.md` (e.g. `hilary-mantel.md`) |
| Contact event | `vault/_hyphae/contacts/` | `<YYYY-MM-DD>-<slug>.md` |
| Check-in | `vault/_hyphae/checkins/` | `<YYYY-MM-DD>.md` |
| Group | `vault/_hyphae/groups/` | `<slug>.md` |
| Report | `vault/_hyphae/reports/` | `<YYYY-MM>-<kind>.md` |

Slug is lowercase ASCII, hyphen-separated.

## Circles

| Layer | Folder | Dunbar (cumulative) | Function | Cadence floor |
|---|---|---|---|---|
| 1 | `A. inner-circle (2)` | 2 | partner, possibly a best friend | usually daily |
| 2 | `B. close-circle (5)` | 5 | people you'd turn to in a crisis | at least weekly |
| 3 | `C. friend-circle (15)` | 15 | people you do ordinary social life with | at least every 4-5 weeks |
| 4 | `D. familiar-circle (50)` | 50 | shared-context or party friends | at least every 6 months |
| 5 | `E. casual-circle (150)` | 150 | wider network (family, ex-colleagues, long-standing low-contact friends) | at least yearly |

Sizes are cumulative (layer 2 contains the 5 closest people including the 2 innermost), but in the vault a person lives in one folder - their tightest layer.

Cadence is the **typical contact frequency** Dunbar observed at each layer. Hyphae uses these as floors - rough thresholds the agent watches against - but they aren't validated minimums. Each user's actual contact pattern per person is their own "social fingerprint" and may be much more frequent. Goal can shift behaviour. Full model and agent guidance: `agent/context/fields/layer.md`.

## Structural fields

Fields not documented per-file. See the semantic field files above for `layer`, `goal`, `goal_status`, `quality`, `capacity`.

### Person

| Key | Type | Required | Constraint |
|---|---|---|---|
| `id` | string | yes | `h_` + 8 hex chars, immutable |
| `created` | date | yes | YYYY-MM-DD |
| `last_reviewed` | date | no | YYYY-MM-DD, written only by the checkin process (D064) |
| `cssclasses` | list[string] | yes | includes `hyphae-collapse-props` so person pages collapse frontmatter by default |

Semantic fields on person (see `agent/context/fields/`, all optional): `goal`, `goal_status`. The person body always carries a `## Goal` section between Summary and Notes; it is empty when no goal is set, and carries per-person specifics when one is (D060). `goal_status` is written/maintained by the check-in process.

Display name is the filename (slug). No separate `name` field - the filename is the display handle. See D050.

Do **not** store:
- `last_contact`, `next_planned` - derive from `contacts/`
- `contact_mode`, `energy_cost` - agent infers from history / quality trends (D047)
- `groups` - group files own membership via `members` (D048)
- `tags` - dropped (D048)
- `layer` - derived from folder path (D049): `A. inner-circle` → 1, `B. close-circle` → 2, etc. Moving a file between folders is the one and only way to change layer.
- `name` - filename is the display handle (D050)

### Contact event

One file per event (D055). A single event with multiple participants is one file with a multi-entry `with` list, not N per-person files. Expected volume is high at full use (hundreds per year); the folder is navigated via queries, not scrolling.

| Key | Type | Required | Constraint |
|---|---|---|---|
| `id` | string | yes | `c_` + 8 hex chars |
| `date` | date | yes | YYYY-MM-DD |
| `with` | list[wikilink] | yes | one or more `[[person-slug]]` |
| `mode` | string | yes | free text; common values `in-person`, `message`, `call`, `voice-note`, `async`, `channel` (for ongoing shared-space contact like a Discord server or WhatsApp group). User may write anything (e.g. `letters`, `crossword-by-post`). Three uses: dashboard queries (Planned and Connections tables on person pages, past-connections dashboard), material-change detection in log_contact (a mode shift can trigger Summary refresh), and narrative grounding when the agent speaks ("the last call" reads different from "the last text"). The agent prefers common values when creating events so the first two uses stay reliable. |
| `planned` | bool | no | true = future intention; false/absent = past event |
| `action` | string | no | Free text, meaningful only when `planned: true`. What the user needs to do to make the contact happen (e.g. "text her first", "book the restaurant"). Folded into the narrative body and removed from frontmatter when the contact becomes past (update branch of log_contact). |
| `group` | wikilink | no | `[[group-slug]]` if a group event |

Body: optional free-text notes. For past events, this is the 1-3 sentence quality narrative per `agent/context/fields/quality.md`.

### Check-in

| Key | Type | Required | Constraint |
|---|---|---|---|
| `id` | string | yes | `k_` + 8 hex chars |
| `date` | date | yes | YYYY-MM-DD |
| `overall` | int | no | 1-5 |
| `spotlight` | list[wikilink] | no | people surfaced this check-in |
| `summary` | string | yes | 1-3 sentence synopsis surfaced by the journal dashboard. Generated in checkin step 7a. Always double-quoted (see Frontmatter writing conventions). |

Body: free-text reflection.

### Group

| Key | Type | Required | Constraint |
|---|---|---|---|
| `id` | string | yes | `g_` + 8 hex chars |
| `name` | string | yes | - |
| `members` | list[wikilink] | yes | `[[person-slug]]` per member |

Body: optional context about the group.

### Report

| Key | Type | Required | Constraint |
|---|---|---|---|
| `id` | string | yes | `r_` + 8 hex chars |
| `date` | date | yes | YYYY-MM-DD generated |
| `kind` | string | yes | `monthly` \| `quarterly` \| `annual` \| `ad-hoc` |
| `period` | string | yes | e.g. `2026-04` |

Body: the report itself.

## Frontmatter writing conventions

YAML rules apply across every file the agent writes. The ones that bite:

- **Quote any string value containing `:`, `#`, `[`, `]`, `{`, `}`, `,`, `&`, `*`, `!`, `|`, `>`, `'`, `"`, `%`, `@`, `` ` ``, or starting with `- `.** Unquoted, YAML interprets these as structure rather than text. The check-in `summary` field is the most common bite point (often contains colons in prose). Default to double quotes when in doubt: `summary: "..."`.
- **Multi-line strings** that need to span lines should use the block scalar form (`summary: |` or `summary: >`) rather than embedding newlines in a quoted string.
- **Wikilinks in lists** (`[[person-slug]]`) must be quoted: `with: ["[[sam-alvarez]]"]`. Bare `[[...]]` confuses YAML's flow-list syntax.

The agent generates frontmatter, so this is an agent-discipline rule. The validator should flag YAML parse failures before they hit Obsidian.

## Derived facts

Compute on read; never store.

| Fact | Source |
|---|---|
| `last_contact(person)` | max `date` in `contacts/` where person in `with` and `planned` is not true |
| `days_since_contact(person)` | today - `last_contact(person)` |
| `next_planned(person)` | min `date` in `contacts/` where person in `with` and `planned` is true |
| `is_overdue(person)` | `days_since_contact(person)` > cadence threshold for layer |
| `contact_count(person, since)` | count `contacts/` where person in `with` and date >= since and not planned |

## Invariants

- Every person belongs to exactly one circle (folder = layer). See `agent/context/fields/layer.md`.
- `id` is immutable. Renaming a person changes filename + display name, never the ID.
- A contact event references at least one person via `with`.
- Wikilinks use the person's slug, not display name.

## Multi-field file convention

A field file whose frontmatter has `fields: [a, b, ...]` (plural) documents more than one field. For each listed field, the body contains an inline yaml code block keyed by `field: <name>` carrying its constraints. The validator parses both the top frontmatter (for the primary list) and each inline block (for per-field constraints).

`goal.md` is the current example (covers `goal` and `goal_status`).

## Cross-references

- Why these choices: `docs/architecture.md`, `docs/decisions.md`
- Tool contracts that read/write these files: `agent/context/tools.md`
