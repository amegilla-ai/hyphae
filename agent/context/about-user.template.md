Template for the user's persistent profile. Copy to `<vault>/_hyphae/about-user.md` and fill, or let the agent populate it over time as you use Hyphae - facts about you (your name, words you use for connections, communication preferences, etc.) get written here as they emerge in conversation.

Persistent facts about the user that should inform every interaction:
- Name and how they like to be addressed
- Relevant context about how they think about relationships
- Communication preferences (tone, length, directness)
- Anything they have asked Claude to remember

## how I talk about contacts

Maps the agent's internal labels (`positive | neutral | negative`) to the user's own phrasing. The agent writes the machine label to contact frontmatter but speaks in the user's words. Edit freely.

Example (replace with the user's own phrases):

```
positive: "lifted", "a good one"
neutral: "fine"
negative: "hard", "left me flat"
```

## what makes a quality connection for me

A short list of concrete, observable markers the user cares about in a contact. The agent uses these to pick the one question it asks at log-time and to highlight matching moments in the narrative. See `agent/context/fields/quality.md` for how these are used.

Rule: each marker must be a thing that either happened or didn't in a given contact. If you can't answer yes/no, it's too abstract.

Example (replace with the user's own list):

- laughed
- talked about something that mattered
- didn't feel rushed
- felt heard

Keep the list short (3-5 items). Edit freely as the user's thinking evolves.

## Neurodiversity (optional)

If any neurodiversities affect how you experience relationships, note them here. The agent uses this to read patterns in context - for example, to expect bimodal contact with ADHD, or to recognise context-community ties as real weak ties with autism. Leave blank if you prefer not to say.

Example (replace or leave blank):

- autism
- ADHD

If there are specific things that tire you socially (big groups, busy places, long conversations, particular people, specific modes like phone calls), you can note them in plain prose below. Optional.

## How I prefer to communicate (optional)

If certain modes are easier or harder for you (e.g. voice notes work, phone calls don't; text is costly because of dyslexia; in-person needs advance planning), note them here. The agent uses this when suggesting how to reach out. Plain prose, no structure.

See `agent/context/fields/layer.md` for how this informs agent behaviour. Research summary: `docs/nd-dunbar-research.md`.

## My personal layer capacities (optional)

If your actual network differs from the Dunbar defaults (2 / 5 / 15 / 50 / 150 cumulative), declare your own capacities here. The agent treats these as your specifics rather than the population norm, and never treats underpopulated layers as gaps.

Example (replace or leave blank):

```
inner: 1
close: 3
friend: 8
familiar: unspecified
casual: unspecified
```

If unset, the agent uses the Dunbar defaults but never pressures the user to fill any layer.

## Check-in size

How many people the agent reviews per check-in. Default: 5. Set to a number between 1 and 10, or "all" if you want every person covered. The user-named people you bring up are always in on top of this.

```
checkin_size: 5
```
