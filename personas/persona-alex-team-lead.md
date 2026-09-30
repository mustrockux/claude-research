# Alex Rivera — Developer Lead

## Demographics

| Attribute | Detail |
| :---- | :---- |
| **Age** | Early 30s |
| **Location** | Big tech city |
| **Occupation** | Software Engineer, Developer Lead |
| **Education** | Bachelor's in Computer Science |
| **Income range** | Mid-to-high |
| **Tenure at org** | ~6 months |

## Tech Comfort

- **Level:** Moderate-to-high for observability concepts; lower for this specific platform and org's systems
- **O11y knowledge:** Solid — understands metrics, traces, logs, and alerting patterns from prior roles (Datadog, OpenTelemetry at last startup)
- **Platform familiarity:** New to the company's XCOR stack; still learning where things live and how teams name metrics
- **System knowledge:** Limited tribal knowledge — doesn't yet know which services are fragile, who owns what, or which alerts are noisy vs. real
- **Power user status:** Not a power user — uses the basics, follows runbooks, and looks for guided paths rather than building custom workflows

## Responsibilities

- Troubleshoot issues and **monitor the applications they build**
- First-line on-call for their team's services
- Coordinate with Platform (Priya) when new telemetry is needed; escalate integration health questions to Marcus
- Does **not** own collector fleet, Terraform modules, or server-side connect accounts

## Integration Hub needs

| Priority | Need |
| :---- | :---- |
| **P0** | Tell me **what telemetry is available** from the integration I'm using |
| **P0** | **Datadog → XCOR metric mapping** (rosetta stone) for migrations and debugging |
| **P0** | **XCOR dashboards** available as a starting point to understand the software or infrastructure I'm using |
| **P1** | Plain-language integration health for *my* services — not the whole platform catalog |

## Primary workflows

| Workflow | Role |
| :---- | :---- |
| **Flow 1:** Discover and install a collector integration (new integration) | Participant — requests setup via Platform or guided intake; rarely merges collector YAML |
| **Flow 2:** Troubleshoot "Installed" integrations with **Warning** health status | Secondary — first to notice; escalates to Marcus or Platform |
| **Flow 3:** Configure server-side cloud/API integration | Rarely — files request with Priya's team |

## Goals

- Resolve incidents independently without escalating to Marcus or senior SREs
- Keep owned services healthy and meet on-call expectations for their team
- Build credibility as a new lead by handling pages confidently
- Learn the org's systems, service dependencies, and escalation paths quickly
- Understand what metrics and dashboards exist for Redis, Postgres, K8s — without writing PromQL

## Pain Points

- Gets paged for services they don't fully understand yet
- Runbooks are incomplete or assume knowledge they don't have
- Hard to tell whether an alert is a real incident or historical noise
- Datadog metric names burned into muscle memory — XCOR names feel foreign
- Afraid of escalating too early or too late
- YAML-first setup flows assume platform engineering skills they don't use daily

## Frustrations with Current Solutions

- Too many views and not enough "start here" guidance during an incident
- Unclear how current alerts map to services they own
- Documentation is scattered; tribal knowledge lives in people's heads
- Tools built for power users like Marcus and Priya, not for someone learning the landscape
- Telemetry catalog buried in tabs they don't know to open

## Behaviors

- First responder on the team — most likely to answer a page
- Tries to resolve before escalating; will grind through a problem rather than ask for help
- Relies on runbooks, Slack searches, and asking teammates in threads
- Uses Integration Hub to browse **what's available** and **install OOTB dashboards** — not to author Terraform
- Cautious decision-maker — double-checks before taking destructive actions
- Reports up to Marcus; requests integration work through Priya's platform queue

## Context

- **Primary environment:** Desktop during work hours; laptop when paged off-hours
- **On-call:** Frequently the first line — phone alerts at night and on weekends
- **Usage pattern:** Reactive, incident-driven — opens Hub when something breaks or when onboarding a new dependency
- **Information seeking:** Slack → runbook → Hub search → (last resort) page Marcus

## Quotes

> "I know observability — I just don't know *this* observability yet."

> "What did `aws.ec2.cpuutilization` become in XCOR? I still think in Datadog names."

> "Just show me a dashboard so I can tell if Redis is healthy without learning twenty metric names."

## Backstory

Alex joined the company six months ago after three years as a backend engineer at a smaller startup, where they owned monitoring end-to-end with OpenTelemetry and a simple Datadog agent setup. The promotion to developer lead came quickly — they're capable and eager — but the scale here is different. They now own several services and an on-call rotation for a team of four.

Alex understands o11y principles: flame graphs, traces, decent alerts. What they lack is organizational context and **vocabulary translation** — which XCOR metrics correspond to the Datadog names they still mutter during incidents, and which pre-built dashboards actually help them understand Redis or Kubernetes without a week of study.

Integration Hub's job for Alex is education and self-service within guardrails: telemetry catalog, rosetta stone, one-click OOTB dashboards, and health status scoped to *their* services. They won't export Terraform — that's Priya. They won't define health check semantics — that's Marcus. They need to answer: "What can this integration tell me, what do I call it in XCOR, and where's the dashboard to start?"
