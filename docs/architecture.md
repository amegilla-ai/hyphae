# Hyphae - architecture

Hyphae is built agent-native. No backend server, no database, no API, no forms. The agent is the runtime.

## Three places the user encounters the system

1. **Chat** - the only input channel. The user talks to a coding agent (Claude Code, Cursor, etc.). There are no buttons or screens.
2. **Vault** - all state. Markdown files in an Obsidian vault at a path the user picks (default `~/Hyphae`). People, contacts, check-ins, groups, reports.
3. **Reports** - artifacts the agent generates on request. By default a report is rendered in chat and not saved; when the user wants to keep one (a quarterly review, a yearly summary), it gets written to `_hyphae/reports/`. Not a separate place - just a vault convention.

The user reads the vault directly in Obsidian. The agent reads and writes the vault using its host's file operations. Same files, two readers.

## Where things live

Two physical locations after install:

- **Repo** (the cloned `hyphae` directory) - canonical source for the agent runtime. Contains `agent/` (system prompt, processes, context including schema and field specs) and the seed files used to set up new vaults. The user does not edit anything here directly.
- **Vault** (a folder at the user's chosen path, recorded in `.hyphae-vault` at the repo root) - the live runtime. This is where people, contacts, check-ins, and groups live, alongside the agent's runtime memory.

```
<cloned hyphae repo>           runtime config (canonical copy)
  AGENTS.md                    the system prompt, auto-loaded by the host agent
  agent/
    processes/                 named playbooks the agent follows
    context/                   schema and field specs
    templates/                 Obsidian templates
  vault/                       seed files used by hyphae-init.sh

<user's vault path>            data + agent runtime memory
  people/                      one .md per person, lettered circle subfolders
  overview/                    rendered views (journal, dashboards) - nothing stored here, only queried
    journal.md                 Dataview dashboard: check-in summaries newest first
    dashboards/                planned-connections, past-connections, etc.
  _hyphae/                     backing data + agent runtime memory; user rarely navigates here
    contacts/                  one .md per contact event
    checkins/                  one .md per check-in
    groups/                    group definitions
    reports/                   persisted reports
    templates/                 Obsidian templates (seeded copy)
    fields.md                  schema dashboard
    about-user.md              persistent profile of the user, written by the agent over time
```

## Ownership: repo versus vault

Two locations, two owners.

The **repo** (the cloned `hyphae` directory) owns the agent runtime - `AGENTS.md`, the processes, the schema, the field specs, the templates. The agent reads these directly from the repo at runtime. Updating Hyphae is `git pull` on the repo. The user does not edit anything here; their changes would be overwritten on the next pull.

The **vault** (the folder at the user's chosen path) owns everything about the user - their people, contacts, check-ins, groups, the agent's notes about them in `about-user.md`. Nothing in the vault is ever overwritten by `git pull` because the vault lives at a separate path the user picked.

A few files in the vault are seeded from the repo on first install (Obsidian config, dashboards, the home page, templates, the schema dashboard) and then become user-owned. `hyphae-init.sh` does the seeding. Subsequent updates to those seed files in the repo do not propagate automatically - if the user wants the latest version of a dashboard or template, they re-seed it manually.

Schema changes that break existing vault files require a migration applied to the user's vault before the new schema takes effect. Additive changes (new optional fields, new processes) take effect on the next `git pull` without needing one.

## Architectural principles

These govern how the system is built. Product principles (the user-facing behaviour rules) live in `docs/requirements.md` as P1-P7.

### 1. One fact, one place, in the format that fits its primary consumer

Three content categories:

- **Operational content** (schema, processes, field specs) lives in `agent/` in terse, structured form. Its primary consumer is the agent; humans reading it get a dense reference doc, which is fine.
- **Narrative content** (thesis, rationale, design narrative) lives in `docs/` in prose. The agent never reads it by default (token cost).
- **Bridging content** (READMEs, this doc) is prose but links to operational specifics; it never restates them.

The rule: **one fact, one place**. The same fact never appears in two different places to serve two different audiences.

The asymmetry: humans reading agent files cope fine and follow links for rationale when they want it. Agents reading human files waste tokens, so the agent never reads `docs/` by default. That's why the pointer discipline is one-way - prose docs link to schema; the schema rarely links out.

### 2. Fields must earn their place

Every piece of state the system carries has to defend itself. Can it be derived from existing data? Can it be inferred from observed behaviour? Can the agent just ask when it needs to know? If yes to any, the field doesn't get added. The principle generalises beyond fields to any stored state, "just in case" scaffolding, or speculative structure.

### 3. Prefer conversation over form

When tempted to add a field, ask: could the agent just ask the user when it needs to know? The answer is often yes. Fields are for *intrinsic* facts the system needs every turn. One-off information belongs in conversation and ends up as prose, not structure.

### 4. Frontmatter for intrinsic facts; body for views

Never store a derivable fact. The person page shows the user's planned and past contacts, the groups they're in, the user's notes about them - but these are views over the actual source data (contact files, group files, the user's own writing), not stored values.

## What the agent has, instead of an API

- **Processes** instead of routes. Named playbooks the agent follows for recurring requests - `add_person`, `log_contact`, `checkin`, etc. One file each in `agent/processes/`. The processes describe what to read, what to write, and what to confirm with the user.
- **Schema** instead of validation middleware. The data-model and field specs in `agent/context/` define what files exist, what frontmatter keys mean, and which values are valid. Processes reference the schema rather than open-coding the rules.
- **Confirmation** instead of structured input. Every write is confirmed with the user before it happens. The schema constrains *what* can be written; the user's confirmation governs *whether* it gets written.

## What the agent has, instead of a database

The vault. Frontmatter is the schema. Markdown body is the human-readable detail. Wikilinks are the relations. Obsidian is the renderer.

## Logic and the determinism question

There is no separate deterministic tool layer. All work - judgment ("should I suggest reaching out to Sam this week") and computation ("how many days since I last saw Sam") - is done by the LLM by reading the contact files, with the user confirming any write that depends on the result.

What holds this together is the schema (what's true about the data), the process spec (what to read, what to write, what to confirm), and the confirm-before-write rule. Whether those three are enough to replace a deterministic layer at scale is one of the open questions in `docs/agent-native-thesis.md`.

## Always-on context vs on-demand load

Hyphae has no formal load-policy mechanism. The boundary between what's always in the agent's context and what gets read when needed is set entirely by `AGENTS.md`:

- **Always-on** = whatever the user's coding agent auto-loads at session start. For Claude Code that's `CLAUDE.md` (which points at `AGENTS.md`), plus any files the host treats as default-loaded. `AGENTS.md` is genuinely always-on.
- **On-demand** = everything else. The `## Where to find things` pointer list in `AGENTS.md` tells the agent where each kind of content lives (schema, field specs, processes, vault paths) and instructs it to read at runtime rather than recall.

Approximate sizes today: `AGENTS.md` is ~1,400 tokens; the user's `about-user.md` once populated runs ~500-1,500 tokens; the data-model and field specs together are ~9,000 tokens but only loaded when a process needs them.

So the load policy is prompt-driven, not config-driven. To shift something from on-demand to always-on, you write the file's content into `AGENTS.md`. To shift the other way, you remove it from `AGENTS.md` and add a pointer to where it lives.

## Agent memory

Memory about the user (their preferences, defaults, persistent context) lives in `_hyphae/about-user.md`. The agent reads it on demand and updates it as it learns about the user.

Memory about people and relationships lives in the domain files themselves - person pages, contacts, check-ins. The agent does not keep a parallel store; if a fact about Sam matters, it goes in Sam's file.
