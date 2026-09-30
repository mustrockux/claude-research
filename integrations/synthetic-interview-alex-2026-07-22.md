# Synthetic Interview: Alex Rivera (Developer Lead)

**Date:** 2026-07-22  
**Duration:** ~40 min (simulated)  
**Interviewer:** UX Research  
**Topic:** Telemetry discovery, Datadog migration, dashboards, on-call  
**Product context:** XCOR Integration Hub (MVP)  
**Persona source:** `research/personas/persona-alex-team-lead.md`

> ⚠️ **Synthetic research** — simulated session for design exploration. Not real user data.

---

## Main tasks (1–5)

Tasks Alex is likely to perform in Integration Hub:

1. **Discover what telemetry** an integration (e.g. Redis, Kubernetes) provides before asking Platform to enable it  
2. **Look up Datadog → XCOR metric names** during an incident or migration  
3. **Install OOTB dashboards** to learn a system they don't own deeply (e.g. managed Redis)  
4. **Check whether their app's integration is healthy** when paged — scoped to services they own  
5. **Request a new integration** for a service via guided intake (not author collector YAML)  

### Integration Hub needs

| Priority | Need |
|----------|------|
| **P0** | What telemetry is available from the integration I'm using |
| **P0** | Datadog → XCOR metric mapping (rosetta stone) |
| **P0** | XCOR dashboards as a starting point |

### Primary workflows

**Flow 1** (discover/install — participant) · **Flow 2** (first to notice warnings)

---

## Session transcript

**UXR:** Alex, thanks for joining. I want to understand how you use integrations day to day — learning what's available, not building the platform.

**Alex:** Good. I still feel behind on this company's stack. Six months in.

---

### Task 1 — Discover telemetry

**UXR:** Walk me through the last time you tried to find out what telemetry an integration gives you.

**Alex:** Three weeks ago. We added a managed Redis. I needed to know what I'd get before bothering Priya.

Hub → Redis → Telemetry tab. Metrics list helped — `redis.used_memory`, etc. No Datadog column. I still think in `redis.net.clients` from Datadog. Googled internally, asked Slack.

**UXR:** Can you say more about the Datadog gap?

**Alex:** Rosetta stone. Two-column table: Datadog name, XCOR name, one-line description. Searchable. P0 for me.

**UXR:** How often do you look up telemetry before requesting install?

**Alex:** Every new dependency. Monthly maybe.

---

### Task 2 — Metric mapping during incident

**UXR:** What's the most frustrating part of how you currently handle integrations?

**Alex:** During pages I grep Datadog muscle memory. Alert says `aws.ec2.cpuutilization` — I don't know the XCOR name. Hub isn't open. Runbook links to wrong doc.

**UXR:** What do you mean by muscle memory?

**Alex:** Three years Datadog naming. XCOR uses different prefixes. I need translation in the alert footer — link to rosetta stone filtered to that integration.

**UXR:** How often?

**Alex:** Migration period — weekly. Steady state — monthly.

---

### Task 3 — OOTB dashboards

**UXR:** Walk me through the last time you used dashboards from an integration.

**Alex:** Kubernetes. I don't know KSM metrics well. Hub → Kubernetes → Assets → "Cluster Overview" → Install. Four dashboards. Good start.

Frustrating: one failed because I already had a dashboard named that from a coworker's import. Error was cryptic.

**UXR:** If Integration Hub disappeared tomorrow?

**Alex:** Slack Priya. Build Grafana from scratch — wouldn't. I'd fly blind until someone sent me a link.

**UXR:** What would make you trust the Hub?

**Alex:** Scoped to **my** services. Checklist: metrics yes/no, logs yes/no. Plain language. Read-only — I won't uninstall GCP, don't give me the button.

---

### Task 4 — Health check on call

**UXR:** Can you show me how you'd expect to check if Redis is healthy for your app during a page?

**Alex:** Hub → filter **My services** → Redis card. One sentence: "Healthy — metrics from orders-cache, 2 min ago." If bad: "Problem — no metrics 24h — escalate to Platform" with button.

