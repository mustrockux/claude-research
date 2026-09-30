# Synthetic Interview: Priya Sharma (Platform Engineer)

**Date:** 2026-07-22  
**Duration:** ~50 min (simulated)  
**Interviewer:** UX Research  
**Topic:** Integration Hub — setup, GitOps, validation, fleet management  
**Product context:** XCOR Integration Hub (MVP)  
**Persona source:** `research/personas/persona-priya-platform-engineer.md`  
**Primary persona:** Yes

> ⚠️ **Synthetic research** — simulated session for design exploration. Not real user data.

---

## Main tasks (1–5)

Tasks Priya is likely to perform in Integration Hub:

1. **Add a collector integration** (e.g. Redis receiver) to the standard Helm chart and promote dev → staging → prod  
2. **Configure a server-side cloud integration** (e.g. GCP) and export to Terraform/chronoctl  
3. **Check version compatibility** before approving an app team's integration PR  
4. **Validate configuration** before merge (credentials shape, poll interval, required fields)  
5. **Audit what's installed** across environments — reconcile UI state with Git and collector fleet  

### Integration Hub needs

| Priority | Need |
|----------|------|
| **P0** | Exportable configs (Terraform, chronoctl) for GitOps |
| **P0** | Helm/Kubernetes installation instructions aligned to platform chart |
| **P1** | Version compatibility matrix |
| **P2** | Configuration validation before deployment |

### Primary workflows

**Flow 1** (collector install) · **Flow 3** (server-side cloud/API) — primary owner

---

## Session transcript

**UXR:** Priya, thanks for making time. I'm researching how platform teams discover, install, and standardize integrations — especially collectors and server-side pull. I'm not testing you; I want to understand your real workflow.

**Priya:** Sure. Fair warning — if this is another UI wizard that doesn't export to Git, I'll be honest about that.

**UXR:** That's exactly the kind of thing I need to hear.

---

### Task 1 — Add Redis to collector fleet

**UXR:** Walk me through the last time you tried to add a collector integration — like Redis — across your environments.

**Priya:** Last week. Payments team needed Redis metrics. Alex filed a ticket with host and port.

I went to the Hub, found Redis, Set up tab. YAML snippet was fine as a *reference* — but our chart wraps receivers under `collector.config.receivers`, not raw otelcol. I needed the Helm values patch, not generic docs.

Copied what I could, translated to our chart structure, opened PR to `platform-observability`. CI runs `helm template` + config validate. Dev merged Monday, staging Wednesday, prod Thursday after Marcus spot-checked health.

**UXR:** Can you say more about "translated to our chart structure"?

**Priya:** Hub assumes you're editing a flat `config.yaml`. We inject via Helm `values.yaml` per env — different endpoints, secrets from ExternalSecrets. The snippet should say "if you use our chart, put it here" with a link to our module.

**UXR:** How often do teams request new collector integrations?

**Priya:** Two to four a month. Same pattern every time.

---

### Task 2 — GCP server-side + Terraform export

**UXR:** What's the most frustrating part of how you currently handle server-side integrations?

**Priya:** UI configs that don't round-trip. Someone configured GCP in the Hub demo environment, showed green, never exported. Three weeks later Terraform state didn't match — we were double-polling one project and missing another.

**UXR:** What do you mean by round-trip?

**Priya:** UI → Terraform → apply → UI shows same connect accounts. If I delete in Git, UI reflects it. Datadog never got this right either.

**UXR:** Walk me through how you'd configure GCP today.

**Priya:** Hub → GCP → Configurations. Form: account name, projects, SA JSON, poll interval. **Save only if validate passes** — hit GCP API, show me the error inline.

Then **Export** — Terraform block or chronoctl. I paste into `modules/xcor-gcp/main.tf`, PR, plan, apply. Hub reads back from API what exists — or ideally from our Git sync, but API is okay if it's complete.

**UXR:** How often does drift happen?

**Priya:** Any time someone uses UI without export. Monthly unless we lock it down.

---

### Task 3 — Version matrix

**UXR:** If Integration Hub disappeared tomorrow, what would you do instead?

**Priya:** Internal runbook + Terraform modules + Helm chart README. We'd survive. Hub saves me reading scattered docs — telemetry catalog, which receiver version needs collector 0.95+.

**UXR:** Would you miss anything?

**Priya:** Version matrix. I still grep CHANGELOG today. "Can prod on 0.94 use the new Postgres receiver?" should be a table in the Hub on every integration page.

---

### Trust

**UXR:** What would make you trust Integration Hub?

**Priya:** Four things. Export that matches what I deploy. Validate before save. Explicit env promotion story — dev/staging/prod tabs or labels, not one blob. And honest collector communication — how does the Hub know what's in my fleet?

**UXR:** Say more about collector communication.

**Priya:** If status is "Installed" because you *detected metrics*, fine — say that. If it's because someone clicked a button, say that. If it's because Git sync says so, say that. I need to know the source of truth.

---

