# Research Summary Report
## Hyphae - Evidence Base & Design Implications

This report summarises the key research papers informing Hyphae, what each paper found, and what that means for how we build the app.

---

## Section 1: The Health Case for Social Connection

---

### Paper 1
**Holt-Lunstad et al. (2015). Loneliness and social isolation as risk factors for mortality: a meta-analytic review.**
*Perspectives on Psychological Science, 10(2), 227–237.*

**What it found**
A meta-analysis of 70 longitudinal studies found that social isolation and loneliness are associated with a 26–29% increased likelihood of mortality. The effect size is comparable to well-established risk factors including obesity and smoking 15 cigarettes a day.

**So what**
Social connection is not a lifestyle preference - it is a health necessity. Loneliness is a chronic condition for 15–30% of the general population, and for neurodiverse people the prevalence is significantly higher.

**App implications**
- The app's purpose is a public health intervention, not a productivity tool. This framing should inform the tone, mission statement, and open source positioning.
- Onboarding should communicate the real stakes without being alarmist - framing connection as genuinely good for you, not as a social obligation.
- The app should never shame the user for missed connections; the health benefits of even modest improvements are significant.

---

### Paper 2
**Zhang & Dong (2022). The relationships between social support and loneliness: A meta-analysis and review.**
*ScienceDirect (N=113,427 across 177 articles).*

**What it found**
Higher social support is negatively correlated with loneliness (r = −0.39). Friend support (r = −0.48) is a stronger buffer against loneliness than family support (r = −0.34) or partner support (r = −0.40).

**So what**
Chosen friendships - the kind this app supports - are the single most protective form of social connection against loneliness. Family relationships and romantic relationships, while important, have less impact on loneliness specifically.

**App implications**
- The app's focus on chosen, maintained friendships (rather than family or romantic relationships) is well-targeted.
- The value of even a small number of maintained friendships is disproportionately high - reinforces quality over quantity.
- Messaging in the app should reflect that maintaining friendships is one of the most impactful things a person can do for their own wellbeing.

---

### Paper 3
**Cacioppo & Hawkley (2010). Loneliness Matters: A Theoretical and Empirical Review.**
*PMC / Annals of Behavioural Medicine.*

**What it found**
Loneliness creates a self-reinforcing loop: lonely people unconsciously expect negative social interactions, behave in ways that confirm those expectations, and attribute the resulting distance to others rather than their own behaviour. This is accompanied by elevated cortisol, impaired sleep, cognitive biases toward threat, and reduced immune function.

**So what**
Loneliness is not just a feeling - it actively distorts cognition and behaviour in ways that make reconnection harder. The longer someone is disconnected, the harder connection becomes.

**App implications**
- Nudges should be gentle and low-stakes, never adding to the sense of social threat or failure.
- The check-in feature should acknowledge how the user is feeling before prompting action - meeting them where they are rather than pushing.
- The app should never present overdue contacts as "failures." The language should normalise lapses and reduce the activation energy needed to reconnect.
- A "soft re-entry" prompt (e.g. a low-commitment action suggestion like liking a post or sending a meme) could help users who feel paralysed about reaching out.

---

### Paper 4
**Cambridge study on friendship thresholds (Roberts et al., via Ageing & Society).**
**Friendships, loneliness and psychological wellbeing in older adults: a limit to the benefit of the number of friends.**

**What it found**
The mental health benefits of friendship plateau quickly. Loneliness reduces meaningfully until approximately 4 close friends; depression risk until 2 friends; stress until 2 friends. Beyond these thresholds, additional friends add little incremental benefit.

**So what**
The goal is not to maximise the number of social connections - it is to maintain a small number of meaningful ones consistently. Quality and regularity matter far more than volume.

**App implications**
- The app should never gamify social contact in ways that encourage volume (e.g. streaks, total contact counts).
- Layer 1 (5 people) and Layer 2 (15 people) deserve the most design attention - these are the relationships with the highest health return.
- The optional relationship goal (maintain / deepen / reconnect / repair / transition), set per person when the user has active intent, is more important than the raw contact count for driving the right coaching behaviour.
- Success metrics in the app should be framed around the depth and consistency of a small number of relationships, not breadth.

---

## Section 2: Dunbar's Social Brain Hypothesis

---

### Paper 5
**Dunbar, R.I.M. (1992, 1998). The social brain hypothesis.**
*Evolutionary Anthropology, and subsequent publications.*

**What it found**
There is a robust statistical relationship between neocortex size and social group size across primates. For humans, this predicts a natural cognitive limit of approximately 150 stable relationships, with an inner structure of layered circles (~5, ~15, ~50, ~150, ~500).

**So what**
Human social networks are not flat - they are inherently hierarchical by emotional investment and contact frequency. This is a universal feature of human social organisation, confirmed across cultures and throughout history.

**App implications**
- Dunbar's 5-layer model is the correct organising framework for the app - it is empirically grounded, not arbitrary.
- The layer structure should be surfaced clearly to users as a meaningful framework, not just a categorisation tool.
- The app should explain the layer model to users during onboarding, so they understand why it exists and what it means for how they invest their social energy.

---

### Paper 6
**Dunbar, R.I.M. (2024). The social brain hypothesis - thirty years on.**
*Taylor & Francis / Annals of Human Biology.*

**What it found**
The four-grade fractal structure of human social networks (1.5, 5, 15, 50, 150...) has been confirmed by 23 studies across different cultures and historical periods (median N=5,457; largest N=61 million). Each layer requires a specific contact cadence to maintain. Dunbar also quantified that we devote ~40% of our social time to just 5 people, and ~60% to just 15.

**So what**
The cadence requirements for each layer are not arbitrary - they reflect genuine cognitive and emotional maintenance costs. Spending social time is a finite resource that must be budgeted.

**App implications**
- Nudge frequency should be derived from Dunbar's cadence research: Layer 1 weekly, Layer 2 monthly, Layer 3 quarterly, Layer 4 yearly, Layer 5 bi-yearly.
- The concept of social time as a finite budget (capacity feature) is theoretically supported - the app's capacity system is not just UX convenience, it reflects real cognitive limits.
- The "40% of time to 5 people" finding supports the app's emphasis on the innermost layers as the primary focus.

---

### Paper 7
**PMC (2025). Reflecting on Dunbar's Numbers: Individual differences in energy allocation.**
*(N=906, peer-reviewed)*

**What it found**
Significant individual variation exists in how people perceive and allocate social energy across network layers. Extraversion was not associated with energy allocation (contrary to expectation); self-esteem was associated with greater investment in the middle (Layer 2) network. People have an intuitive "lay theory" of their own layered social network.

**So what**
The Dunbar framework describes averages, not fixed rules. Individual variation is real and significant. People already have an implicit understanding of their social layers - the app makes that implicit knowledge explicit.

**App implications**
- The app should not prescribe how many people a user "should" have in each layer - it should help them reflect on and act on their own existing sense of their network.
- The layer-placement interview questions should surface the user's intuition, not impose a structure on them.
- The capacity feature must be flexible and personal - there is no single right answer to how much social energy someone has.
- Low self-esteem may predict underinvestment in Layer 2 (close friends) - the check-in feature could gently probe this.

