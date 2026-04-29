---
id: 
goal: 
goal_status: 
created: {{date:YYYY-MM-DD}}
cssclasses:
- hyphae-collapse-props
---
## Summary

```dataview
TABLE WITHOUT ID date AS "Planned", mode, action, file.link AS event
FROM "_hyphae/contacts"
WHERE contains(with, this.file.link) AND planned = true
SORT date ASC
```

```dataview
TABLE WITHOUT ID date AS "Connected", mode, quality, file.link AS event
FROM "_hyphae/contacts"
WHERE contains(with, this.file.link) AND planned != true
SORT date DESC
LIMIT 10
```

## Goal

## Notes

## Groups

```dataview
LIST
FROM "_hyphae/groups"
WHERE contains(members, this.file.link)
```

