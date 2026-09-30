# How to Do Synthetic Research

Author: [Roxanne Mustafa](mailto:rmustafa@paloaltonetworks.com)

Synthetic research uses AI to simulate the user research process — creating fictional but realistic users, running mock interviews, and generating behavioral data — without recruiting real participants. This is useful for early-stage design exploration, pressure-testing assumptions, or moving quickly before live research is possible.

---

## What Is Synthetic Research?

Traditional user research requires recruiting real people, scheduling sessions, and waiting for results. Synthetic research replaces (or supplements) this by using AI to:

1. **Create synthetic users** — detailed fictional personas grounded in real demographic and behavioral patterns  
2. **Run simulated interviews** — prompt AI to respond as those users would  
3. **Synthesize data** — generate or augment datasets that reflect realistic user behavior

>   
> **Important:** Synthetic research is a starting point, not a replacement for real user research. Validate synthetic findings with real users before making major product decisions.

---

## Part 1: Creating Synthetic Users (Personas)

A synthetic user is a detailed, AI-generated persona that represents a realistic segment of your target audience.

### Step 1: Define your research goals \[add research plan\]

Before creating personas, answer:

- What product or feature are you designing for?  
- What behaviors or attitudes do you want to understand?  
- What user segments matter most right now?

### Step 2: Choose your persona dimensions

For each synthetic user, define the following attributes:

| Dimension | What to include |
| :---- | :---- |
| **Demographics** | Age, location, occupation, education, income range |
| **Tech comfort** | Device usage, apps they use daily, comfort with new tech |
| **Goals** | What they are trying to accomplish in your product space |
| **Pain points** | What frustrates them about current solutions |
| **Behaviors** | How they typically search for information, make decisions, ask for help |
| **Context** | When and where they use this type of product (commute, desk, phone, etc.) |

### Step 3: Generate the persona using Claude

Use a prompt like this:

```
You are a UX researcher creating a synthetic user persona for [product/feature].

Create a detailed persona for a [demographic description, e.g. "35-year-old project manager at a mid-size tech company"].

Include:
- Name, age, location, job title
- Daily routine and tech usage
- Goals related to [domain]
- Pain points with current solutions
- Quotes that capture how they think and talk
- A short backstory (2-3 sentences)

Make this persona feel realistic and specific, not generic.
```

### Step 4: Create multiple personas

Aim for 3–5 synthetic users that represent different segments. For example:

- A power user vs. a casual user  
- A tech-savvy person vs. someone less comfortable with technology  
- Different life stages or job roles

Save each persona as its own file in `/personas/` using the naming format: `persona-[name]-[role].md`

---

## Part 2: Running Simulated Interviews

Once you have your synthetic users, you can "interview" them by prompting Claude to respond as that persona.

### Step 1: Set up the persona context

Start your Claude session with a system prompt like:

```
You are [Persona Name], a [role/description]. 

Here is your background:
[Paste the full persona description]

I am a UX researcher interviewing you. Respond authentically as this person would — including their hesitations, vocabulary, and level of technical knowledge. Don't be overly helpful or articulate. React the way a real person would in conversation.
```

### Step 2: Run the interview

Ask open-ended questions as you would in a real research session:

- "Walk me through the last time you tried to \[task\]."  
- "What's the most frustrating part of how you currently handle \[problem\]?"  
- "If this tool disappeared tomorrow, what would you do instead?"  
- "What would make you trust something like this?"  
- "Can you show me how you'd expect this to work?"

### Step 3: Probe and follow up

Treat it like a real interview. Follow up on interesting answers:

- "Can you say more about that?"  
- "What do you mean by \[term they used\]?"  
- "How often does that happen?"

### Step 4: Document findings

After each simulated interview, write up:

- 3–5 key quotes  
- Main themes that emerged  
- Surprises or things that challenged your assumptions  
- Open questions to validate with real users

Save interview notes in `/research/` as: `synthetic-interview-[persona-name]-[date].md`

---

## Part 3: Synthesizing Data

Data synthesis means generating realistic datasets or response sets that simulate what real users might produce — useful for testing designs, populating prototypes, or modeling behavior patterns.

### When to use synthetic data

- You need sample data to populate a UI prototype (e.g., realistic user names, tasks, messages)  
- You want to model how users might respond to a survey before running it live  
- You need edge cases to test your product (unusual inputs, error states, accessibility needs)

### Step 1: Define what data you need

Be specific. For example:

- 50 realistic task names a project manager would create  
- 20 plausible support tickets from small business owners  
- Survey responses from 10 different user types on a scale of 1–5 with written rationale

### Step 2: Generate with Claude

Example prompt for survey simulation:

```
Simulate responses to the following survey from 5 different types of users: [list your persona types].

Survey question: [your question]

For each user type, give:
- A 1–5 rating
- A 1–2 sentence written response in their voice
- One follow-up question they might ask

Keep responses realistic — not everyone will love the product.
```

Example prompt for prototype data:

```
Generate 20 realistic task names that a marketing manager at a B2B SaaS company would create in a project management tool. Vary the length, style, and specificity. Some should be vague, some very detailed. Format as a simple list.
```

### Step 3: Review and clean

AI-generated data can be too uniform or idealized. Review it and:

- Remove responses that sound too polished or generic  
- Add variation in tone and detail  
- Flag any patterns that seem unrealistic to validate later

---

## Full Workflow Summary

```
1. Define research goals
       ↓
2. Create 3–5 synthetic personas (Part 1)
       ↓
3. Run simulated interviews with each persona (Part 2)
       ↓
4. Synthesize supporting data as needed (Part 3)
       ↓
5. Identify themes and open questions
       ↓
6. Validate key findings with real users
```

---

## Tips for Better Synthetic Research

- **Be specific in your prompts.** Generic prompts produce generic personas. The more context you give, the more useful the output.  
- **Push back on AI optimism.** AI tends to make users sound reasonable and agreeable. Explicitly ask for reluctance, confusion, or skepticism.  
- **Run multiple iterations.** Run the same interview question with different personas to surface range.  
- **Use synthetic research to write your real research script.** The themes and surprises from synthetic sessions often reveal better questions for real interviews.  
- **Label everything clearly.** Always mark files as synthetic so no one mistakes them for real user data.

---

## File Naming Conventions

| File type | Location | Format |
| :---- | :---- | :---- |
| Persona profiles | `/personas/` | `persona-[firstname]-[role].md` |
| Interview notes | `/research/` | `synthetic-interview-[name]-YYYY-MM-DD.md` |
| Synthesized data | `/research/` | `synthetic-data-[topic]-YYYY-MM-DD.md` |
| Prompts used | `/prompts/` | `prompt-[type]-[purpose].md` |

---

---

## Integration Hub persona set (XCOR)

For Integration Hub research, use the three personas in `/personas/` and the workflow map in [integration-hub-personas.md](integration-hub-personas.md):

| Persona | Role | Primary workflows |
| :---- | :---- | :---- |
| **Priya Sharma** | Platform Engineer (**primary**) | Flow 1 (collector install), Flow 3 (server-side config) |
| **Marcus** | Advanced SRE | Flow 2 (troubleshoot warning health) |
| **Alex Rivera** | Developer Lead | Flow 1 (discover telemetry/dashboards), Flow 2 (escalation) |

*Last updated: July 2026*  
