# Research: how neurodiverse adults relate to the Dunbar framework

Purpose: interrogate where Hyphae's current layer model - Dunbar's layered sizes, per-layer functions, cadence floors, and the social fingerprint principle - fits or mis-fits the experience of autistic and ADHD adults, and recommend adjustments.

Method: web search and source verification (April 2026). Peer-reviewed studies preferred; lived-experience sources included where they speak to specific gaps in the research literature and are flagged as such.

Confidence notation used below:
- **Strong** - meta-analysis or multiple converging peer-reviewed studies
- **Moderate** - one or two peer-reviewed studies with solid methodology
- **Preliminary** - single study, small sample, or indirect evidence
- **Lived-experience** - first-person or practitioner accounts, not controlled research
- **Gap** - no direct evidence found

---

## 1. Is the layered/gradient model experienced the same way?

**Finding: partially.** The gradient structure does appear in autistic social networks, but the *shape* of the gradient differs - networks are smaller and the distribution across layers is compressed.

**Evidence (Moderate):** A 2025 systematic review (Lei, Qian & Kim, *Autism in Adulthood*) found autistic adults' social networks average around 7-8 people with densities of 0.32-0.39. In Dunbar's terms that lands between the support clique (~5) and the sympathy group (~15) - effectively collapsing those two tiers into one, rather than presenting as distinct layers with different functions.

Gal & Yirmiya (2022, *JADD*, N=40) complement this: autistic adults describe social participation across five *contexts* (vocational, neighbourhood, interest-groups, support services, online) at "different levels" - gradient-like, but organised around context rather than emotional closeness. 55% of participants were employed; 60% reported at least one close friend. Connection happens in layers, but the layers are not purely intensity-based.

**Lived-experience:** Autistic-led accounts frequently describe relationships as more binary than gradient - "my people and everyone else" - which the research partially supports: the small number of close ties is real, but the research also finds meaningful mid-tier engagement in contexts (workplaces, hobby groups) that lived-experience framing sometimes undercounts.

---

## 2. Do the intimacy-at-5 and socialising-at-15 layer functions hold?

**Finding: the functions are recognisable but compressed. Intimacy concentrates in fewer people; the socialising function often migrates into context-based groups rather than a sympathy-group of 15.**

**Evidence (Moderate):** Networks sized 7-8 with higher density mean fewer people doing both intimacy and socialising work, rather than a clear 5-vs-15 split. Gal & Yirmiya describe autistic adults building belonging through "common interest groups" and "online networks" - functionally the socialising layer, but organised around shared focus rather than a friend-count threshold.

**Lived-experience:** AuDHD and autistic-led writing consistently describes emotional intimacy as limited to a very small number (often 1-3) with a preference for depth over breadth. The "sympathy group" function (everyday companions for dinner/evenings out) is commonly missing or replaced by activity-based contact (board games, D&D, online chat groups).

**For Hyphae:** layer 2's function (intimacy/support clique) may realistically hold 1-3 people, not 5. Layer 3's function (socialising) may be present but shaped as activity-contexts more than individual friendships.

---

## 3. Are Dunbar's cadence floors reasonable for ND users?

**Finding: the absolute floors are probably too rigid. Windowed floors (rolling averages over 4-8 weeks) fit ND contact patterns better than strict weekly/monthly minima.**

**Evidence (Strong, direct):** Roberts & Dunbar (2011, 2015) found that maintaining emotional closeness requires *active contact*, and that feeling close without contact doesn't prevent decline. That supports having floors at all. But the floor period in the research was measured over 18 months and longer; the weekly/monthly thresholds Hyphae uses are derived from time-allocation percentages, not empirically validated minimum intervals.

**Evidence (Strong):** Raymaker et al. (2020) and Mantzalas et al. (2022, 2024) document autistic burnout as a syndrome of exhaustion lasting 3+ months, with social withdrawal as a core feature. Autistic adults describe "social hangovers" of hours-to-days after contact, and a "two-hour rule" at which social effort spikes. Against this, rigid weekly check-in expectations mis-specify the achievable rhythm.

