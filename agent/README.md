# agent/

Runtime configuration for the Hyphae agent. Lives in the cloned repo - the agent reads from here on every session. Nothing here is copied into user vaults.

The canonical system prompt is `AGENTS.md` at the repo root, with one-line shims for each major coding agent's auto-discovery filename (CLAUDE.md, GEMINI.md, .cursorrules, .cursor/rules/hyphae.md, .github/copilot-instructions.md). The agent reads AGENTS.md on session start, follows it to find the user's vault, then reads the rest of `agent/` on demand.

## Layout

- `processes/` - named playbooks for recurring requests (one file per process). Loaded as needed.
- `context/` - schema, tool contracts, field semantics. Loaded on demand for whatever's relevant to the current process.
- `context/about-user.template.md` - seed for new vaults. Init copies it once; the agent populates the user's actual file over time.

## Repo vs vault

The agent runtime (this folder) is in the repo. The user's data (people, contacts, check-ins, groups, the home page, etc) is in their vault, at the path stored in `.hyphae-vault` at the repo root.

Updates to processes or schema flow via `git pull` in the cloned repo - no copying step needed.

## Context budget rule

Files in `context/` get loaded on demand, not every turn. Token cost is real, so the bar to add one is high.

- **Always-on (in `AGENTS.md`)** - identity, voice rules, vault discovery, layer palette, accessibility. Loaded every session.
- **On-demand (in `processes/`, `context/`)** - schema, field specs, process specs, user profile. Loaded when relevant to the current task.
- **Reference-only (in `docs/`)** - rationale, decisions, design principles. Loaded only when explicitly asked.

## Completeness asymmetry

Agent-read files must be complete on their own. The agent cannot follow a link to `docs/` at runtime - every fact it needs to act must be inline in `agent/`. Human-read files (`docs/`) can delegate via links because humans follow them. That asymmetry means `agent/` files have a higher completeness bar.
