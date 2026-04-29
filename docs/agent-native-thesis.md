# What an agent-native app actually looks like

A working argument, refined while building [Hyphae](https://github.com/amegilla-ai/hyphae). The product is real - a relationship maintenance tool for neurodiverse adults - but the architecture is also a test case for a question we don't think anyone has answered well yet: if you reimagine the user experience around an agent, what does software become?

---

## Where the architecture comes from

Most conventional app infrastructure exists to support a specific user experience model: the user clicks buttons, the app shows screens, structured data flows in through forms, state renders as visual layouts in interfaces the app builds and ships.

Each layer of the stack solves a problem that experience model creates:

- **Forms** convert the user's intent into structured data the backend can persist.
- **Screens** give the user a viewer for state.
- **Routing** gives the user destinations to navigate between.
- **The build step** compiles and ships the UI.
- **The database** stores data the user can't read directly, with an interface to translate.
- **Validation middleware** sits between user input and backend storage to make sure what the user typed is well-formed before it gets saved.

When the experience is reimagined - the user talks to an agent in natural language, the agent interprets and acts, state lives as human-readable files in tools the user already has open - those layers stop being necessary. They existed to support the experience. Change the experience and the architecture changes with it.

The agent is the enabling technology. The reduction in conventional infrastructure is a consequence of the experience change, not of adding AI to an app.

---

## What goes away

**The backend server.** No client makes requests to a service - the agent talks to a model and reads or writes files directly, with no request-response boundary across a network.

**The database.** Markdown files in a folder are sufficient state for apps about words, plans, relationships, decisions - data meant to be read by humans. The agent reads and writes them; humans read and edit them; the filesystem provides versioning, backup, sync, and search. A database optimises for things (queries, joins, transactions, schema enforcement at scale) that aren't necessary for this use case.

**The API layer.** No REST endpoints. The agent reads and writes files using whatever file operations its host provides (Claude Code, Cursor, etc.). What would have been API endpoints in a conventional app are Hyphae's named **processes** - markdown playbooks the agent follows when the user asks for something. The processes describe what to read, what to write, and what to confirm; the file operations themselves are the host agent's standard tools.

**Forms.** Input doesn't need to be structured at the boundary. The user says "Sam and I had coffee yesterday and it was lovely" and the agent decides what file to write, which fields to fill, which person to link to. Structuring happens inside the agent.

**Routing.** There's nowhere to navigate so the "routes" that survive are the agent's named processes - playbooks for recurring requests like add-person, log-contact, check-in. Designed for conversation rather than navigation.

**The rendering layer.** The app ships no UI and chat is rendered by whatever client the user runs (Claude.ai, terminal, an Obsidian plugin). The vault is rendered by Obsidian. What the project designs is the substance - what the agent says, how data is structured, which views to expose - not the visual layer.

**Most of the auth layer.** Single-user, local-first apps don't need accounts so permission is filesystem permission.

**The build step.** Hyphae is an LLM, a folder of markdown files, and a few scripts - nothing to compile, nothing to bundle.

**Validation middleware.** With no forms, there's no boundary where unstructured user input meets structured storage. The validation that remains is different in kind: making sure the *vault* is well-formed, not making sure the *user input* is well-formed.

---

## What remains

**Schema.** The data model defines what the agent works against - what file types exist, what each frontmatter key means, and what values are valid. It's a terse markdown spec the agent reads (`agent/context/data-model.md`), not ORM models or migration files.

**Logic.** All of it lives in the LLM, governed by processes and rules. Judgment work - "should I suggest reaching out to Sam this week, and if so how" - is what the LLM is for. Exact computation - "how many days since I last saw Sam" - is also done by the LLM, by reading the contact files, with the user confirming any write that depends on the result. The discipline that holds the system together is the process spec, the schema, and the confirm-before-write rule.

**State.** Persisted as files the user can read and edit directly. The vault is where state is stored, where the schema lives (in frontmatter), and where the user works - one set of files doing all three.

**The user interface.** Two places, neither of which the project renders:

- **Chat** - the user talks to the agent in their chosen client.
- **The vault** - the user reads and edits state in Obsidian.

A third, **reports**, is a vault convention - the agent generates them on request and writes the keepers to `vault/_hyphae/reports/`. One-offs stay in chat.

**Configuration.** The agent's behaviour is configured by markdown files: a system prompt for identity and rules, a folder of named processes, a folder of context (schema, field specs, tool contracts), a context budget for what gets loaded every turn. This is the application, in a real sense - it's just text.

**Validation.** Required, but it's the vault and the agent config that need validating, not user input. The new bug classes are mismatches between the data-model and the templates, wikilinks that don't resolve, and frontmatter values outside the enum. Automated checks run on push to catch these - but they verify the data and config, not application code, because there isn't any.

**Accessibility.** The project doesn't render anything itself, so it can't set contrast ratios, font sizes, or tap target sizes - those are decisions for whichever client renders the chat and however Obsidian renders the vault. What the project can do is write copy that reads sensibly without visual layout, use clear markdown structure so screen readers parse the headings and lists correctly, and never rely on colour alone to convey meaning.

---

## New considerations

**The model is not free.** The agent runs on an LLM with a cost in tokens, latency, privacy if hosted, and hardware if local. The privacy story changes completely depending on where the model lives. Hyphae's instructions are written terse and structured to give a small local model the best chance of running them well, but whether that succeeds is one of the open questions further down.

**Trusting the LLM for exact work.** Conventional architectures push exact computation - dates, counts, validation - into deterministic code, because LLMs hallucinate. Hyphae uses schema discipline and user confirmation instead. The risk: every time the LLM does a calculation - days since contact, count of recent meetings, whether someone's overdue - it might be subtly wrong. The mitigations are to confirm before any write, treat the schema as the source of truth, and have processes ask the user to check any number that's about to influence a decision. Whether this scales is an open question.

**Context budget.** Every file the agent loads at session start is paid for on every turn that follows. In Hyphae today, that's `AGENTS.md` (~1,400 tokens) plus the user's profile once populated (~500-1,500 tokens) - around 2-3K tokens always-on. The schema and field specs (~9K tokens together) load only when a process needs them. There's no formal load-policy mechanism; what's always-on versus on-demand is set by what `AGENTS.md` contains directly versus what it points at. The discipline is to keep `AGENTS.md` itself tight and use the pointer list to lazy-load everything else.

**Schema migrations.** Files in the user's vault have a structure. If the schema changes in a non-additive way, existing files need migrating. Migrations are explicit, idempotent, and required only for breaking changes - additive changes (new optional fields, new processes) take effect on the next config update without needing one.

**Repo-owned versus user-owned paths.** The cloned repo holds the canonical agent config; the user's vault holds their data and the agent's runtime memory. The two must not collide - the agent must not write to repo-owned paths, because they get overwritten on the next config update; and the config update must not touch user-owned paths, because they're the user's. Holding that boundary explicit is part of the architecture.

**Testing.** Conventional automated tests don't apply to a project with no compiled code. What runs instead are validators - schema check, vault lint, link check - which test the data and config the agent operates on, not the agent itself. Testing the agent's behaviour is a separate problem: scenarios run against the live agent, with expected outcomes and manual inspection. Hyphae hasn't built this yet.

**Behaviour can change without code changing.** A model update or a config change can shift behaviour without any code change. Versioning the runtime config (it's all in git) gives some defence; eval scenarios will give more. This is a new failure mode without a clean solution yet.

**The user needs an agent that can edit files, plus a working git install.** Hyphae is operated by a coding agent (Claude Code, Cursor, etc.) that the user runs on their machine. Mobile chat clients and most consumer chat interfaces can't write files, so they can't run the writing parts of Hyphae. Install is `git clone`; updates are `git pull`. The user doesn't need to know git beyond those two commands, but they do need git on their machine and the comfort to run them. This narrows the audience to people who already work in this kind of environment or are willing to set one up. An agent-native app aimed at a broader audience needs either a different host (a packaged Obsidian plugin, a desktop app that bundles everything) or it needs to wait for mainstream chat clients to gain file-tool access and a non-git distribution channel.

---

## Where this works

This pattern works for apps where the conventional UX was a forced fit - where the user's actual activity is conversational and reflective, but the available paradigm forced it into forms and screens. Personal knowledge work, journaling, planning, relationship tracking, decision logs, financial reflection, creative drafting - cases where the user is talking with the system about their own state.

In those cases, reimagining the experience removes the legacy constraints. The architecture becomes smaller because the things it used to need (forms, screens, databases, build pipelines) existed to support a UX paradigm no longer in use.

---

## Where it doesn't

The pattern doesn't work for apps where conventional infrastructure exists for reasons that aren't UX-driven and don't disappear when the UX changes:

- **High write throughput** - logging, telemetry, event streams. Volume forbids conversation; the user isn't even the source.
- **Hard real-time / low latency** - trading, gaming, streaming. Per-turn model latency is incompatible with the work.
- **Multi-user with shared state** - locking, conflict resolution, transactions, ACLs. Files in a folder don't give you concurrency control.
- **Production data-heavy systems** - analytics, BI, observability. The vault metaphor doesn't scale; you need columnar stores, indices, query planners.
- **Regulated domains** - healthcare, finance, legal. Auditability, deterministic behaviour, certified workflows, data residency.
- **Public-facing services at scale** - rate limiting, abuse protection, sharding, replication.

In these cases the legacy constraints are problem-driven, not experience-driven. The agent might still be valuable - as an orchestration layer over conventional infrastructure rather than a replacement for it - but the database stays, the API stays, the build pipeline stays, the rendering stays.

The architectural inversion (agent as primary input, judgment logic in the model) still applies. The reduction of scaffolding does not.

Hyphae sits in the first category.

---

## What changes about the dev process

**The unit of work.** Instead of writing a function or a component, you write a process - a markdown playbook the agent follows when the user asks for something - or a schema rule. A typical feature is one process plus whatever schema fields it needs to read or write.

**The medium.** Almost everything in the repo is markdown rather than code. The largest artifacts are architectural docs and the agent's runtime config (system prompt, processes, schema). Code is the minority and shows up only as small shell scripts for setup and dev plumbing - there is no application logic to write.

**What gets reviewed.** Reviewing a process is reviewing prose. The questions are whether it tells the agent to do the right thing in the right order, whether the steps match the current schema, and whether it handles the obvious edge cases. The skills involved overlap with technical writing as much as with software engineering.

**The test loop.** Conventional dev loops compile code, run tests, then deploy. Hyphae's loop is shorter: edit a process or schema file, run the validators, sync the change to the vault, then talk to the agent and watch what it does. The loop is faster than conventional dev when it works, but harder to debug when it doesn't, because the gap between "the markdown says X" and "the agent did Y" is opaque.

**Documentation isn't separate from code.** The agent's runtime config is documentation that also happens to be the program - the same files describe what the system does and tell the system what to do. There is no second set of docs that can fall out of sync with the implementation, because the implementation is the docs.

---

## What we don't know yet

**Whether a private local setup is viable for typical hardware.** Cloud models work today but every conversation sends vault excerpts to the provider. The privacy story only stays clean if the user runs a model locally. That works on workstation-class hardware (60GB+ for a 70B-class model), but the realistic consumer setup is a smaller open-weights model on around 16GB of GPU memory. Whether a model that size can do Hyphae's judgment work - the check-in priority logic, person summaries, the conversational push-back - is untested. Until it has been, "private local Hyphae" is a hope.

**Whether you can test the agent reliably.** With conventional code, you write tests that say "given input X, the function should return Y" and run them after every change. With an agent, the output isn't a return value - it's a conversation, and it can vary turn to turn even on the same input. So how do you know if a change you made to a process improved things, broke them, or made no difference? Today the answer is "talk to the agent and see what it does, manually". That doesn't scale to many processes or to confident changes. There are emerging patterns in the LLM space (scenarios with expected outcomes, scoring rubrics, comparison runs against earlier versions), but no agreed standard. Hyphae hasn't built any of this yet.

**Whether processes scale past around a dozen.** Hyphae has eleven processes today and the pattern is holding - per-process files, one concern each, named subroutines for shared mechanics. If a real product needs fifty, the cognitive load on the agent (which has to know which process to invoke from a given user turn) and the maintenance load on the project both rise. Hyphae hasn't hit the breakpoint yet.

---

## How to read this repo as a worked example

- `docs/architecture.md` - where things live, ownership between repo and vault, the four architectural principles
- `docs/requirements.md` - what Hyphae does, expressed as outcomes, processes, vault states, and invariants
- `agent/` - the agent's runtime config (system prompt, processes, context including schema and field specs)
- `vault/` - the seed files used by `hyphae-init.sh` to set up a new user vault

This thesis is the summary; the repo is the working out.
