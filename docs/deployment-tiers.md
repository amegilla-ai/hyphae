# Deployment tiers

Hyphae is designed to be user-owned. How a user runs it depends on how much infrastructure they're willing to operate and where they need to reach it from. Three tiers, in increasing order of infrastructure.

Same MCP server code in all three. What changes is where it runs and how Claude reaches it.

## Tier 1: Local (v1 default)

User's laptop runs the MCP server. Vault lives on the laptop's filesystem (synced to phone for Obsidian read-access via Syncthing, iCloud, Obsidian Sync, or similar). Claude on laptop uses the server directly. Claude on phone reaches the laptop via Tailscale or equivalent private tunnel.

- **Pros:** free, private, simple trust model (nothing leaves the user's devices).
- **Cons:** laptop must be reachable when phone wants to write. Sleeping or travelling laptop = no phone Hyphae.
- **Who:** technical user, comfortable running one small server and a tunnel. This is the v1 target.

## Tier 2: User-hosted VM

User rents a small cloud VM ($5/month class). Installs Hyphae's MCP server there. Vault lives on the VM (or on a cloud storage service synced to it, e.g. git-backed or cloud sync). Claude connects from any device at any time.

- **Pros:** laptop-off works. Still user-owned infrastructure.
- **Cons:** ongoing cost. User manages their own server (updates, backups, security patches). More moving parts.
- **Who:** users who want always-on phone access and are comfortable with lightweight sysadmin.

Same Hyphae server code as Tier 1. Deployment changes; operations don't.

## Tier 3: Hosted (not committed; documented for clarity)

Someone (we, a third party) operates a Hyphae service. Users get accounts. Vault storage lives on the service's infrastructure.

- **Pros:** zero setup for users; always on; mobile-friendly.
- **Cons:** privacy story fundamentally changes (the operator has vault access). Requires ops team, billing, support, abuse handling. Revenue model needed.
- **Who:** broader non-technical audience.

**We explicitly don't commit to tier 3 for v1.** It's a different product decision that doesn't have to be made now. Noted here so the tier model is complete.

## What v1 actually ships

Tier 1 on day one, Tier 2 supported by the same server code without changes.

v1 deliverables:
- MCP server exposing the vault operations (tools defined by `agent/context/tools.md`).
- `hyphae init` script to bootstrap a fresh vault.
- `docs/getting-started.md` for installation and first-run.
- Documented paths for Tier 1 and Tier 2 deployment.

v1 is complete when a technical user can install, configure, and use Hyphae from laptop and phone within an hour, without reading the decisions register.

## Why this order

Building Tier 1 first:
- Exercises the MCP protocol against a real user (you).
- Forces the tool layer to earn its place operation by operation, not be speculative.
- Produces the code Tier 2 and Tier 3 also need, without us having committed to either yet.
- Keeps the privacy story as strong as it can be for as long as possible.

If Anthropic ships folder access to Claude mobile later, the MCP server becomes optional - direct skill-based install becomes viable. That's a good future to plan for; it's not a future we rely on.
