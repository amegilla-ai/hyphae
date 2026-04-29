# Fields

Every field that carries meaning the user needs to understand. Structural fields (ids, dates, names, tags) are documented in [`agent/context/data-model.md`](agent/context/data-model.md).

## Semantic fields

```dataview
TABLE WITHOUT ID
  file.link AS Field,
  applies_to AS "Applies to",
  fields AS "Keys"
FROM "_hyphae/agent/context/fields"
SORT file.name ASC
```

## By file type

### Person

- [[layer]] - which of the five Dunbar circles
- [[goal]] - what you're trying to do with this relationship, and where it stands (`goal` + `goal_status`, paired)

### Contact event

- [[quality]] - how the interaction felt

### Check-in

- [[capacity]] - your social energy

## Reference

For full constraints (types, required/optional, valid values), see each field's own file. For structural fields and file-type paths, see [`agent/context/data-model.md`](agent/context/data-model.md).
