Index of named processes Claude follows for recurring requests.

Each process is one file. Style marked at the top: `structured` (faithful step list) or `prose` (adaptive playbook).

## Processes

| File | Style | Purpose |
|---|---|---|
| `add_person.md` | structured | Introduce a new person to the vault through conversation. Sets layer, optional goal, and relationship context. |
| `log_contact.md` | structured | Record a contact event (past or planned) with one or more people. |
| `plan_group_event.md` | structured | Capture a multi-person event as one planned contact - participants, optional group, action on the user, prep notes. |
| `add_group.md` | structured | Create a new group file with members. |
| `add_to_group.md` | structured | Add a person to an existing group's members list. |
| `remove_from_group.md` | structured | Remove a person from an existing group's members list. |
| `change_goal.md` | structured | Change a person's goal value, capture specifics, re-assess goal_status, optionally refresh Summary. |
| `describe_person.md` | structured | Read out the agent's view of a person grounded in vault content. |
| `checkin.md` | structured | Walk through prioritised people to assess state against goals, capture decisions, plan contacts. Main stock-taking process. |
| `init_vault.md` | structured | First-run process: ask where the vault should live, run hyphae-init.sh, write .hyphae-vault. |
| `lint.md` | structured | Read-only walk of every file against the schema; reports anything broken; offers to walk through fixes. |

## Cross-process conventions

- **Person Summary handling** (D063): any process that touches a person page must seed `## Summary` if it's empty, and refresh it only on material change if it's populated. Never write Summary without explicit user confirmation. Rules for "material change" live in each process file that needs them (see `log_contact.md` *Material change* section for the canonical heuristic).

