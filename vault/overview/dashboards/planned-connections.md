---
cssclasses:
- hyphae-dashboard
- hyphae-collapse-props
---
Contact events queued for the future, plus past-dated plans that haven't been resolved yet. Each row shows the person, when, the mode, and any action you need to take first.

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

## Upcoming

```dataview
TABLE WITHOUT ID
  date AS "When",
  with AS "With",
  mode AS "Mode",
  action AS "Action"
FROM "_hyphae/contacts"
WHERE planned = true AND date >= date(today)
SORT date ASC
```
