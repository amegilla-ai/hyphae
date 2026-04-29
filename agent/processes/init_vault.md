---
process: init_vault
style: structured
triggered_by: First session - the agent looks for `.hyphae-vault` in the repo root and finds it missing. Or the user explicitly asks to set up a new vault.
writes: A new vault folder structure at the user's chosen path. A `.hyphae-vault` file at the repo root storing the path.
---

# init_vault

Create the user's vault at a path they pick, and record where it is so future sessions know.

## What this produces

- A new folder at `<path>` containing the empty Hyphae vault structure (people folders by layer, `_hyphae/` subfolders for contacts/checkins/groups/templates, `overview/` with home.md and dashboards, `.obsidian/` config).
- A file `.hyphae-vault` at the repo root containing the absolute path to the vault.

## When this runs

- **First session** - the agent reads `.hyphae-vault` at the start of every session (per AGENTS.md). If the file is absent, this process runs before doing anything else.
- **User asks for a new vault** - they say "set up a new vault" or similar. Confirm they want to replace the existing pointer (if any) before running.

## Steps

1. **Ask where the vault should live.** One short prompt:

   > "Where would you like your Hyphae vault to live? Default: `~/Hyphae`."

   Accept what the user gives. Expand `~` to the home directory. If they say "the default" or just press enter, use `~/Hyphae`.

2. **Check the path.** Three cases:

   - Path doesn't exist - good, continue.
   - Path exists but is empty - good, continue.
   - Path exists and has files in it - stop. Tell the user the path is non-empty and ask if they want to pick a different path or, if they say yes explicitly, refuse and end the process. Don't clobber existing data.

3. **Run the init script.** Shell out to `hyphae-init.sh` with the path:

   ```
   ./hyphae-init.sh <path>
   ```

   The script creates the deterministic folder structure (folder names matter - the schema reads layer from the folder name, so they must be exact). Don't try to create the structure file by file from this spec; use the script.

   If the script fails (non-zero exit), surface the error verbatim and stop.

4. **Record the vault path.** Write the absolute path of the vault into `.hyphae-vault` at the repo root. This is a one-line file, no frontmatter:

   ```
   /Users/sam/Hyphae
   ```

   This is what every future session reads to find the vault.

5. **Confirm.** One sentence:

   > "Vault set up at <path>. Open it as a folder in Obsidian, install the Dataview plugin, then come back here and we can add some people."

   Don't do more than this. The user will switch to Obsidian, set up Dataview, and come back. The next session reads `.hyphae-vault` and operates from there.

## Rules

- **Don't substitute the script.** The folder structure has to match the schema exactly (e.g. `A. inner-circle (2)` - the spaces, the period, the parens are all load-bearing). The script handles this; you should not improvise the structure.
- **Confirm path with user before writing.** Get explicit confirmation of the path before running the script. The default is fine but the user might want elsewhere.
- **Never overwrite existing data.** If the path is non-empty, refuse. The user can pick a different path or move existing data manually before re-running.
- **Don't ask for personal data.** This process is purely structural setup. Don't ask the user's name, preferences, etc. - those get captured organically as the user uses Hyphae.

## Edge cases

- **User picks a path the OS won't allow** (permissions, invalid characters). Surface the error from the script and ask for a different path.
- **`.hyphae-vault` already exists when this process runs.** Means the user is asking to set up a *new* vault while one is already configured. Confirm explicitly: "You already have a vault at <existing-path>. Do you want to replace that pointer with a new one? (Your existing data won't be deleted.)" - if yes, continue. If no, stop.
- **Script not found.** Means the user has a corrupted or partial repo. Surface the error and tell them to re-clone.

## Writes

- A folder at `<path>` containing the vault structure (created by `hyphae-init.sh`).
- `.hyphae-vault` at the repo root containing the absolute vault path.