Not forty tiles. Not YAML.

**UXR:** Flow 2 — you see a warning?

**Alex:** Email me? No — page only if my service. Warning on card: "Degraded — missing slowlog metrics." Link: what that means. Then Slack Marcus if Platform.

---

### Task 5 — Request new integration

**UXR:** Walk me through requesting monitoring for something new.

**Alex:** Hub → search Postgres → Available → **Request setup**. Form: service name, env, endpoint, what they need (metrics/logs). Submit → ticket in Priya's queue with number. Hub shows Pending.

Not copy YAML. I tried once, broke formatting, Priya was nice about it.

---

### Additional learning (open questions — Alex's lens)

**Detected vs Installed?**  
**Alex:** I don't care about the word. Care: "can I rely on this for my service?" Show data recency.

**OOTB dashboard conflict?**  
**Alex:** "Install as Redis Overview (2)" — fine. Don't fail silently.

**Dashboard ownership?**  
**Alex:** I edit dashboards I use. If OOTB updates, tell me — don't change my charts overnight.

**Integration versioning?**  
**Alex:** Not my job. Alert if my dashboards break.

**RBAC?**  
**Alex:** I shouldn't uninstall anything org-wide. Install dashboards for my workspace — yes.

**Multi-workspace?**  
**Alex:** I only want Payments workspace integrations. Don't show me HR's stuff.

**Collector communication?**  
**Alex:** If Hub says healthy but my dashboard is empty, I don't care why — show "metrics detected" vs "config says yes." Plain words.

**UXR:** Anything else?

**Alex:** Put rosetta stone in the alert link. Meet me where I panic.

---

## Key quotes

1. > "Rosetta stone. Two-column table: Datadog name, XCOR name. Searchable. P0 for me."
2. > "Hub → filter My services → Redis card. One sentence. Not forty tiles."
3. > "Request setup — submit ticket. Not copy YAML."
4. > "Install as Redis Overview (2) — fine. Don't fail silently."
5. > "Put rosetta stone in the alert link. Meet me where I panic."

## Main themes

| Theme | Summary |
|-------|---------|
| **Rosetta stone is P0** | Datadog→XCOR mapping in Hub and linked from alerts |
| **Scoped views** | My services / workspace filter reduces overwhelm |
| **Intake not authoring** | Request setup with pre-filled ticket beats YAML |
| **Dashboards as learning** | OOTB assets help understand unfamiliar infrastructure |
| **Plain-language health** | Data recency over taxonomy (Detected/Installed) |

## Surprises / challenged assumptions

- Alex wants rosetta stone **in alert context**, not only in Hub — migration pain is incident-time
- **Pending** state for requested integrations would reduce Slack "any update?" pings
- Dashboard naming conflicts are a real failure mode for developer self-serve install
- Alex explicitly **doesn't care** about Detected vs Installed labels if recency is clear

## Open questions to validate with real users

1. Do developer leads use Telemetry tab proactively, or only when blocked?
2. Is workspace-scoped filter sufficient, or do they need service-tag-based views?
3. Would alert-footer links to metric mapping reduce MTTR measurably?
4. Is "Request setup" ticket enough, or do they expect status updates in Hub?

## Additional learning

| Question | Alex's synthetic stance | Research implication |
|----------|------------------------|-------------------|
| **Detection threshold** | Show data recency, not internal states | User-facing health copy |
| **OOTB conflicts** | Auto-rename with suffix; clear message | Assets install UX |
| **Dashboard ownership** | Notify on OOTB updates; don't silently change | Change management for assets |
| **Integration versioning** | Surface only when dashboards/alerts break | Dev-facing comms |
| **RBAC** | No org-wide uninstall; dashboard install OK | Permission model |
| **Multi-workspace** | Workspace filter default for dev leads | Navigation/filter design |
| **Collector communication** | Plain explanation when detection ≠ expectation | Flow 2 for non-experts |
