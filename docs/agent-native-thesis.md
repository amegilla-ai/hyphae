# What an agent-native app actually looks like

A working argument, refined as we build Hyphae. The product is real - a relationship maintenance tool for neurodiverse adults - but the architecture is also a test case for a question we don't think anyone has answered well yet: if you reimagine the user experience around an agent, what does software become?

This is the position we've worked out so far. It will be wrong in places. We'll update it as we discover that.

---

## Where the architecture comes from

Most conventional app infrastructure exists to support a specific user experience model: the user clicks buttons, the app shows screens, structured data flows in through forms, state renders as visual layouts in interfaces the app builds and ships.

Each layer of the stack solves a problem that experience model creates:

- **Forms** convert the user's intent into structured data the backend can persist.
- **Screens** give the user a viewer for state.
- **Routing** gives the user destinations to navigate between.
- **The build step** compiles and ships the UI.
- **The database** stores data the user can't read directly, with an interface to translate.
- **Validation middleware** sits at the boundary where unstructured user input meets structured backend storage.

When the experience is reimagined - the user talks to an agent in natural language, the agent interprets and acts, state lives as human-readable files in tools the user already has open - those layers stop being load-bearing. They were shaped by the experience. Change the experience and the architecture changes with it.

The agent is the enabling technology. The reduction in conventional infrastructure is a consequence of the experience change, not of adding AI to an app.

---

## What goes away

**The backend server.** No client makes requests to a service. The agent talks to a model and reads/writes files. There's no request-response boundary across a network.

**The database.** Markdown files in a folder are sufficient state for apps about words, plans, relationships, decisions - data meant to be read by humans. The agent reads and writes them; humans read and edit them; the filesystem provides versioning, backup, sync, and search. A database optimises for things (queries, joins, transactions, schema enforcement at scale) that aren't load-bearing here.

**The API layer.** No REST endpoints. The agent has **tools** - small, named operations on state with stable contracts. Conceptually similar to API endpoints, but they're not HTTP, not versioned for external consumers, and don't deal with auth, pagination, or rate limiting. They're operations on files.

**Forms.** Input doesn't need to be structured at the boundary. The user says "Sam and I had coffee yesterday and it was lovely" and the agent decides what file to write, which fields to fill, which person to link to. Structuring happens inside the agent.

**Routing.** No screens, no URLs, no router. There's nowhere to navigate. The "routes" that survive are the agent's named processes - playbooks for recurring requests like add-person, log-contact, daily-checkin. Shaped for conversation, not for navigation.

**The rendering layer.** We don't ship a UI. We don't design pixels. The chat is rendered by whatever client the user is using (Claude.ai, terminal, an Obsidian plugin). The vault is rendered by Obsidian. We design the substance - what the agent says, how data is shaped, which views to expose - not the surface.

**Most of the auth surface.** Single-user, local-first apps don't need accounts. The vault is a folder. The agent runs against it. Permission is filesystem permission.

**The build step.** No JavaScript to bundle, no CSS to compile, no SPA to ship. There's an LLM, some markdown files, and a few scripts.

**Validation middleware.** With no forms, there's no boundary where unstructured user input meets structured storage. The validation that remains is different in kind: making sure the *vault* is well-formed, not making sure the *user input* is well-formed.

---

## What remains, reshaped

**Schema.** The data model is load-bearing. The agent has to know what file types exist, what frontmatter keys mean, what values are valid. It lives as a terse markdown spec the agent reads (in our case, `agent/context/data-model.md`), not as ORM models or migration files. Frontmatter keys are the schema.

**Logic.** Some logic stays deterministic - "days since I last contacted Sam" is exact arithmetic and shouldn't be left to the LLM. It's a small surface, exposed as tools. Judgment-shaped logic - "should I suggest reaching out to Sam this week, and if so how" - moves to the LLM, governed by processes and rules.

**State.** Persisted as files the user can read and edit directly. The vault is the storage, the schema, and the substrate the user operates on.

**Interaction surfaces.** Two surfaces, neither of which we render:
- **Chat** - the user talks to the agent in their chosen client.
- **The vault** - the user reads and edits state in Obsidian.

A third surface, **reports**, is a vault convention - generated artifacts written to `vault/reports/` when longitudinal value warrants persistence; ephemeral chat output otherwise.

**Configuration.** The agent's behaviour is configured by markdown files: a system prompt for identity and rules, a folder of named processes, a folder of tool contracts, a context budget for what gets loaded every turn. This is the application, in a real sense - it's just text.

**Validation.** Required, but it's the vault and the agent config that need validating, not user input. Schema drift between data-model.md and the templates is the new bug class. Wikilinks that don't resolve. Frontmatter values outside the enum. CI exists, but it tests the agent's world.

**Accessibility.** Reframed. We can't enforce contrast ratios because we don't render colours. We can't enforce tap target sizes because we don't render buttons. What we can do is write copy that doesn't depend on visual structure to be understood, structure markdown so screen readers parse it sensibly, and never use colour as the sole carrier of meaning. Accessibility moves from "implement contrast ratios" to "design content that works regardless of what renders it."

---

## What's hard