**Lived-experience:** "Energy accounting" / spoon theory is widely used in the autistic community. A rolling window matches this self-management shape; a weekly-minimum does not.

**For Hyphae:** the current `layer.md` already states cadences are floors, not targets, and introduces the social fingerprint principle - good. The adjustment is to *compute* the floor as a rolling window (e.g. "seen at least once in the last 4-6 weeks for layer 2") rather than "seen this week."

---

## 4. Cadence vs capacity when capacity is low - suspend or surface?

**Finding: surface gently, don't suspend. Research supports soft-contact during low-capacity periods (reduced demand, low-commitment modes) rather than full silence - but the framing must shift from "you're behind" to "someone is there for you if you want."**

**Evidence (Strong):** Raymaker and Mantzalas both document that full social withdrawal during burnout is associated with worse outcomes over time - it relieves acute demand but contributes to stealth drift and loneliness that compounds the burnout. Recovery research emphasises reduced demand, not zero contact.

**Evidence (Moderate):** Milton et al. (2025, *Communications Psychology*, N=95) interviewed autistic adults during COVID lockdown. Participants deeply missed incidental contact and reported the absence of low-pressure "background" socialising as distressing - even when acute close-contact needs were met. The takeaway: sustained social silence, even when capacity is low, has a cost.

**For Hyphae:** `capacity.md` already scales nudges down when capacity is low - good. The adjustment is to keep the *observation* active (the agent notices drift) but soften the *response* (offer lowest-commitment mode, frame as "available if you want", never as obligation). Suspending the floor entirely during low capacity risks deferred drift that becomes hard to recover from (Roberts & Dunbar's 6.7% friendship recovery rate after lapse is the background rate).

---

## 5. Is ND contact rhythm more bimodal than neurotypical?

**Finding: yes, in two distinct ways.**

**Evidence (Strong) - time-bimodal (ADHD):** ADHD object-permanence and time-blindness research consistently show an episodic pattern - intense contact when someone is present/visible, then long gaps when they're not. Müller et al. (2024) and the wider ADHD-friendship literature describe forgetting-to-respond-for-weeks as a near-universal feature, not individual variation.

**Evidence (Moderate) - channel-bimodal (autistic):** Autistic adults often combine low in-person frequency with high digital frequency. Gal & Yirmiya and Milton et al. both document this pattern: Discord, group chats, parallel-play gaming with voice, and asynchronous online communities carry a lot of the socialising function that neurotypical models assume happens face-to-face.

**For Hyphae:** the social fingerprint principle already accepts that each user's rhythm is their own - good. The adjustment is to make *variance itself* a legitimate signal (not noise to smooth out), and to count contact across modes symmetrically. A weekly voice-note exchange in a group chat is real contact. A Discord channel someone is active in with a layer-3 person is real contact. `mode` in contact events already has `message / voice-note / async` so the schema supports this; the framing in `layer.md` should explicitly say so.

---

## 6. Do layer 4-5 functions (party friends, wedding/funeral cohort) fit ND lifestyles?

**Finding: no - and this is the biggest mis-fit in the current Hyphae model.**

**Evidence (Moderate):** Autistic adults broadly prefer small, quiet, predictable gatherings over large events. "Social hangover" after large-group events is widely reported and often costs days of recovery. Large-event attendance is not a proxy for the strength of a relationship in ND populations.

**Evidence (Strong, decisive):** Milton et al. (2025) explicitly reframes weak ties for autistic adults as *context-community* (baristas, co-workers, Discord regulars, dog-park acquaintances, library staff) rather than ceremonial-event cohorts. These ties were substantial - participants described missing them sharply during lockdown. The functional layer 4-5 for autistic adults is "people I encounter in repeating contexts", not "people I'd invite to my wedding."

**For Hyphae:** `layer.md` currently describes layer 4 as "party friends... weekend BBQ, birthday party, housewarming" and layer 5 as "wedding, bar mitzvah, funeral" cohort. Both framings will feel wrong for many ND users whose actual layer 4-5 is interest-communities and routine-encounter people. Recommend rewriting the layer 4-5 functions around *repeating context* rather than *ceremonial events*.

---

## 7. Is "drift" the right framing?

**Finding: partially. Drift is real and research-backed, but ND populations have specific patterns (parallel-play, pick-up-where-we-left-off) that the decay model mis-flags as drift when they are actually stable by design.**

**Evidence (Strong) - drift is real:** Roberts & Dunbar show relationships decay without active maintenance; feeling close without contact doesn't prevent decline. The friendship recovery rate once lapsed is low (~6.7%). Drift is a real failure mode.

**Evidence (Moderate) - parallel-play is real:** Monotropism research (Murray et al., Autistic Realms, Monotropism.org resources) documents a pattern where autistic friendships can survive long gaps if they are interest-anchored rather than contact-anchored. Shared focus carries the relationship through silence. This is not the same as "at risk" drift.

**Evidence (Lived-experience):** "We pick up where we left off" is a widely reported ND friendship pattern - low contact frequency, no social obligation to each other's schedules, mutually low maintenance. Users describe these as some of their most stable relationships.

**For Hyphae:** the drift-detection job is still right, but the model needs a per-dyad signal that marks "low contact is normal and healthy for this relationship." Options: a flag on the person file, a derived inference from history (consistently long gaps with `goal_status` staying on-track when reviewed, or `goal: maintain` holding across those gaps), or a stance the user can set. Without this, the agent will nudge on relationships that don't need it, which is exactly the kind of pressure P4 and P7 warn against.

---

## Design implications for Hyphae

Eight concrete adjustments, tied to findings.

**1. Window the cadence floors (Q3, Q5).** Move from "at least weekly" to "at least once in the last N weeks" as a rolling window. Suggested windows per layer: 4 weeks for layers 1-2, 8-12 weeks for layer 3, 6-9 months for layer 4, annual for layer 5. `layer.md` already frames these as floors not targets - small change, large impact. *Adjustment needed.*

**2. Reframe layer 4-5 function away from ceremonial events (Q6).** Current "party friends" and "wedding/funeral cohort" language is a poor fit for autistic adults. Replace with *repeating-context* language: layer 4 as "people you see in regular shared contexts" (hobby groups, activity-based communities, work adjacencies); layer 5 as "people held in your awareness, encountered occasionally in life events or online." Avoid event-attendance as a proxy for relationship strength. *Adjustment needed.*

**3. Count contact symmetrically across modes (Q5).** Voice-note exchanges, Discord messages, shared gaming sessions, async online communities all count as contact for cadence purposes. The `mode` field already supports this; `layer.md` should say it explicitly so the agent doesn't implicitly under-weight digital channels. *Small edit.*

**4. Add a per-dyad "low-contact-by-design" marker (Q7).** Some relationships survive long gaps by design. The agent needs a way to know a particular relationship is structurally bursty / parallel-play and shouldn't be nudged on frequency. Options: a frontmatter flag (e.g. `contact_pattern: bursty`), a body-text signal in the person file, or an inferred state from observed history with `goal_status` staying on-track across long gaps. Lean toward explicit marker + agent-inferred suggestion. *New mechanism.*

**5. Treat variance as signal, not noise (Q5).** ND contact rhythm is genuinely bimodal for some people. Rather than smoothing variance out to compute "average cadence," keep variance as a feature and learn the user's typical variance per person. On-track detection should compare current rhythm to the user's own prior rhythm with that person, not to a smoothed expectation. *Future on-track pattern work; record as a design note.*

**6. During low capacity: soften, don't suspend (Q4).** Current `capacity.md` scales nudges down; keep that. Add explicit language: the agent still *notices* drift during low capacity (for later surfacing when capacity returns) but reframes nudges as "available if you want" in lowest-commitment mode, never as obligation. Also: after extended low-capacity periods, surface any relationships the user may want to re-thread before loss compounds. *Small edit to capacity.md.*

**7. Compress layers 1-3 for ND users if the actual network is small (Q1, Q2).** The five-layer model assumes ~150 people total. Many autistic adults have networks of 7-15. Rather than scaling down layer sizes, accept that layers 3-5 may be functionally empty for some users - and don't pressure them to "fill" any layer. The "two patterns" principle in `layer.md` already says this for close-vs-weak distribution; strengthen it to say layer population is a capacity, not a target, even more explicitly. *Small edit.*

**8. Acknowledge the bounds of current research in the field file itself (Q1-7 cumulatively).** `layer.md` is the agent-facing spec. Add a short note that the model is calibrated against general-population Dunbar research, that ND patterns differ in specific ways documented in `docs/nd-dunbar-research.md`, and that the agent should read patterns in context rather than treating the floors as authoritative per-user. Keeps the spec honest. *Small edit.*

---

## Sources

1. Lei, J., Qian, X., & Kim, K.M. (2025). Social Network Structure in Autistic Individuals: A Systematic Review. *Autism in Adulthood*. https://www.liebertpub.com/doi/abs/10.1089/aut.2024.0029

2. Gal, E., & Yirmiya, N. (2022). Beyond Friendship: The Spectrum of Social Participation of Autistic Adults. *Journal of Autism and Developmental Disorders*. https://pmc.ncbi.nlm.nih.gov/articles/PMC8788910/

3. Milton, D. et al. (2025). Weak ties and the value of social connections for autistic people as revealed during the COVID-19 pandemic. *Communications Psychology*. https://pmc.ncbi.nlm.nih.gov/articles/PMC11883032/ (N=95)

4. Raymaker, D.M. et al. (2020). "Having All of Your Internal Resources Exhausted Beyond Measure and Being Left with No Clean-Up Crew": Defining Autistic Burnout. *Autism in Adulthood*. Referenced in AASPIRE validation study: https://pmc.ncbi.nlm.nih.gov/articles/PMC12717295/

5. Mantzalas, J. et al. (2022). What Is Autistic Burnout? A Thematic Analysis of Posts on Two Online Platforms. *Autism in Adulthood*. https://journals.sagepub.com/doi/10.1089/aut.2021.0021

6. Mantzalas, J. et al. (2024). Measuring and validating autistic burnout. *Autism Research*. https://onlinelibrary.wiley.com/doi/10.1002/aur.3129

7. Roberts, S.G.B., & Dunbar, R.I.M. (2015). Managing Relationship Decay: Network, Gender, and Contextual Effects. *Human Nature*. https://pmc.ncbi.nlm.nih.gov/articles/PMC4626528/

8. Roberts, S.G.B., & Dunbar, R.I.M. (2011). Communication in social networks: Effects of kinship, network size, and emotional closeness. *Personal Relationships*. https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1475-6811.2010.01310.x

9. Müller, V., Mellor, D., & Pikó, B.F. (2024). Associations Between ADHD Symptoms and Rejection Sensitivity in College Students. https://journals.sagepub.com/doi/10.1177/09388982241271511

10. ADHD object permanence and executive function: https://www.simplypsychology.org/object-permanence-and-adhd.html (secondary source summarising research literature; used for lived-experience descriptions, not primary evidence)

11. Monotropism (Murray et al. 2005 and subsequent): https://monotropism.org/dinah/monotropism-2020/ and https://monotropism.org/wellbeing/

12. ADHD friendship challenges narrative review: https://www.frontiersin.org/journals/developmental-psychology/articles/10.3389/fdpys.2024.1390791/full

13. Autistic "social hangover" and event preferences (lived-experience synthesis with research citations): https://the-art-of-autism.com/the-social-hangover-autism-and-social-events/, https://stimpunks.org/burnout/
