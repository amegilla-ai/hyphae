<img src="sketchylogo-sml.jpg" alt="Hyphae logo">

# Hyphae

A relationship maintenance app for neurodiverse adults. Named after the filaments that form fungal networks - threads of connection that sustain life.

Why this project exists, who it's for, and the second purpose it serves as a worked example of agent-native software: [`docs/about.md`](docs/about.md).

---

## Install

You'll need:

- Git
- [Obsidian](https://obsidian.md/) (free)
- A coding agent that can read and write files in folders you point it at. Examples: [Claude Code](https://docs.claude.com/en/docs/claude-code), Cursor's agent mode, or any agent built on a model SDK with file tools. Hyphae is the prompt and runtime config; the coding agent is what executes it.
- An LLM for the coding agent to talk to. The coding agent and the LLM are separate things - the agent is the harness with file tools and a conversation loop, the LLM is the model that does the reasoning. Some agents bundle a default model so they feel like one thing, but you still configure model access yourself. **You install this before the first session - the agent does not bring its own model.** Either a cloud provider with an API key (Claude, GPT-5, etc.) or a local runtime ([Ollama](https://ollama.com/), [LM Studio](https://lmstudio.ai/), [llama.cpp](https://github.com/ggerganov/llama.cpp), [vLLM](https://github.com/vllm-project/vllm)) running an open-weights model. Without it the coding agent has nothing to talk to and Hyphae will not work. See [Choosing your LLM](#choosing-your-llm) for help picking between the two.

```bash
# 1. Make sure your LLM is set up. Either:
#    - cloud: API key configured for your coding agent (Claude, GPT-5, etc.)
#    - local: an open-weights model running via Ollama / LM Studio / llama.cpp / vLLM
#    The coding agent needs something to talk to.

# 2. Clone the repo
git clone https://github.com/amegilla-ai/hyphae.git
cd hyphae

# 3. Start your coding agent here. It auto-loads AGENTS.md and walks you
#    through the rest - including asking where you want your vault.
```

On first run, the agent runs an init process: asks you where the vault should live (default `~/Hyphae`), creates the empty folder structure there, and stores the path in `.hyphae-vault` so future sessions know where to operate.

After that, open the vault folder in Obsidian as a vault, install the Dataview community plugin (Settings -> Community plugins -> Browse -> Dataview -> Install -> Enable), and you're ready. The `user-guide.md` at the vault root walks through the rest.

For updates, `git pull` in the cloned repo. The agent runtime updates automatically; your vault data is untouched.

---

## Using it

Once installed, see [`docs/user-guide.md`](docs/user-guide.md) for the home page, prompts you can use with the agent, what a check-in does, layers, goals, and where things live.

---

## Choosing your LLM

Hyphae needs an LLM. The runtime is model-agnostic - the architecture does not care whether the model is hosted in the cloud or running on your hardware. What it does care about is judgment: the agent has to read a vault, walk a priority list, assess where each relationship stands against the user's goal, and stay in a neutral non-coaching voice. That asks more of a model than file reads and structured writes.

Hyphae has been developed and tested against frontier cloud models (Claude, GPT-5). Whether smaller local models can run it well enough to be a daily driver is the next phase of work; an eval and the comparison results will follow.

Local-first is the design intent. With a cloud model, every conversation sends vault excerpts to the provider, and a Hyphae vault contains the names, contact history, and private notes about the people in your life. Check the provider's terms before you commit to that.

---

## Privacy and security

A Hyphae vault contains real names of the people in your life, your contact history with them, and your private notes about each relationship. This is sensitive data - treat it like a personal journal.

The vault is local markdown. It stays on your device unless you sync it yourself. Hyphae has no accounts, no analytics, and no telemetry of its own.

The privacy story for the agent depends on where you run the model - see [Choosing your LLM](#choosing-your-llm).

**On security at rest:** Hyphae stores the vault as plain markdown on your filesystem and does not encrypt it. If you want encryption at rest, use filesystem-level encryption (FileVault, LUKS, or an encrypted volume mounted as the vault path). There's no app password and no remote wipe. See [`docs/requirements.md`](docs/requirements.md) for the full security posture.

---

## Docs

- [`docs/about.md`](docs/about.md) - why this project exists, who it's for, the agent-native pitch
- [`docs/user-guide.md`](docs/user-guide.md) - how to use Hyphae once installed
- [`docs/requirements.md`](docs/requirements.md) - what Hyphae does, expressed as outcomes, processes, vault states, and invariants
- [`docs/architecture.md`](docs/architecture.md) - where things live, the repo/vault ownership boundary, the architectural principles
- [`docs/agent-native-thesis.md`](docs/agent-native-thesis.md) - the agent-native argument in full, for readers interested in the second purpose of this repo

---

## Contributing

Contributions welcome - especially accessibility improvements, translations, and neurodiverse UX feedback.

The one test every feature decision should pass: does this make showing up for relationships easier, or harder?

---

## Licence

AGPL-3.0. See [`LICENSE`](LICENSE).

If you want to use Hyphae in a commercial product or service without the AGPL's source-sharing obligations, contact the project owner to discuss commercial licensing.