---

### Paper 8
**PMC (2021). 'Dunbar's number' deconstructed.**
*(Bayesian reanalysis of Dunbar's dataset)*

**What it found**
A reanalysis using updated methods found wide confidence intervals around the 150 figure (95% CI: ~4–520). The exact number varies significantly by method. Critics also note that cultural mechanisms can expand human social capacity beyond biological limits.

**So what**
Dunbar's number is a useful heuristic, not a hard cognitive ceiling. Individual and cultural variation is substantial. The layered structure is more empirically robust than the specific numbers.

**App implications**
- The app should present Dunbar's layers as a guide and framework, not as prescriptive limits.
- Users should be free to have more or fewer people in any layer than the "canonical" numbers suggest.
- The layer caps in the app (5, 15, 50, 150, 500) should be soft suggestions with warnings, not hard constraints.
- The app should communicate this nuance to users so they don't feel they're "doing it wrong."

---

## Section 3: ADHD and Relationship Maintenance

---

### Paper 9
**CHADD. Relationships & Social Skills in Adults with ADHD.**
*chadd.org (clinical evidence review)*

**What it found**
ADHD is now understood as an executive function impairment. The social deficits associated with ADHD are not primarily a lack of social skills - they are a failure to reliably deploy skills already acquired. Over 25% of Americans experience chronic loneliness; the rate for adults with ADHD is likely substantially higher.

**So what**
The problem to solve is not teaching people how to be good friends - it is providing the external structure that substitutes for the internal executive function they lack. Social skills training alone is insufficient; what's needed is consistent environmental scaffolding.

**App implications**
- The app must never be prescriptive or instructional about how to be a friend. It is a reminder and tracking system, not a social skills course.
- Every feature should reduce friction, not add cognitive load.
- Reminders must be timely, specific, and low-stakes - not guilt-inducing.
- The app is explicitly a prosthetic tool for executive function, not a therapeutic intervention.

---

### Paper 10
**Frontiers in Developmental Psychology (2024). Why can't we be friends? A narrative review of friendship challenges in ADHD.**

**What it found**
Friendship difficulties in ADHD are driven by four interacting factors: ADHD symptomatology (inattention, impulsivity), executive functioning deficits, social cognition differences, and emotion regulation difficulties. These persist from childhood into adulthood. Many ADHD individuals have the interpersonal skills to interact with others - the challenge is consistency and follow-through.

**So what**
The friendship gap in ADHD is not about wanting connection less or being less capable of it - it is about maintaining consistent follow-through over time. This is a systems problem, not a character problem.

**App implications**
- The app's framing must be explicitly strengths-based: "You know how to be a great friend. We help you show up consistently."
- The four contributing factors (symptomatology, executive function, social cognition, emotion regulation) suggest the check-in feature should probe across all four dimensions, not just logistics.
- Emotion regulation support (e.g. checking in on how the user feels about a relationship before nudging them to contact someone) is clinically relevant, not just a nice-to-have.

---

### Paper 11
**PMC (2024). ADHD in adults and relationship with executive functioning and quality of life.**
*(N=40, case-control design)*

**What it found**
Adults with ADHD had significantly poorer executive function (Stroop Test) and significantly lower quality of life in the social relationships domain (WHOQOL Domain 3: M=3.3 vs M=3.8 for controls). More ADHD symptoms correlated directly with lower social relationship quality.

**So what**
The executive function deficit directly and measurably reduces social quality of life. This is not anecdotal - it is quantifiable. Interventions that support executive function should therefore improve social QoL.

**App implications**
- The app's core mechanism (externalising social tracking) directly targets the executive function gap that reduces social QoL.
- This paper provides a rationale for tracking relationship quality as a metric - users may be able to observe improvement over time as the app compensates for their executive function gaps.
- The relationship quality feature - a connection score (1–5) combined with "is this where you want it to be?" - is clinically meaningful, not just a UX feature.

---

### Paper 12
**Caroline Maguire / ADHD Coaching research. ADHD and Friendships.**
*carolinemaguireauthor.com / ADDitude Magazine*

**What it found**
"Out of sight, out of mind" is a real and well-documented phenomenon in ADHD. People with ADHD have a tendency to forget people who are not currently in their immediate environment. Working memory issues affect not just task recall but the ongoing awareness of relationships. The key compensatory strategy identified is structuring contact into routines.

**So what**
The primary design insight: absence from physical or digital view = absence from relational awareness. The app must make the people who matter visible and present even when they're not in the user's immediate environment.

**App implications**
- The home screen "Reach out" list is the most important feature in the app - it makes absent people present.
- Push notifications (when implemented) are not optional niceties - they are the core mechanism.
- The app should make it easy to see all your important people at a glance, not buried in menus.
- Contact history and "last seen X days ago" are cognitively important for users who have no internal sense of elapsed time.

---

## Section 4: Autism and Social Relationships

---

### Paper 13
**Spain et al. (2018) / Maddox & White (2015). Social anxiety in autistic adults.**
*ScienceDirect / cited across multiple reviews*

**What it found**
Approximately 50% of autistic adults meet criteria for clinically diagnosed social anxiety disorder. Many more experience sub-clinical symptoms. Social anxiety in autism is maintained by different mechanisms than in non-autistic people - particularly the cognitive and behavioural aftermath of interactions (post-event processing, anticipatory anxiety).

**So what**
For autistic users, the barrier to reaching out is not forgetfulness - it is anxiety. The anticipation of negative outcomes, fear of saying the wrong thing, or dread of the interaction itself can prevent initiation even when the user wants to connect.

**App implications**
- The app must offer low-commitment contact options - not just "call them" but "send a meme," "like their post," or "send a voice note."
- The relationship goal "maintain" should have minimal-effort pathways that still count as meaningful contact.
- The check-in feature should specifically ask "how do you feel about reaching out to [person]?" not just "have you contacted them?"
- Anxiety about a specific person or relationship should be surfaceable and acknowledged - not just prompted past.
- No time pressure or urgency framing in nudges - autistic users may need more processing time before acting.

---

### Paper 14
**Morrison et al. / Sasson et al. (2020). Social interaction in autism: partner compatibility.**
*UT Dallas / Autism journal (N=125, mixed autistic/non-autistic dyads)*

**What it found**
Autistic adults rated their interactions with other autistic people significantly more favourably than interactions with non-autistic people. Non-autistic people equally struggle to understand autistic communication - the difficulty is bidirectional. Social disability in autism is context-dependent, not universal.

**So what**
The "double empathy problem" (Milton, 2012) reframes autism social difficulties as a mismatch between communication styles, not a deficit in the autistic person. Autistic people are not inherently socially impaired - they function well in the right relational context.

**App implications**
- The app should never frame autistic users as having a social deficit to overcome. The framing is: the social world was not designed for your communication style - this app helps you navigate it on your terms.
- The connection score and "is this where you want it to be?" question together capture whether a relationship feels effortful due to neurotype mismatch or genuine disconnection - the coaching response can probe further if the score is low.
- The app could eventually surface patterns: "You tend to feel more connected after X type of interaction" - helping users identify what kinds of contact work best for them.

---

### Paper 15
**Davis & Crompton (2021). Reconceptualising social cognition in autism: bidirectional misattunement.**
*Sage / Perspectives on Psychological Science*

**What it found**
Deficit-based accounts of autistic social difficulties are overly simplistic. Emerging evidence supports reconceptualising these difficulties as bidirectional misattunement between autistic and non-autistic individuals. Social difficulties emerge most clearly in cross-neurotype interactions, not autistic-autistic interactions.

**So what**
Autism is not a social disorder - it is a different social style that is disadvantaged in a neurotypical-majority world. This is a civil rights and design problem as much as a clinical one.

**App implications**
- The app's neurodiversity-affirmative stance is not just ethical positioning - it is scientifically correct.
- No deficit language anywhere in the app. The product should feel designed for neurodivergent people, not for neurotypical people trying to manage a neurodiverse condition.
- This framing should be prominent in the open source README and documentation - it will matter to the community adopting the tool.

---

### Paper 16
**ScienceDirect (2024). Brief report: Social relationships among autistic young adults.**
*(N=101, autistic young adults ~age 25)*

**What it found**
Many autistic adults value and desire social relationships, despite characterisations to the contrary. Social challenges vary significantly based on cognitive ability and individual profile. Informant reports (from people who know the autistic person) provide useful additional perspective on social relationships.

**So what**
Autistic people want connection. The challenge is access, not motivation. Support needs to be individually tailored - there is no one-size-fits-all autistic social profile.

**App implications**
- The relationship goal and layer-placement interview questions must be flexible and individually driven - they should surface what the user wants, not prescribe what autistic people "typically" need.
- The app should never assume low social motivation. The default assumption is that the user wants connection and needs practical support.
- Personalisation is not a premium feature - it is the core product requirement.

---

### Paper 17
**Yew, Hooley & Stokes (2023). Relationship satisfaction for autistic and non-autistic partners.**
*Sage / PMC (N=95 autistic, N=65 non-autistic partners)*

**What it found**
Autistic individuals report lower satisfaction in romantic relationships compared to non-autistic individuals. However, partner responsiveness - feeling understood and valued by the other person - significantly predicted relationship satisfaction for both autistic and non-autistic partners equally. The key predictor of relationship success is mutual responsiveness, not neurotype.

**So what**
Relationship quality for autistic people is highly sensitive to feeling understood by the other person. This is not unique to autism - but the threshold may be higher, and the experience of not being understood more frequent.

**App implications**
- The "is this where you want it to be?" question surfaces whether the user feels understood and valued in the relationship - the coaching layer can respond to a low score with prompts around this.
- This reinforces that quality tracking is more important than contact frequency tracking.
- This reinforces that quality tracking is more important than contact frequency tracking.

---

## Section 5: Dyslexia, Dyspraxia, and Broader Neurodiversity

---

### Paper 18
**Ryan, M. (2004). Social and Emotional Problems Related to Dyslexia.**
*International Dyslexia Association Fact Sheet.*

**What it found**
Dyslexia frequently causes difficulty reading social cues, finding the right words, and recalling the sequence of events in conversations. Difficulty with oral language functioning creates disadvantage in peer relationships, particularly as language becomes more central in adolescence and adulthood. Social immaturity and awkwardness in social situations are commonly reported.

**So what**
Dyslexia affects more than reading - it affects the social currency of conversation, memory, and sequencing that relationships depend on. Written communication (texts, messages) is the dominant modern mode of maintaining friendships, and this is precisely where dyslexic people face the most friction.

**App implications**
- The app must minimise text-heavy interactions. Short prompts, quick-tap options, and voice-friendly UX reduce the friction dyslexic users face.
- Contact records and notes about people should be easy to add but not required - not everyone will want to write things down.
- The check-in feature should offer pre-written options to tap, not blank text fields as the primary input.
- The app should never require users to be articulate to use it effectively.

---

### Paper 19
**PMC (2024). Growing up with dyslexia: child and parent perspectives.**
*(N=17 children, qualitative study)*

**What it found**
Friendship is a significant protective factor for children with dyslexia - having friends who accept them is particularly important for wellbeing and school connectedness. Social challenges arise partly from being teased for dyslexia-related difficulties, and partly from the communication differences themselves.

**So what**
For people with dyslexia, social connection is protective - and yet the mechanics of maintaining connection (written communication, remembering conversational details) are precisely where they struggle most.

**App implications**
- Reinforces that this app is especially valuable for dyslexic users who want connection but face practical friction in maintaining it.
- The app could offer simple prompts that require no writing at all - tap to mark someone as contacted, with optional notes rather than required ones.

---

### Paper 20
**Dyspraxia Foundation / Simply Put Psych. DCD/Dyspraxia: social and occupational impact.**

**What it found**
Dyspraxia/DCD affects ~5% of school-aged children. Beyond motor coordination difficulties, it creates social challenges through difficulty engaging in physical group activities (sports, playground activities), slower processing of social information, and organisational difficulties that extend to social planning.

**So what**
Social exclusion for dyspraxic people often begins in physical social contexts, which can lead to long-term withdrawal from group social settings. Organisational and sequencing difficulties mirror some of the ADHD challenges with maintaining contact cadence.

**App implications**
- Planning features (e.g. suggesting a specific low-effort activity for a given relationship) should offer non-physical options by default.
- The app should not assume that contact means in-person meetups - digital contact, voice messages, and other low-barrier options should be treated as equally valid.

---

### Paper 21
**Sage (2025). Co-Occurrence and Causality Among ADHD, Dyslexia, and Dyscalculia.**
*(Longitudinal twin and genome-wide association study)*

**What it found**
ADHD, dyslexia, and dyscalculia frequently co-occur and share genetic and cognitive foundations. Children with multiple co-occurring conditions face compounded academic and social difficulties. Slow processing speed is a common cognitive feature across ADHD and dyslexia.

**So what**
Many users of this app will have more than one neurodivergent profile. The challenges they face are additive, not discrete. A user may experience ADHD time-blindness, dyslexic communication friction, and autistic social anxiety simultaneously.

**App implications**
- The app must be designed for the most complex user, not the most straightforward one.
- Features should layer gracefully - a user with multiple profiles should find every feature helpful, not redundant or contradictory.
- Onboarding should not require users to identify a single diagnosis. The question is "how does social maintenance feel for you?" not "what's your diagnosis?"

---

## Section 6: Neurodiversity-Affirmative Design

---

### Paper 22
**Baron-Cohen, S. (2017). Neurodiversity framework.**
*Cambridge / multiple publications*

**What it found**
The neurodiversity framework positions neurological differences as natural human variation, not disorders to be fixed. It calls for a framework that does not pathologise and does not focus disproportionately on what the person struggles with - instead taking a balanced view that gives equal attention to strengths.

**So what**
The design and language of any tool for neurodiverse people must reflect this framework. A deficit-focused tool will reinforce shame and negative self-perception - the opposite of what's needed.

**App implications**
- Every piece of copy in the app must be audited for deficit language. No "you haven't contacted X in too long." Only "it might be time to reach out to X."
- The app should celebrate connection made, not punish connection missed.
- Onboarding should frame the app positively: "You have great relationships. This helps you show up for them."

---

### Paper 23
**PMC / Nature (2024). Resilience in neurodivergence: scoping review.**
*ScienceDirect*

**What it found**
Resilience in neurodiverse individuals is associated with: structured approaches to tasks, social support, a sense of autistic/neurodivergent identity, and having a trusted support network. Structured styles (organised, planning-oriented) mediate between emotional difficulties and quality of life outcomes.

**So what**
Structure is protective. Neurodiverse people who develop and use systems do better socially and emotionally. The app is directly providing one such system.

**App implications**
- The app should position itself as part of the user's personal system, not as an external obligation.
- Users who engage with the check-in and layer features regularly are building a resilience-supporting habit - this is worth communicating to them.
- Community and identity features (longer-term roadmap) could support the social identity benefits identified in this research.

---

### Paper 24
**Scientific Reports (2025). Situating emotion regulation in autism and ADHD.**
*(N=57 neurodivergent adolescents, qualitative)*

**What it found**
Neurodiverse young people are disproportionately affected by depression, anxiety, and suicidal ideation. Conventional emotion regulation approaches fail because they assume neurotypical standards. Stable, trusting relationships and predictable routines are the most effective protective factors. Neurodiverse people have their own effective strategies for managing emotion - these should be valued, not replaced.

**So what**
Predictable routines around social connection are not just useful - they are emotionally protective. The regularity of the check-in and nudge system has therapeutic value beyond the contact it facilitates.

**App implications**
- The weekly or regular check-in rhythm itself is valuable, independent of what it produces. Users should be encouraged to make it a routine.
- The app should be a stable, predictable presence - consistent UX, consistent language, no surprise changes that disrupt the user's established relationship with the tool.
- The check-in must never feel clinical or like a therapy session. It should feel like a quiet, friendly moment of reflection.
- If a user discloses distress in a check-in, the app's AI response must handle this carefully - warmth first, action second.

---

## Section 7: The Broader Friendship Maintenance Problem

---

### Paper 25
**Dickins, M. (2022). Billy No-Mates: How I Realised Men Have a Friendship Problem.**
*Canongate Books. BBC Radio 4 Woman's Hour, September 2022.*

**What it found**
A 2019 YouGov survey found that one in five men have no close friends - twice the proportion for women. A Movember Foundation poll suggested every man in three has no close friends - rising to one in two when "close" was defined as someone they could talk to about health or money worries. Since social scientists began measuring this in the early 1970s, men have consistently had fewer close friends than women, and the problem worsens with age.

Dickins identifies the structural reasons: men bond through shared activity and proximity (work, sport, shared living) rather than through explicit emotional investment. When those structures disappear - a job change, moving city, getting married - the friendships built on them quietly dissolve. Unlike women, who tend to maintain friendships through direct emotional communication and deliberate effort, many men lack both the habit and the social permission to invest explicitly in friendships.

What Dickins learned - and his book demonstrates - is that male friendships, like all friendships, require regular maintenance to keep them going.

**So what**
The friendship maintenance problem is not unique to neurodiverse people - it is a widespread structural failure that affects a large portion of the population, particularly men. Neurodiverse people face an amplified version of a common human problem. This matters for positioning: the app addresses a genuine universal need, with particular depth and care for those who find it hardest.

The Dickins research also highlights that different people have fundamentally different models of what friendship looks like and how it is maintained. For activity-based or task-oriented people (a profile common in both neurotypical men and many neurodiverse people), "reaching out" may feel unnatural - but doing something together does not.

**App implications**
- The app's audience is broader than neurodiverse people - it addresses a near-universal problem. The open source positioning should reflect this.
- Contact suggestions should include activity-based options ("suggest doing something together") not just communication-based ones ("call them," "send a message"). For many users, shared activity *is* how they connect.
- The app should never assume that emotional conversation is the only valid form of connection. A walk, a game, watching something together - these are legitimate and research-supported ways of maintaining a relationship.
- The layer-placement questions should ask what kind of connection feels natural with this person, not just how often they talk.
- The gender dimension is worth noting: men as a demographic are particularly underserved by existing social infrastructure. The app can speak to this without making it the primary framing.

---

## Section 8: How to Deepen Relationships - Strategies for Moving Through Layers

The following papers provide the evidence base for the app's coaching feature: what actually works when someone wants to move a person from Layer 3 to Layer 2, or from Layer 2 to Layer 1.

---

### Paper 26
**Apostolou, M. (2024). Forging close friendships: Strategies for strengthening friendships.**
*Evolutionary Psychological Science.*

**What it found**
A study identifying 54 strategies people use to strengthen friendships, categorised into seven groups: increased time together, gift-giving, creating family ties (introducing to partners/family), emotional support during hard times, more frequent communication, showing trust (sharing personal information), and showing agreement (doing favours you wouldn't normally do).

People deepen relationships through several key strategies: encouraging more frequent interaction, giving thoughtful gifts based on their interests, creating family ties, providing emotional support during difficult times, engaging in frequent communication, showing trust by sharing personal information, and showing agreement by doing favours.

Personality affects which strategies feel natural: agreeable people gravitate toward support and communication; open people toward meaningful conversations and new activities; introverted people toward gift-giving. Age matters too - younger people focus on shared activities and trust-building; older people on communication and practical support.

**So what**
There is no single correct strategy for deepening a friendship - different approaches work for different people and different relationship types. The most effective coaching will be personalised to what feels natural for the user and appropriate to the specific relationship.

**App implications**
- The "how to deepen this relationship" coaching feature should offer a menu of strategy types, not a single prescription.
- Strategies should be categorised in the app by type: spend time together, communicate more, be there for them, show you know them, let them in. Users can choose what fits.
- The app should match suggested strategies to what the user already knows about the person (notes, relationship type, contact history).
- Personality-aware suggestions are a long-term feature: over time, the app could learn which types of suggestions the user actually acts on.

---

### Paper 27
**Hall, J.A. (2019). How many hours does it take to make a friend?**
*Journal of Social and Personal Relationships. Via Science of People summary.*

**What it found**
Research from the University of Kansas indicates it takes 40 to 60 hours to form a casual friendship and over 200 hours to reach best-friend status. These hours are most effective when spent outside of work. Switching social contexts - moving the relationship to a new environment, such as inviting a colleague to a weekend hike - deepens connection.

**So what**
Moving someone through the layers requires a meaningful investment of time, and that time is most effective in personal (non-transactional) settings. Proximity and shared context are the raw materials of closeness - not just emotional conversation.

**App implications**
- When a user sets a goal to "deepen" a relationship, the app should suggest context-shifting: "Have you spent time with them outside of [where you usually meet]?"
- The app should frame deepening a relationship as a cumulative investment over multiple interactions, not a single conversation.
- Realistic expectations matter: moving someone from Layer 3 to Layer 2 might take months of consistent contact, not weeks. The app should communicate this gently.
- For neurodiverse users specifically, the time investment framing is helpful - it normalises the fact that closeness takes time and removes pressure from any single interaction.

---

### Paper 28
**Altman & Taylor (1973). Social Penetration Theory.**
*Social Penetration: The Development of Interpersonal Relationships.*

**What it found**
Relationships deepen through self-disclosure that increases in two dimensions over time: breadth (more topics) before depth (more personal within topics). The "onion model" - relationships develop layer by layer, with surface topics giving way to progressively more personal ones as trust builds.

As a relationship develops, communication between partners increases in breadth first - partners add more topic areas - and eventually in depth, becoming less superficial and more intimate. Two people whose early friendship is based on a common interest in music will discover other things in common as they communicate, eventually confiding in each other and helping each other solve problems.

**So what**
Moving a relationship to a deeper layer is a gradual process of expanding both the range and the depth of what is shared. You cannot shortcut to depth - breadth must come first. This has direct implications for what the app should suggest at each stage of a relationship.

**App implications**
- Coaching suggestions should be calibrated to the current layer. Layer 4 → 3: suggest broadening topics (find new things in common). Layer 3 → 2: suggest going deeper (share something more personal). Layer 2 → 1: suggest mutual vulnerability and consistent showing up through difficulty.
- The app should not suggest deep emotional sharing with someone in an outer layer - this is inappropriate to the relationship stage and could backfire.
- The layer model and the social penetration model align naturally: moving inward through Dunbar's layers maps onto moving deeper through Altman & Taylor's disclosure dimensions.

---

### Paper 29
**Aron et al. (1997). The experimental generation of interpersonal closeness.**
*Personality and Social Psychology Bulletin. Via multiple subsequent studies.*

**What it found**
Gradually escalating self-disclosure between strangers generates measurable closeness - even in a single 45-minute structured conversation. The famous "36 Questions" study: pairs of strangers who answered increasingly personal questions felt significantly closer than pairs who engaged in small talk. Vulnerability, when met with responsiveness, is the fastest route to intimacy.

Experiments have shown that gradually escalating self-disclosure between strangers generates closeness. Emotional disclosures - as opposed to disclosures of facts - are considered most important for the development of intimacy. Willingness to disclose negative emotions predicts forming more relationships and establishing more intimacy in close relationships.

**So what**
Intimacy can be deliberately accelerated through structured vulnerability. The mechanism is not time alone - it is the quality of what is shared. This is the theoretical basis for conversation prompt features in the app.

**App implications**
- The app can offer conversation prompts calibrated to relationship depth - questions that are slightly more personal than where the relationship currently is, to gently advance it.
- Prompts should escalate gradually: surface questions for Layer 4→3 transitions, more personal prompts for 3→2, genuinely vulnerable prompts for 2→1.
- For neurodiverse users, explicit prompts reduce the cognitive load of "what do I say?" - the research suggests the content of the conversation matters more than the delivery.
- The AI feature could suggest a specific question to ask next time the user sees a particular person, based on what they already know about them.

---

### Paper 30
**ScienceDirect (1996 / ongoing). Self-disclosure and friendship decline.**
*Multiple studies reviewed in ScienceDirect Topics.*

**What it found**
When a friendship begins to deteriorate, the decline is reflected in self-disclosure: friends tend to avoid personal, intimate self-disclosure when their relationship is deteriorating. Disengaging friendships are characterised by less effective and less personal communication than growing friendships.

Self-disclosure is not a linear process - it is mutually transformative. Disclosure and the relationship change each other simultaneously. Declining disclosure is both a symptom and a cause of relationship drift.

**So what**
Reduced personal sharing is an early warning signal of a relationship moving outward through the layers. The app's quality tracking (connection score) may be capturing this signal implicitly - users who feel less connected will naturally share less, and the relationship will drift further.

**App implications**
- The "is this where you want it to be?" quality question is detecting the early signs of layer drift - this is more valuable than it might appear.
- When a user marks a relationship as "drifting" or rates connection score as low, the app should offer a gentle re-engagement suggestion before the relationship moves outward.
- The coaching flow for "reconnect" goal should acknowledge that re-establishing closeness after drift requires rebuilding the disclosure habit gradually - not trying to jump back to previous depth immediately.
- For neurodiverse users who have gone silent in a relationship (a common pattern), the app should normalise re-entry: "It's okay to reach out even after a gap. A simple message is enough to restart."

---

### Paper 31
**PMC (2023). How to Help Clients Make Friends.**
*PMC / clinical review*

**What it found**
Vulnerability is a vital component required for deepening connections. Self-compassion contributes to the ability to express vulnerability. Those with high self-compassion tend to have secure attachment styles and more conflict-resolution skills. Self-compassion meditation - focusing on self-kindness, common humanity, and mindfulness - is negatively associated with loneliness.

Fear of rejection and insecure attachment are the primary individual-level barriers to initiating and deepening friendships. Cognitive behavioural approaches (challenging assumptions that others won't like you) and behavioural activation (taking small actions regardless of how you feel) are the most evidence-based interventions.

**So what**
For many users - especially those with anxiety, autism, or low self-esteem - the barrier to deepening relationships is not knowing what to do, it is the fear of doing it. The app's coaching role extends to managing that fear, not just suggesting actions.

**App implications**
- Coaching suggestions should always be accompanied by low-stakes options - the smallest possible version of the action, to reduce the activation energy required.
- The check-in feature should include a question about how the user is feeling about a specific relationship before suggesting action - meeting them where they are emotionally.
- Framing matters: "Assume they want to hear from you" is a research-supported reframe that the app's AI can offer when users express hesitation about reaching out.
- The app should never suggest a large vulnerable disclosure as a first step - it should scaffold toward it gradually, consistent with social penetration theory.

---

## Summary: Master Design Implications Table

| Research Area | Key Finding | App Design Implication |
|---|---|---|
| Loneliness & mortality | Social isolation risk = smoking/obesity | Frame app as health tool, not productivity tool |
| Friend support effect size | Friends (r=−0.48) > family or partner for loneliness | Focus on chosen friendships as the primary target |
| Friendship threshold | 2–4 close friends sufficient for mental health benefit | Quality over quantity; don't gamify volume |
| Dunbar layers | Fractal social structure is universal and empirically robust | 5-layer model is the right organising framework |
| Social time budget | 40% of time goes to 5 people | Capacity is finite; budget model is theoretically grounded |
| Individual variation in Dunbar | Wide individual variation in energy allocation | Flexible, non-prescriptive layer placement |
| Executive function deficit (ADHD) | Failure to deploy skills, not lack of skills | Scaffolding tool, not coaching tool |
| Out of sight, out of mind | Absent people disappear from relational awareness | Home screen must surface people, not bury them |
| ADHD social QoL | Executive function gap directly reduces social quality of life | Relationship quality tracking is clinically meaningful |
| Social anxiety in autism (~50%) | Anticipatory anxiety prevents initiation | Low-commitment contact options; no urgency framing |
| Double empathy problem | Social difficulty is bidirectional, not autistic deficit | Neurodiversity-affirmative language throughout |
| Autistic social desire | Autistic people want connection; barrier is access not motivation | Never assume low motivation; assume high aspiration |
| Partner responsiveness | Feeling understood predicts relationship satisfaction | Quality tracking beyond contact frequency |
| Dyslexia & communication | Written communication is where dyslexic users struggle most | Minimise text input; quick-tap options everywhere |
| Co-occurrence of conditions | Many users have multiple neurodivergent profiles | Design for the most complex user |
| Structure as resilience | Structured approaches mediate emotional difficulties | Position app as part of user's personal system |
| Predictable routines | Stable routines are emotionally protective in neurodivergence | Regular check-in rhythm has therapeutic value beyond output |
| Deficit language harms | Pathologising framing reinforces shame | Audit all copy; celebrate connection, never punish lapses |
| Male friendship decline | Men's friendships erode when structural proximity disappears | Activity-based contact suggestions; not just communication prompts |
| Broader friendship maintenance | Regular maintenance is required; not automatic for anyone | App addresses a near-universal problem; ND users are not alone |
| Time to friendship depth | 40–60hrs casual; 200hrs+ close friend | Frame deepening as cumulative investment, not single events |
| Social penetration (breadth→depth) | Relationships deepen through breadth first, then depth | Coaching suggestions calibrated to current layer depth |
| Escalating self-disclosure | Structured vulnerability accelerates intimacy | Conversation prompts calibrated to relationship stage |
| Disclosure decline = relationship drift | Reduced sharing signals and causes layer drift | Quality score detects drift early; gentle re-engagement before loss |
| Fear of rejection as barrier | Self-compassion and small actions reduce initiation barrier | Always offer smallest possible action; "assume they want to hear from you" |

---

## Section 9: When Relationships Don't Work - Letting Go, Layer Drift, and Guilt

---

### Paper 32
**Holt-Lunstad, J. & Uchino, B.N. (2019). Social Ambivalence and Disease (SAD): A Theoretical Model.**
*Perspectives on Psychological Science, 14(6), 941–966.*

**What it found**
Not all social relationships are positive - and relationships characterised by both positivity and negativity (ambivalent relationships) are measurably worse for health than even primarily negative ones. Ambivalent relationships are associated with higher depression, greater cardiovascular reactivity to stress, higher ambulatory blood pressure in daily life, and - critically - shorter telomere length, a marker of cellular ageing and mortality risk.

A 2007 companion study (Annals of Behavioral Medicine) found that participants exhibited the greatest levels of systolic blood pressure reactivity when discussing a negative event with an ambivalent friend, compared to a supportive one - even higher than with a clearly negative friend. The uncertainty of an ambivalent relationship is uniquely physiologically costly.

**So what**
Keeping a draining, ambivalent relationship in an inner layer is not a neutral act - it is actively harmful to health. The research makes a clear case that releasing a harmful relationship creates space for healthier ones, and that the health cost of maintaining an ambivalent relationship is measurable and significant.

**App implications**
- The app has a strong, evidence-based rationale for helping users evaluate whether relationships are worth maintaining - this is not a feature about being unkind, it is about protecting the user's health.
- The quality tracking feature (connection score + "is this where you want it to be?") is detecting ambivalence - the most health-damaging relationship category.
- When a user consistently rates a relationship as low quality and not where they want it to be, the app should gently surface this pattern rather than just continuing to nudge contact.
- The framing should be: "Some relationships cost more than they give. It's okay to notice that."

---

### Paper 33
**Bushman, B. & Holt-Lunstad, J. (2009). Understanding social relationship maintenance: Why we don't end those frustrating friendships.**
*Journal of Social and Clinical Psychology, 28, 749–778.*

**What it found**
Investment theory explains why people stay in frustrating friendships long past the point of benefit: the more time and emotional energy invested in a relationship, the harder it is to let go - even when the person knows it is no longer working. Loyalty norms, sunk cost bias, and fear of being alone compound this effect and keep people in relationships that actively erode self-esteem.

**So what**
The psychological barriers to ending a friendship are not rational - they are driven by cognitive biases and social conditioning. People need explicit permission and a reframe to overcome these barriers. Simply recognising a relationship as harmful is not sufficient to act on that knowledge.

**App implications**
- The app's role is partly to make the implicit explicit - surfacing patterns the user may be ignoring due to sunk cost bias.
- The "not where I want it to be" response should trigger a gentle reflection flow, not just a note in the database.
- The app should explicitly normalise ending or stepping back from friendships: "Not every relationship is meant to last forever. Letting one go can be an act of self-care."
- For neurodiverse users especially, who may have invested enormous effort in maintaining a relationship through masking and people-pleasing, acknowledging the cost of that investment is important.

---

### Paper 34
**PMC (2021). Relationship dissolution in friendships of emerging adults.**
*PMC (N=181)*

**What it found**
Three distinct friendship dissolution strategies exist: completely ending the friendship, distancing (gradual reduction of contact), and compartmentalising (limiting certain topics or contexts). Distancing is the most commonly used strategy and the least definitive - it can be a precursor to full dissolution or a way of preserving a limited version of the relationship.

Ending a toxic or harmful friendship may improve wellbeing, while intentionally ending a good friendship may increase vulnerability to poor outcomes. The key variable is the quality of what is being released.

**So what**
There is a spectrum of relationship endings - from full dissolution to quiet outward layer movement - and the appropriate choice depends on the nature of the relationship. The app should support all three modes without forcing users to make an all-or-nothing decision.

**App implications**
- The app's layer system naturally accommodates distancing: moving someone from Layer 2 to Layer 4 is a form of compartmentalising without deletion.
- Full removal should always be an option, but it should never be the default or first suggestion.
- The dissolution flow should offer a spectrum: "See them less often" → "Move to a more distant layer" → "Let this relationship go" - each with appropriate framing.
- The app should not pressure the user toward any particular resolution - it should surface the pattern and offer options.

---

### Paper 35
**Pavlopoulou et al. (2025). Upsetting experiences in the lives of neurodivergent young people.**
*JCPP Advances / Wiley (N=57 neurodivergent adolescents)*

**What it found**
Masking - hiding one's true feelings and reactions to conform to social expectations - takes two distinct forms in neurodivergent people. For autistic people, masking typically involves hiding negative emotions to protect others from their intensity. For ADHD, masking usually involves suppressing emotional upset to protect oneself from conflict or consequences. Both forms come at a significant psychological cost.

Upsetting social experiences for autistic participants often related to feelings of "not belonging" and alienation. For ADHD participants, they were more often triggered by a sense of injustice or external agents imposing control. Those with both diagnoses reported these experiences more intensely.

**So what**
Neurodiverse people often stay in difficult relationships far longer than is healthy precisely because they are skilled at masking their discomfort. The internal experience of a relationship may be far more negative than the external behaviour suggests. People-pleasing and conflict avoidance - common features of neurodiverse social adaptation - make it harder to act on the knowledge that a relationship is not working.

**App implications**
- Check-in questions should explicitly ask how relationships *feel*, not just whether contact has happened - the internal experience is the data that matters.
- The app should normalise internal negative feelings about relationships: "It's okay to notice that a relationship feels draining. That's useful information."
- For autistic users especially, the app should create a safe space to acknowledge feelings they may be hiding from the other person and from themselves.
- The "is this where you want it to be?" question is doing important work - it gives users permission to acknowledge dissatisfaction they may not be voicing anywhere else.

---

### Paper 36
**Kemp, J. (2024). Working with Neurodivergent Adults: People-pleasing and masking behaviours.**
*Psychwire clinical Q&A / ACT-based clinical practice*

**What it found**
Neurodiverse people who have experienced repeated rejection and exclusion develop people-pleasing and masking behaviours as social survival strategies. These function to keep the person safe - but over time they prevent authentic connection and contribute to autistic and ADHD burnout. The person learns to prioritise others' comfort over their own needs, making it extremely difficult to set boundaries or end relationships even when those relationships are harmful.

Neurodivergent burnout - characterised by chronic overwhelm, exhaustion, loss of skills, and heightened sensitivity - is directly linked to the sustained effort of masking and people-pleasing in social relationships. Recovery requires doing less, not more.

**So what**
For many neurodiverse users, staying in an unhealthy relationship is not a free choice - it is the product of years of conditioned people-pleasing. The app must actively counteract this by validating the user's own experience of the relationship as legitimate data, and by making self-protective choices feel permissible rather than shameful.

**App implications**
- The app should explicitly frame relationship self-assessment as self-care, not selfishness: "Taking stock of how your relationships feel is how you protect your wellbeing."
- When suggesting that a user might consider stepping back from a relationship, the app should acknowledge that this may feel uncomfortable or guilt-inducing, and validate that response.
- The AI check-in feature should be capable of gently naming people-pleasing patterns if they surface: "It sounds like this relationship takes a lot from you. What do you get back?"
- The app should never reinforce the idea that the user should try harder with a draining relationship before considering stepping back - that path leads to burnout.

---

### Paper 37
**PMC (2023). Experiences of adults with ADHD in interpersonal relationships and online communities.**
*PMC qualitative study*

**What it found**
Adults with ADHD reported finding it significantly easier to build and maintain meaningful connections with other neurodivergent people, because they could communicate more directly and authentically without masking. Learning vocabulary for their own experiences - terms like "rejection sensitivity dysphoria," "executive dysfunction," and "neurodivergent" - was transformative for self-image and helped participants stop interpreting their difficulties as personal failings.

Participants reported that validation and normalisation of their symptoms helped them improve their self-image and shifted their understanding from "horrible personality flaw" to manageable aspect of a neurotype.

**So what**
Naming and normalising is itself therapeutic. The simple act of recognising that a relationship pattern (e.g. people-pleasing, guilt about stepping back, difficulty ending a friendship) is connected to neurodivergence rather than personal failure is a meaningful and health-supporting reframe.

**App implications**
- The app should gently provide psychoeducation at relevant moments: when a user is struggling with guilt about not maintaining a relationship, a brief contextualising note can help ("Many neurodiverse people find it hard to step back from friendships even when they're not working - this is a very common experience, not a character flaw").
- The check-in AI response should validate and normalise, not prescribe - especially around difficult relationship decisions.
- The language of the app throughout should help users build a vocabulary for their social experience, not just track it.

---

### Design Framework: The Relationship Health Spectrum

Drawing on this research, the app should conceptualise relationships along a health spectrum and respond accordingly:

| Relationship State | Indicators | App Response |
|---|---|---|
| **Thriving** | High connection score, contact on cadence, "yes, this is where I want it" | Celebrate; surface what's working |
| **Drifting** | Reducing connection score, contact falling behind | Gentle nudge; ask what's getting in the way |
| **Ambivalent** | Low connection score, mixed feelings, "not where I want it" but no clear goal | Surface the pattern; offer reflection prompts |
| **Draining** | User notes exhaustion or distress; repeated low quality scores | Validate; ask what the user needs; offer step-back options |
| **Ready to release** | User wants to let go but feels guilt or inertia | Normalise; provide reframe; offer graduated options |
| **Dormant** | No contact, no quality data, user unsure | Gentle check-in: "Is this still a relationship you want to maintain?" |

The app should move through this framework proactively - not waiting for the user to raise it - but always gently and with the user's autonomy firmly in place.

---

## Section 10: Imperfect Relationships - Realistic Expectations, Repair, and Forgiveness

A critical counterbalance to Section 9. The research is unambiguous: all close relationships involve friction, conflict, and periods of distance. The goal is not perfect relationships - it is resilient ones. The app must actively hold this truth alongside the ability to step back from harmful relationships.

---

### Paper 38
**Gottman, J. (1994, 1999). The Magic Ratio and relationship stability.**
*University of Washington Love Lab / The Marriage Clinic.*

**What it found**
Decades of observational research on couples found that the key predictor of relationship stability is not the absence of conflict - it is the ratio of positive to negative interactions. Stable, happy relationships maintain approximately 5 positive interactions for every 1 negative interaction during conflict. Outside of conflict, the ratio in healthy relationships is even higher - around 20:1. Gottman could predict with 90%+ accuracy whether couples would divorce, based on this ratio observed in a 15-minute conversation.

The "Four Horsemen" - criticism, contempt, defensiveness, and stonewalling - are the most destructive patterns. Contempt is the single strongest predictor of relationship breakdown.

While developed for romantic relationships, subsequent research confirmed the 5:1 ratio applies to friendships, work teams, and parent-child relationships alike.

**So what**
Conflict and negative interactions are inevitable and normal in any real relationship. What determines whether a relationship thrives is not their absence but the volume of positive connection that surrounds them. A relationship with occasional friction and high baseline warmth is healthier than one with no conflict and low warmth.

**App implications**
- The app should never interpret a single low quality rating or a difficult period as a signal to step back from a relationship - context matters.
- The connection score should be tracked over time, not interpreted in isolation. A dip in one check-in means nothing; a sustained downward trend means something.
- The app could help users notice the positive - prompting them to record good moments alongside difficulties, building an accurate picture of the overall ratio.
- "What's something good about this relationship?" is a more useful check-in question than "how is this relationship going?" in isolation.
- Repair attempts - humour, warmth, apology, a bid for connection - should be surfaced as concrete coaching suggestions when a relationship is in a difficult patch.

---

### Paper 39
**Franco, M.G. (2022). Platonic: How the Science of Attachment Can Help You Make - and Keep - Friends.**
*Via drmarisagfranco.com / Psychology Today*

**What it found**
Research finds that people who engage in healthy conflict have greater wellbeing, are more popular, and have less depression, anxiety, and loneliness. When people avoid conflict, they often choose to distance themselves from the friendship instead - which damages relationships more than the conflict would have.

Most people suppress conflict to preserve the relationship, but suppressed conflict creates distance and resentment. The problem is usually not that people raise conflict, but how they do it - adversarially rather than collaboratively.

**So what**
Avoiding difficulty in a friendship is not neutral - it is a slow form of relationship dissolution. The ability to navigate friction is a relationship skill, and one that is particularly important for neurodiverse people who may default to conflict avoidance or masking.

**App implications**
- The app should gently normalise the existence of friction in valued relationships: "Every close relationship has difficult moments. That's not a sign something is wrong."
- When a user marks a relationship as "difficult" or "distant," the app should first ask whether something specific has happened, before assuming the relationship is declining.
- Coaching for Layer 1 and 2 relationships should include guidance on gentle repair - how to re-open after a difficult period - not just encouragement to maintain contact cadence.
- For neurodiverse users who tend to go silent after conflict (a common pattern), the app should offer very low-barrier re-entry options: "A small message acknowledging you've been distant is enough."

---

### Paper 40
**In-Mind (2025). Turning disagreements into opportunities - research on constructive conflict.**
*Drawing on Gottman Institute, Rogerian communication, and couples research.*

**What it found**
What defines a strong relationship is not the absence of conflict but the presence of repair. Healthy relationships thrive on trust - the belief that even in the face of disagreements, the other person has your best interests at heart. Conflict, when managed constructively, deepens connection rather than damaging it. Misunderstandings are inevitable but don't have to escalate; asking "what did you hear me say?" prevents many conflicts from spiralling.

A lack of open disagreement can sometimes mean that one partner consistently suppresses their own needs - which fosters disconnection and emotional distance over time.

**So what**
Repair is a learnable skill. The ability to repair after conflict is more predictive of relationship health than the ability to avoid conflict. This is directly relevant to neurodiverse people who may struggle with conflict initiation or resolution due to anxiety, emotional dysregulation, or difficulty reading implicit social cues.

**App implications**
- The app should treat "repair after difficulty" as a distinct coaching mode, not just a variant of "reach out."
- Specific repair prompts could include: acknowledging the gap ("I know we haven't spoken properly since X"), expressing care without requiring resolution ("I've been thinking about you"), or a shared activity suggestion that sidesteps the need for a direct conversation.
- For autistic users especially, explicit scripts or prompts for repair can remove the enormous cognitive and anxiety barrier of "what do I even say?"
- The check-in feature should distinguish between "this relationship is draining" and "this relationship just had a difficult moment" - these require different responses.

---

### Paper 41
**Research on friendship forgiveness and closeness.**
*McCullough et al. (1997). Interpersonal Forgiving in Close Relationships. ScienceDirect / Boon et al. (2022).*

**What it found**
Forgiveness is the primary mechanism by which close relationships survive and recover from transgressions. Empathy is the key driver of forgiveness - the ability to understand the offender's perspective makes forgiveness significantly more likely. Closeness itself promotes forgiveness: people are more inclined to forgive those they are close to, and closer relationships promote "attributional generosity" - interpreting negative behaviour in light of circumstances rather than character.

Research on forgiveness in friendships specifically finds that conflict is not the main regulating or terminating factor in adult friendships - people stay in relationships despite conflict when commitment and trust are present.

**So what**
The ability to forgive - and to receive forgiveness - is a relationship maintenance skill that directly predicts whether a close friendship survives difficulties. Forgiveness reduces stress, depression, and anxiety for the forgiver, independent of whether the relationship continues. It is an act of self-care as much as relational repair.

**App implications**
- The app should frame forgiveness explicitly as both a relationship skill and a self-care practice - not as something owed to the other person.
- When a user reports a relationship rupture, the app's AI should not jump to dissolution - it should first explore whether the user wants to repair, and if so, offer concrete steps.
- Empathy prompts can facilitate forgiveness: "What might have been going on for them when that happened?" is a research-supported reframe the app can offer.
- For neurodiverse users who may struggle with perspective-taking (particularly in autism), explicit prompts toward empathy are not condescending - they are cognitively helpful scaffolding.
- The app should never moralise about forgiveness - it should present it as an option with clear personal benefits, not an obligation.

---

### Paper 42
**ScienceDirect (2025). The influence of relationship closeness on interpersonal forgiveness.**
*(EEG study, N=36)*

**What it found**
The closer the relationship, the more naturally and quickly forgiveness is extended - even at a neurological level. Closeness promotes "attributional generosity" - people automatically focus less on the personal shortcomings of those they are close to and more on extenuating circumstances when interpreting negative behaviour.

This effect is consistent across cultures and relationship types and is partially automatic - forgiveness in close relationships requires less conscious effort than forgiveness of strangers.

**So what**
Investing in closeness is itself a protective factor against relationship rupture. The more genuinely close a relationship becomes (higher in Dunbar's layers), the more naturally it can absorb friction without dissolving. This is a further argument for the app's focus on deepening key relationships - closeness is not just emotionally rewarding, it is structurally protective.

**App implications**
- Deepening a relationship is not just about personal reward - it builds structural resilience into the relationship. This is worth communicating to users.
- The layer system should implicitly convey this: inner layer relationships are not just more important, they are more robust to difficulty.
- When a user is considering stepping back from an inner layer relationship after a conflict, the app should gently note: "Close relationships tend to recover from difficulty more easily than distant ones - is this worth trying to repair first?"

---

### Design Framework: The Relationship Reality Model

The app should hold a nuanced, research-grounded model of relationship health that avoids two failure modes:

**Failure mode 1: Toxic positivity** - assuming all relationships can and should be maintained, suppressing the user's legitimate need to step back from harmful ones.

**Failure mode 2: Premature dissolution** - interpreting normal friction, distance, or difficult patches as evidence that a relationship should be ended.

The research supports a middle path:

| Relationship State | Research Signal | App Response |
|---|---|---|
| **Friction / difficult patch** | Normal; all close relationships experience this | Normalise; offer repair prompts; don't escalate |
| **Sustained low quality with desire to improve** | Gottman: ratio is repairable if positive baseline exists | Offer concrete repair strategies; affirm the relationship's value |
| **Conflict after closeness** | Forgiveness research: close relationships absorb conflict better | Prompt empathy and repair before suggesting distance |
| **Sustained ambivalence with no desire to improve** | Holt-Lunstad: ambivalence is the most health-costly state | Gently surface the pattern; offer graduated step-back options |
| **Consistently draining with no positive baseline** | Investment theory + toxicity research: cost exceeds benefit | Validate; normalise stepping back; frame as self-care |

The key variable throughout is **the user's own goal for the relationship** - the app's role is to reflect patterns back accurately and offer appropriate support for whatever the user decides, not to make the decision for them.

---

*Document version 1.3 - compiled for Hyphae open source project.*
*Research current as of April 2026.*