### Think-aloud — expected workflow

**UXR:** Can you show me how you'd expect adding a new server-side AWS integration to work?

**Priya:** Marketplace → AWS → Available. Overview: prerequisites, IAM, poll interval defaults. Set up: form + **Validate connection**. Configurations tab after install: list of connect accounts, add another.

Top right: **Export Terraform** always visible. Secondary: **Copy Helm** N/A for AWS.

For collector path: **Generate values fragment** for our chart, not raw otelcol. CI badge: "Compatible with collector ≥ 0.96."

RBAC: platform team can install server-side; app teams can request collector changes via PR template, not click Install in prod.

**UXR:** Who should install/uninstall?

**Priya:** Server-side connect accounts — platform eng + SRE lead. Collector receivers — platform merges, app teams propose. Uninstall server-side — platform only, with confirm dialog that lists what gets removed. Don't let Alex delete GCP prod because he was clicking around.

---

### Additional learning (open questions — Priya's lens)

**UXR:** I have some product questions we're still figuring out. Gut reactions are helpful.

**Data detection — when is something "Detected"?**  
**Priya:** Name the health check metrics in docs. "3 of 3 required metrics within 15 minutes" — not magic. I'd configure thresholds per integration in Git if I had to.

**OOTB dashboard name conflict?**  
**Priya:** Never overwrite. Suffix `-ootb` or prompt rename. I install dashboards via Terraform too — collision breaks CI.

**Dashboard ownership — can users edit OOTB?**  
**Priya:** Fork, don't edit in place. "Save as copy." Uninstall shouldn't delete user forks.

**Integration versioning / breaking changes?**  
**Priya:** Pin integration definition version in Terraform. Auto-upgrade OOTB assets — opt-in, never silent. Show changelog.

**RBAC?**  
**Priya:** Org admin + platform role for install/uninstall server-side. Read-only for most devs.

**Multi-workspace?**  
**Priya:** Integrations org-scoped; connect accounts can be workspace-tagged. Payments shouldn't see HR's GCP projects.

**Collector communication?**  
**Priya:** Parse config from Git API if connected, cross-check with metric detection. Both. Show mismatch explicitly: "Config expects Redis A; metrics from Redis B."

**UXR:** Anything I didn't ask?

**Priya:** Chronoctl export parity with Terraform. And validation in CI — `xcor integrations validate` I can run in GitHub Actions.

---

## Key quotes

1. > "If this is another UI wizard that doesn't export to Git, I'll be honest about that."
2. > "UI → Terraform → apply → UI shows same connect accounts. Datadog never got this right either."
3. > "Hub assumes you're editing a flat config.yaml. We inject via Helm values per env."
4. > "If status is 'Installed' because you detected metrics, fine — say that. I need to know the source of truth."
5. > "Never overwrite [dashboards]. I install via Terraform too — collision breaks CI."

## Main themes

| Theme | Summary |
|-------|---------|
| **GitOps non-negotiable** | Export, round-trip, and CI validation are P0 — UI is accelerant |
| **Platform-shaped docs** | Helm values fragments, not generic otelcol snippets |
| **Explicit provenance** | Installed/Detected must state whether from metrics, UI click, or Git |
| **RBAC & blast radius** | Install/uninstall permissions must match enterprise reality |
| **Version matrix in context** | Compatibility table on integration pages, not external CHANGELOG |

## Surprises / challenged assumptions

- Priya wants **both** config parsing and metric detection, with **mismatch surfacing** — not one source alone
- Helm alignment matters more than prettier wizards — "values fragment" beats full setup UI
- Dashboard conflicts are a **CI/Terraform** problem for her, not just UX polish
- Chronoctl mentioned as equal priority to Terraform — don't optimize for one export format

## Open questions to validate with real users

1. Do platform teams actually connect Git to Integration Hub, or is export-once enough?
2. What % need chronoctl vs Terraform vs both?
3. Is environment promotion (dev/staging/prod) in-scope for Hub MVP or internal tooling?
4. Would `xcor integrations validate` CLI be used if Hub also validates on save?

## Additional learning

_Product open questions — notes from this session._

| Question | Priya's synthetic stance | Research implication |
|----------|-------------------------|-------------------|
| **Detection threshold** | Publish required metrics + time window per integration; configurable in enterprise | Document detection contract in Hub UI |
| **OOTB name conflicts** | Never overwrite; suffix or rename prompt | Align with Terraform dashboard modules |
| **Dashboard ownership** | Fork/save-as-copy; uninstall preserves user copies | Uninstall flow needs asset inventory |
| **Integration versioning** | Pin versions in Git; opt-in OOTB upgrades | Breaking change comms in Hub |
| **RBAC** | Platform + SRE install server-side; devs propose collector via PR | Role model in MVP? |
| **Multi-workspace** | Org-scoped integrations; workspace-tagged accounts | Scope tiles and filters |
| **Collector communication** | Git config + metric detection; show mismatches | Backend architecture decision — surface in UI |