**The model is not free.** The agent runs on an LLM with a cost in tokens, latency, privacy if hosted, and hardware if local. The privacy story changes completely depending on where the model lives. We've adopted three tiers (local accessible, local high-capability, cloud) and a design rule: author the runtime config for the floor model and let higher-capability models benefit, not depend.

**Determinism boundary discipline.** It's tempting to let the LLM do everything because it can. It shouldn't. Cheap exact computations should be tools, not prompts - both for reliability and cost. The line between "tool job" and "judgment job" needs to be drawn and maintained.

**Context budget.** Every always-on file in the agent's context is paid for on every turn. The bar to add to `context/` has to be high. The discipline is not adding files - keeping schema, tools, and user profile lean and pushing everything else to on-demand load.

**Schema migrations.** Files in the user's vault have shape. If the schema changes in a non-additive way, existing files need migrating. We use explicit migrations (`dev/migrations/NNN-YYYY-MM-DD-<slug>.{md,py}`) that are idempotent and required only for breaking changes.

**Sync between dev and runtime.** The repo holds the canonical agent config; the vault holds the deployed copy plus the user's data. They have to stay aligned without leaking personal data into the repo or wiping vault-owned files. We use an allowlist sync script that copies repo-owned paths and refuses to touch vault-owned ones.

**Testing.** Conventional CI doesn't apply to a project with no compiled code. The validators we run instead - schema check, vault lint, link check - test the artifacts the agent operates on, not the agent itself. Testing the agent's behaviour is closer to LLM eval: scenarios, expected behaviours, manual inspection. We haven't built this yet.

**The agent itself can drift.** A model update or a config change can shift behaviour without any code change. Versioning the runtime config (it's all in git) gives some defence; eval scenarios will give more. This is a new failure mode without a clean solution yet.

---

## Where this works

This pattern works for apps where the conventional UX was a forced fit - where the user's actual activity is conversational and reflective, but the available paradigm forced it into forms and screens. Personal knowledge work, journaling, planning, relationship tracking, decision logs, financial reflection, creative drafting - cases where the user is talking with the system about their own state.

In those cases, reimagining the experience removes the legacy constraints. The architecture becomes smaller because the things it used to need (forms, screens, databases, build pipelines) were experience-shaped scaffolding for a UX paradigm we no longer have to use.

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

The architectural inversion (agent as primary input, judgment-shaped logic in the model) still applies. The reduction of scaffolding does not.

Hyphae sits in the first category.

---

## What changes about the dev process

**The unit of work.** Not a function or a component. A process (a markdown playbook the agent follows), a tool (a small executable the agent calls), or a schema rule. A feature is usually a process plus the schema fields and tools it needs.

**The medium.** Most of what you write is markdown, not code. Tools tend to be small Python or shell scripts. The largest artifacts in the repo are architectural docs, the decisions register, and the agent config. Code is the minority.

**The review surface.** A code review of a process is a review of prose. Does it tell the agent to do the right thing in the right order? Does it match the schema? Will it handle the obvious edge cases? The skills overlap with technical writing as much as with coding.

**The test loop.** You sync the change to the vault, talk to the agent, see what happens. There's no compile-test-deploy cycle. The cycle is: edit, validate, sync, test in conversation. Faster than conventional dev when it works, harder to debug when it doesn't, because the gap between "the markdown says X" and "the agent did Y" is a black box.

**Documentation isn't separate from code.** The agent's runtime config is documentation - it just happens to also be the program. The line between "describing what the system does" and "telling the system what to do" collapses. This is unfamiliar but not bad; it forces a clarity conventional code often hides.

---

## What we don't know yet

**Whether the floor model is enough.** GPT-OSS-20B is the realistic local floor for most users. We've designed the runtime config to be terse and structured so a 20B-class model has the best shot at running it well. We have not exercised it against that model. Until we do, "local works" is a hope.

**Whether eval is tractable.** Testing an agent's behaviour against scenarios is conceptually clear, operationally vague. We don't have a harness, a scoring approach, or a regression rule. We expect to figure this out in production.

**Whether non-technical users can run this.** The architecture is simple; the setup (model, Ollama or API key, Obsidian, vault) is several steps and several technical decisions. An agent-native app may need a packaged distribution to reach a non-technical audience. We're not solving that yet.

**Whether processes scale past a handful.** Today we have a handful of processes in mind. If a real product needs fifty, the cognitive load on the agent and the maintenance load on us both rise. We don't know where the breakpoint is.

**How the hybrid pattern actually looks.** We've sketched the bounded thesis (agent-native works for some apps, agent-as-orchestration for others). We haven't built an example of the hybrid. The interface between an agent-native experience and conventional infrastructure is architectural territory we're not exploring here.

---

## How to read this repo as a worked example

- `docs/architecture.md` - the spatial picture (three surfaces, ownership table, design principle 1)
- `docs/decisions.md` - decisions register, with rationale per choice
- `agent/` - the agent's runtime config (system prompt, processes, context, tools)
- `vault/` - the data the agent operates on, with templates and dummy data
- `dev/` - dev infrastructure (scripts, migrations, eventually evals)

This thesis is the summary. The decisions register is the receipts.

---

*Last updated 2026-04-13.*
