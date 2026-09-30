# Synthetic Interview: Marcus (Advanced SRE)

**Date:** 2026-07-22  
**Duration:** ~45 min (simulated)  
**Interviewer:** UX Research  
**Topic:** Integration health, troubleshooting, dashboards, cost  
**Product context:** XCOR Integration Hub (MVP)  
**Persona source:** `research/personas/persona-marcus-advanced-sre.md`

> ⚠️ **Synthetic research** — simulated session for design exploration. Not real user data.

---

## Main tasks (1–5)

Tasks Marcus is likely to perform in Integration Hub:

1. **Check integration health status** across the fleet during or before incidents  
2. **Troubleshoot a warning state** (e.g. Installed — Missing Data on MySQL)  
3. **Install OOTB dashboards** for an integration after Priya confirms data is flowing  
4. **Review license consumption** per integration during cost optimization reviews  
5. **Act on control rule recommendations** tied to an integration's telemetry volume  

### Integration Hub needs

| Priority | Need |
|----------|------|
| **P0** | Quick access to integration health status |
| **P1** | Clear troubleshooting guidance when integrations break |
| **P1** | Pre-built dashboards without custom PromQL |
| **P2** | License consumption per integration |
| **P2** | Control rule recommendations to optimize costs |

### Primary workflow

**Flow 2** — troubleshoot Warning health (primary owner)

---

## Session transcript

**UXR:** Marcus, thanks for doing this. I'm focused on integration health and troubleshooting — not app-level incident response. Good?

**Marcus:** Good. That's where I live anyway — is the pipe working.

---

### Task 1 — Fleet health check

**UXR:** Walk me through the last time you tried to check whether integrations were healthy.

**Marcus:** Yesterday morning. Weekly hygiene before exec metrics review.

Opened Hub, Installed view. Filtered health — wanted Warning and Error only. Got… a grid. Some yellow. Clicked MySQL — "Installed - Missing Data." Good label. Bad detail: no `mysql.uptime` called out for thirty seconds. Had to open Telemetry tab.

**UXR:** Can you say more about what you needed in those first thirty seconds?

**Marcus:** Name the missing health check. "Expected `mysql.uptime`, last seen 36 hours ago." Link to troubleshooting. One screen.

**UXR:** How often do you do fleet health passes?

**Marcus:** Weekly formal. Ad hoc daily when Alex pings me.

---

### Task 2 — Troubleshoot warning

**UXR:** What's the most frustrating part of how you currently handle integrations that break?

**Marcus:** Troubleshooting tips written for someone who edits collector YAML. Alex gets paged, I get paged, Priya fixes Git — but the Hub should tell Alex *which layer* is broken: auth, network, collector, drop rule.

Flow 2 is the product. Yellow tile → why → what to check → link to control rules. Datadog did "missing integration metric" reasonably well.

**UXR:** Walk me through the last warning you actually fixed.

**Marcus:** GCP connect account — misconfigured SA. Hub said Warning. I opened drawer, saw generic "authentication failed." Priya found the real error in Cloud Logging. Hub should surface API error text: permission denied on project X.

**UXR:** How often?

**Marcus:** Warning states? Several a month. Real outages from integration failure? Monthly.

---

### Task 3 — OOTB dashboards

**UXR:** If Integration Hub disappeared tomorrow, what would you do instead?

**Marcus:** Grafana folder sprawl. Someone's "Redis Overview" from 2019. I'd rather Hub with opt-in dashboards than auto-installing six hundred panels.

**UXR:** Walk me through installing dashboards when you do use the Hub.

**Marcus:** Redis healthy → Assets tab → select dashboards → Install. Explicit. But tell me if I already have a dashboard named "Redis Overview." Don't stomp my edits.

**UXR:** What do you mean by stomp?

**Marcus:** OOTB overwrite. If I changed variables, uninstall/reinstall shouldn't delete my version without asking.

---

### Trust

**UXR:** What would make you trust Integration Hub?

**Marcus:** Health checks I can cite in postmortems. Troubleshooting that mentions drop rules and license burn. And don't mark Installed until data's there — or label it Detected vs Installed clearly.

