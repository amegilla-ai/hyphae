# Welcome to Hyphae

You've installed Hyphae and opened your vault. This page walks you through how it works. Once you've read it, your usual landing page is [[home]] - state of your network, what needs you, what to do next.

## What Hyphae is

Hyphae is two things working together:

- **A vault.** A folder of markdown files - one per person, one per contact event, one per group, one per check-in. You're looking at it now in Obsidian.
- **An agent.** Claude (or another coding agent) that you talk to in natural language. The agent reads and writes the vault on your behalf.

You don't fill in forms. You don't click through screens. You open Obsidian to look at what's there, and you talk to the agent when you want to do something.

## The home page

[[home]] is where you'll land most of the time. Sections you'll see, in order:

- **Needs attention** - people whose goals aren't currently being met. Ask Claude to run a check-in.
- **In motion** - planned contacts coming up.
- **Did these happen?** - planned contacts whose date has passed and that haven't been resolved.
- **Recent activity** - last few logged contacts.
- **Recent check-ins** - last three check-ins.
- **What to do next** - prompts you can copy into a chat with Claude.

## Talking to the agent

Open a chat with Claude (Claude Code, the desktop app, or wherever you've configured the runtime). Make sure the agent has access to your vault (via the working directory, MCP, or whatever the runtime uses).

The main prompts to know:

- **`let's do a check-in`** - the regular pulse. The agent walks through people who need attention, asks where things stand, and captures what to do.
- **`tell me about [person]`** - context before you act. About to message someone? Haven't thought about them in a while? Ask first.
- **`I want to log something`** - capture what just happened, or something you're planning. The agent figures out whether it's a past contact, a future plan, a new person, or a new group.

These aren't magic strings - the agent reads its process specs and figures out what you mean. "Run a check-in", "let's check in", "do a check-in" all work.

## What a check-in does

A check-in is the main move you'll make with Hyphae. It walks through:

1. The agent picks people who need attention (off-track goals, lapsed rhythm, things you've flagged).
2. For each, it tells you where things stand and asks what you want to do - log something, plan a contact, change the goal, leave it.
3. You answer in plain language. The agent writes to the vault as you go.
4. At the end, you get a summary and a list of things you've committed to do.

You can stop at any time. You can do as many or as few people as you want. You can name specific people for the agent to cover. There's no "right" length.

## How to use it

Two main moves: log contacts when they happen, and run a check-in once a week.

### Logging contacts

When something happens - a coffee, a call, a voice note - tell the agent. "I had coffee with Sam, it was good" is enough. The agent writes a contact file, asks one short question if useful, moves on.

If you don't log in the moment, batch it later: "let me log a few things." The next check-in works better with real data than with guesses.

### The weekly check-in

Pick a regular time - Sunday evening, Friday lunch, whatever fits - and ask the agent to run a check-in. The agent looks at who needs attention against their goals, who you've flagged, and who you haven't reviewed in a while. For each, it tells you where things stand and asks what you want to do.

You leave the check-in with a list of planned contacts to do that week, each with an action ("text Sam first to suggest Saturday"). Open the home page during the week. Do them. The next check-in reconciles what happened.

Once a week is the right cadence for most people. Daily is too often; you'll mostly hear "nothing's changed."

### Actions, not vague intentions

When you plan a contact, the agent asks what needs to happen first. "Call Sam" is vague. "Text Sam tonight to suggest Saturday" is something you can do or not do. The action field is where the executive-function gap closes - the smaller and more specific the next step, the more likely it gets done.

### Goals

Most people in your vault won't have a goal set. That's correct. A goal is a hint to the agent that you have an active intent with this person right now - to deepen with Sam, to reconnect with Priya, to repair something with Alex. Set one when you mean it. Clear it when you don't.

If the agent flags someone as needs-attention week after week and you keep saying "leave it," the goal is probably wrong. Change it or remove it. Goals you carry without intent are just guilt.

### Telling the agent things

Anything you'd want the agent to remember about a person, just say. "Sam's mum has been ill." "Priya started a new job last month." The agent writes to the person's `## Notes` section. Next time you check in or ask about that person, the agent has the context.

Working memory loses things. The vault doesn't.

### Practical things

- Use plain language. Don't try to sound like a database.
- Push back when the agent's read is wrong. "Actually we've been texting, I just haven't logged it" should change what gets written. If it doesn't, that's a bug.
- Trust the data more than your gut about who you've seen lately. Time blindness is real; the agent doesn't have it.
- The minimum is: log when things happen, check in once a week. Goals, quality fields, and actions are all optional. Add them when they help.

### When something isn't working

If the agent flags people you're fine with, or skips people you want to think about, or the weekly cadence is too much, tell it. The check-in size, what counts as needs-attention, and which people get watched are all adjustable. Hyphae fits around how you actually live; if it doesn't, change the settings.

## Layers

Every person in your vault sits in one of five layers, modelled on Dunbar's circles:

| Layer | Floor cadence | Examples |
|---|---|---|
| **Inner** | Daily-ish | Partner, possibly a best friend |
| **Close** | Weekly | People you'd turn to in a crisis |
| **Friend** | Every 4-5 weeks | Ordinary social life |
| **Familiar** | Every 6 months | Shared-context friends, party people |
| **Casual** | Yearly | Wider network, family you don't see often, ex-colleagues |

The cadence is a typical contact frequency Dunbar found at each layer - what the agent uses as a reference. Your actual contact pattern with each person is your own.

The layer is the folder the file is in. To move someone up or down a circle, drag the file between folders in Obsidian.

## Goals

Goals are optional. Most people in your vault won't have one - they're at their layer's default rhythm and that's fine. Set a goal when you have an active intent for a particular relationship.

| Goal | For when... |
|---|---|
| **Maintain** | You want to keep this relationship at its current level |
| **Deepen** | You want to move this relationship closer than it currently is |
| **Reconnect** | Contact has lapsed and you want to restart it |
| **Repair** | Something specific damaged the relationship and you want to address it |
| **Transition** | A shared context ended (a job, a team, a life stage) and you want to build an intentional rhythm without it |

Per-person specifics (what you're trying to do, what's getting in the way) live as prose on the person's page under `## Goal`, not in a form.

Each goal carries a status the agent maintains: `on-track` (the goal is being met) or `needs-attention` (it isn't). You don't write this directly - it's set during check-ins.

## Where things live

```
people/
  A. inner-circle (2)/
  B. close-circle (5)/
  C. friend-circle (15)/
  D. familiar-circle (50)/
  E. casual-circle (150)/
overview/
  home.md            # the page you start from
  journal.md         # all past check-ins
  dashboards/
    planned-connections.md
    past-connections.md
_hyphae/
  contacts/          # one file per contact event
  checkins/          # one file per check-in
  groups/            # group definitions
  reports/           # generated reports (when there are any)
  templates/         # blank templates the agent uses
  agent/             # agent runtime config (don't edit unless you know why)
```

The folders with parentheses on `people/` are the layers. The numbers are Dunbar's cumulative sizes - guidance, not enforcement.

## Privacy

The vault is local markdown. Nothing leaves your device unless you sync it yourself.

What happens with the agent depends on which model you're running. A local model means everything stays on your machine. A cloud model means each turn sends parts of the vault to whoever runs the model.

## When something feels wrong

If a row in the home page tables doesn't match reality - someone's listed as off-track but you know things are fine - run a check-in and tell the agent. The check-in is how you correct what the vault thinks.

If the agent says something that misreads the relationship, push back. The agent should defer to you - "no, that's not how it is" should change what gets written. If it doesn't, that's a bug worth flagging.
