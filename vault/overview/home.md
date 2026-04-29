---
cssclasses:
- hyphae-dashboard
- hyphae-collapse-props
---
Where things stand. Open this when you want to see the state of your network at a glance, or to decide what to do next.

## Needs attention

Ask Claude to run a check-in.

```dataview
TABLE WITHOUT ID
  file.link AS "Person",
  goal AS "Goal",
  last_reviewed AS "Last reviewed"
FROM "people"
WHERE goal_status = "needs-attention"
SORT last_reviewed ASC
```

## In motion

Planned contacts coming up.

```dataview
TABLE WITHOUT ID
  date AS "When",
  with AS "With",
  mode AS "Mode",
  action AS "Action"
FROM "_hyphae/contacts"
WHERE planned = true AND date >= date(today)
SORT date ASC
LIMIT 10
```

## Did these happen?

Run a check-in to update.

```dataview
TABLE WITHOUT ID
  date AS "When",
  with AS "With",
  mode AS "Mode",
  action AS "Action"
FROM "_hyphae/contacts"
WHERE planned = true AND date < date(today)
SORT date ASC
```

## Recent activity

Last few logged contacts.

```dataview
TABLE WITHOUT ID
  date AS "When",
  with AS "With",
  mode AS "Mode",
  quality AS "Quality"
FROM "_hyphae/contacts"
WHERE planned != true
SORT date DESC
LIMIT 5
```

## Recent check-ins

```dataview
TABLE WITHOUT ID
  date AS "Date",
  summary AS "Summary",
  file.link AS "Full check-in"
FROM "_hyphae/checkins"
SORT date DESC
LIMIT 3
```

## What to do next

Prompts to copy into a chat with Claude.

- `let's do a check-in` - the regular pulse. Where things stand, what needs you, what to do.
- `tell me about [person]` - context before you act. About to message someone? Haven't thought about them in a while? Ask first.
- `I want to log something` - capture what happened, or what you're planning. The agent figures out whether it's a past contact, a future plan, a new person, or a new group.
- `check my vault` - read-only walk of every file against the schema. Reports anything broken; offers to walk through fixes with you.
- `help me move forward with [person]` - *(not yet wired up)* future move: when you have a goal but don't know what to do, the agent suggests concrete next actions based on what's in the vault and what you've said about the person.

## Other dashboards

- [[journal|Full check-in journal]]
- [[planned-connections|All planned contacts]]
- [[past-connections|All past contacts]]
- [[fields|Fields reference]]
