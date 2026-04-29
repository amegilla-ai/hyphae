---
cssclasses:
- hyphae-dashboard
- hyphae-collapse-props
---
Contacts that have already happened, newest first. Quality and mode give at-a-glance trend.

```dataview
TABLE WITHOUT ID
  date AS "When",
  with AS "With",
  mode AS "Mode",
  quality AS "Quality"
FROM "_hyphae/contacts"
WHERE planned != true
SORT date DESC
LIMIT 50
```
