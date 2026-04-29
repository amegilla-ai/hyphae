---
process: lint
style: structured
triggered_by: User asks ("check my vault", "is anything broken in the data", "lint the vault", "validate the schema").
writes: Nothing. This is a read-only process - it reports issues; the user decides what to do about them.
---

# lint

Walk the vault, check every file against the schema in `agent/context/data-model.md` and the field files in `agent/context/fields/`, report any issues. Read-only - the agent does not auto-fix anything. If there are issues to fix, the user picks the next move.

## What lint checks

For every file under `people/`, `_hyphae/contacts/`, `_hyphae/checkins/`, `_hyphae/groups/`, `_hyphae/reports/`:

- **Frontmatter parses cleanly.** Common bite: an unquoted string with a colon, hash, or other YAML-significant character. The check-in `summary` field is the most common offender. See data-model.md "Frontmatter writing conventions."
- **Required keys are present.** Per file type: person needs `id`, `created`, `cssclasses`. Contact needs `id`, `date`, `with`, `mode`. Check-in needs `id`, `date`, `summary`. Group needs `id`, `name`, `members`. Report needs `id`, `date`, `kind`, `period`.
- **`id` matches the documented form.** `<prefix>_` plus 8 random hex chars. Prefixes: `h_` person, `c_` contact, `k_` checkin, `g_` group, `r_` report.
- **Enum values are valid.** `goal` in maintain/deepen/reconnect/repair/transition. `goal_status` in on-track/needs-attention. `quality` in positive/neutral/negative. `kind` (report) in monthly/quarterly/annual/ad-hoc.
- **Forbidden person keys are absent.** Person frontmatter must not contain `name`, `layer`, `groups`, `tags`, `last_contact`, `next_planned`, `contact_mode`, `energy_cost` - all of these were dropped or are derived from elsewhere.
- **Wikilinks resolve.** `with` entries in contacts and `members` in groups must resolve to a person file. `group` on a contact must resolve to a group file.
- **Filenames match the documented form.** Contact: `YYYY-MM-DD-<slug>.md`. Check-in: `YYYY-MM-DD.md`. Report: `YYYY-MM-<kind>.md`. Person: `<slug>.md` where slug is lowercase ASCII with hyphens.
- **No unrendered template placeholders.** A `created:` value of `'{ date:YYYY-MM-DD }'` (Obsidian template syntax that didn't expand) is broken data.

## How to actually do the check

The agent reads `data-model.md` and the field files for the current schema, then walks the vault folder reading each file's frontmatter and structure. No script execution; the model parses YAML directly. For each issue, capture: file path, what's wrong, what the schema says it should be.

## Steps

1. **Read the schema.** `agent/context/data-model.md` for structural fields and required keys. The field files in `agent/context/fields/` for enum values: `goal.md`, `quality.md`, `capacity.md`, `layer.md`. This grounds the check in the current spec rather than memory.

2. **Walk the file types** in this order: person, contact, check-in, group, report. For each file, parse the frontmatter and check it against the rules above. Collect issues in a list.

3. **Report.** If clean, say so plainly: "No issues found in N people, M contacts, etc."

   If there are issues, group them by file type and severity. Format:

   > "Found 3 issues:
   >
   > **People (1)**
   > - `people/D. familiar-circle (50)/sam.md` - missing `id` field (required, format `h_` + 8 hex chars)
   >
   > **Contacts (2)**
   > - `_hyphae/contacts/2026-04-26-sam.md` - `with` references `[[sammy]]` which doesn't resolve to any person file
   > - `_hyphae/contacts/2026-04-27-bruno.md` - `quality` value `'great'` is not in the allowed set (positive | neutral | negative)"

   Speak issues plainly. No "schema violation detected" language; describe what's wrong as if to a person.

4. **Offer next moves.** Don't auto-fix. Two options stated plainly:

   - "Want me to walk through these and fix each one with you?" - per-issue confirmation, the user picks fix/skip/explain for each.
   - "Want me to leave it for you to look at?" - end the process. The report stands as a reference.

   If the user picks the walk-through, run a tight loop: name the issue, propose a fix, write on confirmation, move to the next. The user can stop any time.

## Rules

- **Read the spec, don't recall it.** Schema rules change; reading them at run-time means lint stays current. Avoid memorising the rules in a way that goes stale.
- **Per-issue confirmation if fixing.** R-P2 applies. No batch auto-fix.
- **No auto-fix on `id`.** A malformed `id` looks like a candidate for regeneration, but ids are immutable in principle. Surface it as an issue, let the user decide; if they say replace, replace it (with a fresh `<prefix>_` + 8 hex chars).
- **No auto-delete.** A missing wikilink target might mean the link is wrong, or the target was never created, or the file got moved. The user knows which; the agent doesn't guess.
- **Plain language about what's wrong.** "Missing `id`" not "id field validation failed."

## Edge cases

- **Schema has no examples to compare against.** A vault with zero contacts can't have contact issues. Skip type sections with zero files; report counts at the end ("checked 12 people, 0 contacts, 0 checkins").
- **A file isn't markdown or has no frontmatter at all.** Treat as "not a Hyphae file" and skip silently. Don't error.
- **YAML parse failure.** Report the file path and the parser's error message verbatim. Often the issue is one quote away from being valid; showing the raw error helps the user see it.
- **User wants to fix some but not all.** Honour partial. Walk through the issues; user picks per-issue. Some get fixed, some don't. Report at the end what got fixed and what's still outstanding.
- **Issue points at a deeper schema problem.** If the agent finds something that looks like a spec mismatch (e.g. all 23 person files lack a key the spec requires), raise that observation along with the per-file list. The user might decide the spec is wrong, not the data.

## Writes

- Nothing on the read pass.
- On user-driven fix: per-file edits to the affected vault files, each separately confirmed.
