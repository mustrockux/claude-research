# Marcus — Advanced SRE

## Demographics

| Attribute | Detail |
| :---- | :---- |
| **Age** | Early 40s |
| **Location** | Big tech city |
| **Occupation** | Advanced SRE, Central Observability team |
| **Education** | High |
| **Income range** | High |

## Tech Comfort

- **Level:** High
- **Device usage:** Very high — uses AI day to day, but skeptical of AI in their own systems
- **Daily tools:** Enterprise observability stack, incident management, automation tooling, Datadog (legacy), Terraform (consumer)
- **Comfort with new tech:** Very comfortable, but applies a critical lens before adopting anything in production

## Responsibilities

- Maintain observability for production services
- Respond to incidents and drive remediation
- Optimize monitoring costs and signal-to-noise ratio
- Mentor junior engineers and define SLOs
- Partner with Platform (Priya) on integration health standards — does not own collector GitOps

## Integration Hub needs

| Priority | Need |
| :---- | :---- |
| **P0** | Quick access to **integration health status** — at-a-glance, across all installed integrations |
| **P1** | Clear **troubleshooting guidance** when integrations break |
| **P1** | Access to **pre-built dashboards** without custom PromQL or deep domain expertise |
| **P2** | **License consumption** visibility per integration |
| **P2** | **Control rule recommendations** to optimize costs |

## Primary workflows

| Workflow | Role |
| :---- | :---- |
| **Flow 2:** Troubleshoot "Installed" integrations with **Warning** health status | **Primary owner** — diagnoses missing data, auth failures, drop rules |
| **Flow 1:** Discover and install collector integration | Secondary — validates health after Platform rolls out config |
| **Flow 3:** Configure server-side cloud/API integration | Secondary — reviews health; Priya owns setup |

## Goals

- Understand their system deeply and identify root causes of problems
- Proactively remediate issues before they escalate
- Set up highly business-critical control functions and budgeting
- Mentor junior developers on the Central Observability team
- Help create and maintain company SLOs

## Pain Points

- Remediation takes too long
- Too much noise in the system — hard to find actionable signals
- Platform UX is cumbersome and slows down investigation
- Observability costs are too high
- Integration status vocabulary is ambiguous — "Installed" vs "Missing Data" vs "Misconfigured" requires PRD knowledge

## Frustrations with Current Solutions

- Dense interfaces with lots of noise and not enough signal to act on
- Tools that surface data without helping prioritize what matters
- Integration Hub shows marketing copy when he needs named health checks (`mysql.uptime` missing)

## Behaviors

- Impatient — expects fast paths to answers
- Skeptical, but carries deep enterprise tribal knowledge and SRE expertise
- Opens Hub during incidents to answer "is monitoring working?" before diving into app traces
- Escalation path for Alex; pairs with Priya on fleet-wide integration failures
- Typically searches for root cause first, then escalates or delegates remediation

## Context

- **Primary environment:** Desktop, multiple screens — always at desk unless paged
- **On-call:** Mobile when receiving pages, but investigation happens back at the workstation
- **Usage pattern:** Deep, focused sessions during incidents and proactive system reviews

## Quotes

> "I don't need more dashboards — I need to know what's actually broken and why."

> "If I can't get from alert to root cause in five minutes, the tool is failing me."

> "Installed *how*? One GCP project or twelve? Which service account?"

## Backstory

Marcus has spent over a decade in site reliability, rising from on-call engineer to a senior role on the Central Observability team at a large tech company. He's the person leadership calls when something critical is on fire — and the person junior engineers like Alex come to when they can't make sense of a noisy alert.

He built much of the team's SLO framework and obsesses over signal-to-noise ratio. During the Datadog migration, he doesn't own how integrations get *installed* — that's Priya's GitOps world — but he's accountable for whether they're *healthy*. When Alex gets paged and can't tell if Redis is monitored, Marcus ends up in the thread. Integration Hub's job for Marcus is to make Flow 2 fast: yellow warning on a tile → named missing metric → troubleshooting steps → link to control rules or collector config — without reading a PRD.
