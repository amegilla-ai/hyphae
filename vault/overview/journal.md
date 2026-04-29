---
cssclasses:
- hyphae-dashboard
- hyphae-collapse-props
---
Rolling summary of check-ins, newest first. Each row is the summary from one session; click through to the full check-in for the narrative.

```dataview
TABLE WITHOUT ID
  date AS "Date",
  summary AS "Summary",
  file.link AS "Full check-in"
FROM "_hyphae/checkins"
SORT date DESC
```
