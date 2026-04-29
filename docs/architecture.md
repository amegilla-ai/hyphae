# Hyphae - architecture

Hyphae is being built agent-native. No backend server, no database, no API, no forms. The agent is the runtime.

## Three surfaces

1. **Chat** - the only input surface. The user talks to Claude. There are no buttons or screens.
2. **Vault** - all state. Markdown files in an Obsidian vault under `~/Personal/Hyphae/`. People, contacts, check-ins, groups, reports.
3. **Reports** - generated artifacts. Ephemeral by default (rendered in chat); persisted to `vault/_hyphae/reports/` when longitudinal value warrants it. Not a separate surface - just a vault convention.

The user reads the vault directly in Obsidian. The agent reads and writes the vault through tools. Same files, two readers.

## Where things live

```
~/Projects/hyphae/             repo - design and source of truth
  docs/                        narrative: rationale, decisions, design principles
  agent/                       runtime config (canonical copy)
    system-prompt.md
    processes/                 named playbooks
    context/                   terse operational reference
    state/                     empty in repo

~/Personal/Hyphae/             vault - the live runtime
  people/                      one .md per person, lettered circle subfolders - the browsed surface
  overview/                    rendered views across the vault - nothing stored here, only queried
    journal.md                 Dataview dashboard: check-in summaries newest first
    dashboards/                other Dataview surfaces (planned-connections, past-connections, etc.)
  _hyphae/                     backing data + agent runtime; user rarely navigates here
    contacts/                  one .md per contact event
    checkins/                  one .md per check-in (full narrative body + summary frontmatter)
    groups/                    group definitions
    reports/                   persisted reports
    templates/                 Obsidian templates
    fields.md                  schema dashboard
    agent/                     deployed runtime config
      system-prompt.md
      processes/
      context/                 includes the populated about-user.md
      state/                   populated at runtime
      archive/                 superseded session notes
```

## Develop here, test in the vault

The repo is the design. The vault is the runtime. We edit `hyphae/agent/` here, push changes, then sync to the vault and exercise them against people files there.

By default the agent reads from `~/Personal/Hyphae/` (real data) but writes to `~/Projects/hyphae/vault/` (dummy data). Promotion to writing against the real vault is a deliberate per-process decision after the process has been exercised against dummy data and you trust it.

## Ownership: repo vs vault

Each path under `agent/` has exactly one canonical owner. The sync script (`dev/scripts/sync-agent.sh`) propagates repo-owned paths to the vault and never touches vault-owned paths.

| Path | Owner | Synced repo -> vault | Notes |
|---|---|---|---|
| `agent/system-prompt.md` | Repo | Yes | Agent identity, hard rules |
| `agent/processes/` | Repo | Yes | All named playbooks |
| `agent/context/data-model.md` | Repo | Yes | Schema |
| `agent/context/tools.md` | Repo | Yes | Tool contracts |
| `agent/context/about-user.template.md` | Repo | Yes (template only) | Template, not the live file |
| `agent/context/about-user.md` | Vault | Never | The user's real persistent profile |
| `agent/state/` | Vault | Never | Runtime state, agent-written |
| `agent/archive/` | Vault | Never | Historical session notes |
| `agent/README.md` | Repo | No | Developer doc, not needed at runtime |
| `agent/tools/` | Repo | Yes | Executable tools the agent calls |

Schema changes that break existing vault data require a migration in `dev/migrations/`. Process and tool changes are additive and ride along with the next sync.

## Design principle 1 - one fact, one place, in the format that fits its primary consumer

Three content categories:

- **Agent-shaped content** (schema, tool contracts, processes) lives in `agent/` in terse, structured form. Its primary consumer is the agent; humans reading it get a dense reference doc, which is fine.
- **Human-shaped content** (thesis, rationale, decisions register, dev journal) lives in `docs/` in prose. The agent never reads it by default (token cost).
- **Bridging content** (READMEs, this doc) is prose but links to agent-shaped specifics; it never restates them.

The rule: **one fact, one place**. Don't express the same fact twice for different audiences.

Asymmetry worth knowing: humans reading agent files cope fine and follow links for rationale when they want it. Agents reading human files waste tokens, so the agent never reads `docs/` by default. That asymmetry is why the pointer discipline is asymmetric - prose docs link to schema; the schema rarely links out.

## What the agent has, instead of an API

- **Tools** instead of endpoints. `read_person`, `write_person`, `log_contact`, `list_overdue` - operations on the vault. Defined in `agent/context/tools.md`.
- **Processes** instead of routes. `add_person`, `daily_checkin`, `who_needs_attention` - named playbooks the agent follows. One file each in `agent/processes/`.
- **Rules** instead of validation middleware. The system prompt and per-process rules govern behaviour. Hard rules (never modify a person file without confirming) sit in `agent/system-prompt.md`.

## What the agent has, instead of a database

The vault. Frontmatter is the schema. Markdown body is the human-readable detail. Wikilinks are the relations. Obsidian is the renderer.

## Determinism boundary

Cheap, exact facts are computed by tools (days since contact, who is overdue, layer membership). Judgment is owned by the LLM (what to suggest, how to frame a nudge, when to push back). The boundary lives in `agent/context/tools.md` - if it is in there as a tool, it is deterministic; everything else is judgment.

## Agent memory

Operational memory about *running the app* lives in `vault/_hyphae/agent/`:
- `context/about-user.md` - persistent facts about the user
- `state/system-state.md` - current state, in-flight processes, recent system decisions

Domain memory about *people and relationships* lives in the domain files themselves (person pages, contacts, check-ins). The agent does not keep a parallel store about people - if a fact about Sam matters, it goes in Sam's file.

## What this replaces

Everything in `archive/legacy-app/` (React PWA + FastAPI + thin React shell) and `archive/react-pwa/` (the original PWA). Both are preserved on disk but not tracked on the remote.
