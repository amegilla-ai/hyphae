# About Hyphae

Why this project exists, who it's for, and the second purpose it serves as a worked example of agent-native software.

## The problem it solves

Neurodiverse brains don't automatically do what neurotypical brains do when it comes to social maintenance - tracking who you haven't spoken to, initiating contact, noticing that time has passed. The result is relationships that lapse without anyone meaning them to - the person didn't stop caring, the tracking just didn't happen.

This affects a significant portion of people with ADHD, autism, dyslexia, dyspraxia, and related conditions. Research links social isolation in neurodiverse adults to substantially higher rates of depression, anxiety, and poor life outcomes. The health risks of chronic loneliness are comparable to smoking 15 cigarettes a day.

Calendars, contacts apps, and social media were built assuming those internal tracking functions are present. Hyphae is built around the assumption that they aren't - giving external structure for cadence, reflection, and action without adding cognitive load or asking users to be someone they're not.

The research basis: [`theoretical-foundations.md`](theoretical-foundations.md), [`research-summary.md`](research-summary.md).

## Who it's for

Primarily designed for neurodiverse adults - people with ADHD, autism, dyslexia, dyspraxia, dyscalculia, and related conditions - who find that relationships they care about lapse because maintaining them consistently is harder than it should be.

Also useful for anyone going through a life transition, rebuilding a social life after a difficult period, or noticing that friendships have lapsed without anyone meaning them to as life got busier. The neurodiverse community is the primary design audience, but the problem is broader.

## A second purpose

This repo is also a working answer to a question we don't think anyone has answered well yet: **what does an AI-native app actually look like, and how do you build one?**

The argument: most conventional app infrastructure (forms, screens, routing, databases, build pipelines) is scaffolding for a UX paradigm where users click buttons and apps render screens. Reimagine the experience around an agent - user talks in natural language, state lives as human-readable files in tools the user already has open - and most of that scaffolding stops being necessary. The agent is the enabling technology; the reduction in infrastructure is a consequence of the experience change, not of adding AI to a conventional app.

This thesis is bounded - it works for personal-scale, narrative-content, single-user, latency-tolerant apps. It doesn't replace conventional infrastructure for high-throughput, real-time, multi-user, regulated, or data-heavy systems. Hyphae sits in the first category.

The full argument, what disappears, what remains, what's hard, where it works and doesn't: [`agent-native-thesis.md`](agent-native-thesis.md).
