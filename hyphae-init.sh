#!/usr/bin/env bash
# Initialise a fresh Hyphae vault at the given path.
#
# Creates the data folder structure and seeds the home page, dashboards,
# templates, Obsidian config, user guide, and about-user. The agent
# runtime stays in the repo - it's NOT copied here.
#
# Refuses to write to a non-empty existing directory.
#
# Usage:
#   ./hyphae-init.sh /path/to/new/vault
#   ./hyphae-init.sh ~/Hyphae

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <vault-path>" >&2
  exit 2
fi

VAULT="$1"
# Expand ~ if present
VAULT="${VAULT/#\~/$HOME}"

REPO="$(cd "$(dirname "$0")" && pwd)"

# Pre-flight: refuse if directory exists and is non-empty
if [[ -e "$VAULT" ]]; then
  if [[ ! -d "$VAULT" ]]; then
    echo "ERROR: $VAULT exists and is not a directory" >&2
    exit 1
  fi
  if [[ -n "$(ls -A "$VAULT" 2>/dev/null)" ]]; then
    echo "ERROR: $VAULT exists and is not empty - refusing to clobber" >&2
    exit 1
  fi
fi

mkdir -p "$VAULT"

echo "Initialising Hyphae vault at $VAULT"

# 1. Folder skeleton (data only - no agent runtime)
mkdir -p \
  "$VAULT/people/A. inner-circle (2)" \
  "$VAULT/people/B. close-circle (5)" \
  "$VAULT/people/C. friend-circle (15)" \
  "$VAULT/people/D. familiar-circle (50)" \
  "$VAULT/people/E. casual-circle (150)" \
  "$VAULT/_hyphae/contacts" \
  "$VAULT/_hyphae/checkins" \
  "$VAULT/_hyphae/groups" \
  "$VAULT/_hyphae/reports" \
  "$VAULT/_hyphae/templates" \
  "$VAULT/overview/dashboards" \
  "$VAULT/.obsidian/snippets" \
  "$VAULT/.obsidian/plugins/dataview"

# 2. Templates - shipped from agent/templates/, copied here for the
#    Obsidian Templates plugin UI. Treated as read-only ship config:
#    customising them silently breaks Dataview queries and process
#    expectations. Fork the repo if you need to change them.
cp -r "$REPO/agent/templates/." "$VAULT/_hyphae/templates/"

# 3. Overview pages
cp "$REPO/vault/overview/home.md" "$VAULT/overview/"
cp "$REPO/vault/overview/journal.md" "$VAULT/overview/"
cp -r "$REPO/vault/overview/dashboards/." "$VAULT/overview/dashboards/"

# 4. User guide at the vault root - first stop for a new user
cp "$REPO/docs/user-guide.md" "$VAULT/user-guide.md"

# 4b. Background - the research and design thinking, for users who want
#     to know why Hyphae is built the way it is.
cp "$REPO/vault/background.md" "$VAULT/background.md"

# 4c. Schema dashboard - canonical reference for fields and file types.
cp "$REPO/vault/_hyphae/fields.md" "$VAULT/_hyphae/fields.md"

# 5. about-user.md at the vault root - it's user content (the user
#    can read or edit it, even though the agent populates it over time).
cp "$REPO/agent/context/about-user.template.md" "$VAULT/about-user.md"

# 6. Obsidian config
cp "$REPO/vault/.obsidian/app.json" "$VAULT/.obsidian/" 2>/dev/null || true
cp "$REPO/vault/.obsidian/appearance.json" "$VAULT/.obsidian/"
cp "$REPO/vault/.obsidian/core-plugins.json" "$VAULT/.obsidian/"
cp "$REPO/vault/.obsidian/community-plugins.json" "$VAULT/.obsidian/"
cp "$REPO/vault/.obsidian/templates.json" "$VAULT/.obsidian/"
cp -r "$REPO/vault/.obsidian/snippets/." "$VAULT/.obsidian/snippets/"
cp "$REPO/vault/.obsidian/plugins/dataview/data.json" "$VAULT/.obsidian/plugins/dataview/" 2>/dev/null || true

echo
echo "Done. Vault initialised at $VAULT"