**UXR:** What would make you distrust it?

**Marcus:** Green tile, no metrics. Happened in Dynatrace eval. Never again.

---

### Think-aloud

**UXR:** Can you show me how you'd expect Flow 2 to work — warning on an installed integration?

**Marcus:** Hub card — yellow badge, human text: "Missing data — 1 of 2 instances."

Click — full page, not drawer. Top: status + last successful metric time. Section: **Likely causes** — numbered. Buttons: View control rules, View collector config (read-only), Copy runbook link.

P2 stuff: license chip — "MySQL integration, 4.2% of ingest last 30d." Control rec — "Drop rule removing 80% of mysql.* — review."

**UXR:** Who should install/uninstall?

**Marcus:** I can install dashboards. Uninstall integration — platform only. I don't want Alex removing GCP prod.

---

### Additional learning (open questions — Marcus's lens)

**Detected vs Installed threshold?**  
**Marcus:** Product decision, but show me the rule. "Detected = health metric seen once in 24h" is fine if you say it. I don't want Alex guessing.

**OOTB name conflict?**  
**Marcus:** Prompt: install as new, skip, replace. Default skip.

**Dashboard ownership?**  
**Marcus:** OOTB is read-only template. Edit → fork. Postmortems reference dashboard ID — need stability.

**Breaking integration versions?**  
**Marcus:** Warn on breaking change. Don't auto-migrate my alerts.

**RBAC?**  
**Marcus:** SRE + platform install. Devs view health for their scope.

**Multi-workspace?**  
**Marcus:** I need org-wide health for incidents. Alex needs filtered view. Same data, different default filter.

**Collector communication?**  
**Marcus:** Detection is enough for health if health checks are right. Config parse is Priya's thing — but show me both when they disagree.

**UXR:** License visibility — P2. Still care?

**Marcus:** During quarterly cost war? Absolutely. Not during 3 a.m. pages.

---

## Key quotes

1. > "Is the pipe working — that's where I live."
2. > "Name the missing health check. Expected `mysql.uptime`, last seen 36 hours ago."
3. > "Tell Alex which layer is broken: auth, network, collector, drop rule."
4. > "Green tile, no metrics. Happened in Dynatrace eval. Never again."
5. > "OOTB is read-only template. Edit → fork."

## Main themes

| Theme | Summary |
|-------|---------|
| **Named health failures** | Warning must cite specific missing metrics and recency |
| **Layered troubleshooting** | Auth vs collector vs control rules — not generic YAML tips |
| **Flow 2 is the SRE product** | Yellow → why → actions → links |
| **Explicit OOTB install** | Opt-in dashboards; no silent overwrite |
| **Cost surfaces are episodic** | License/control recs matter for reviews, not on-call |

## Surprises / challenged assumptions

- Marcus wants **read-only collector config** in troubleshooting — not edit — with link to Priya's Git
- **Detected vs Installed** semantics matter for postmortems and Alex escalations
- Dashboard fork/ownership is an **incident/postmortem** concern, not just UX nicety
- Org-wide vs scoped views are **filter defaults**, not separate products

## Open questions to validate with real users

1. Do SREs actually use Hub for weekly hygiene, or only when paged?
2. Is full-page troubleshooting required, or is an expanded drawer enough?
3. How much license/control rule detail belongs in Hub vs Cost Management product?
4. Do teams want API error text from cloud providers surfaced in Hub?

## Additional learning

| Question | Marcus's synthetic stance | Research implication |
|----------|--------------------------|-------------------|
| **Detection threshold** | Publish rule; Detected ≠ Installed for trust | Status glossary in UI |
| **OOTB conflicts** | Default skip; prompt on collision | Install dashboards flow |
| **Dashboard ownership** | Read-only OOTB; fork on edit | Asset lifecycle on uninstall |
| **Integration versioning** | Warn; no silent alert migration | Upgrade messaging |
| **RBAC** | SRE/platform install; devs view scoped health | Role matrix |
| **Multi-workspace** | Org-wide for SRE; filtered for dev leads | Default filters per role |
| **Collector communication** | Metric detection for health; show config mismatch | Flow 2 troubleshooting panel |
