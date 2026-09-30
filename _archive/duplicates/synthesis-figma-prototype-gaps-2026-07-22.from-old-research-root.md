# Research Synthesis: Figma MVP ↔ Prototype Gaps

**Date:** 2026-07-22  
**Figma page:** [Research Synthesis](https://www.figma.com/design/ny3815szaxG3giFeYwEXil/Integrations-Hub?node-id=4964-56197) (page `Research Synthesis` in Integrations-Hub file)  
**Sources:** Synthetic interviews (Priya, Marcus, Alex), [Figma MVP Final](https://www.figma.com/design/ny3815szaxG3giFeYwEXil/Integrations-Hub?node-id=4656-51255), current prototype (`src/app/`)

> Synthetic research — validate with real users before build decisions.

---

## Executive summary

Research and Figma agree on a **two-path model** (Collector vs Server pull) with **full-page detail tabs**, not drawer-first UX. The prototype has strong demo pieces (multi-instance Redis/GCP, cloud-push Atlas, telemetry mocks) but optimizes for **drawer + marketplace clicks** while Figma and **Priya (primary persona)** require **GitOps export, Helm-aligned install, Configurations tab, and validation**.

**Highest-impact gaps:**

1. **Navigation model** — Figma uses full-page integration detail; prototype uses `integration-detail-drawer.tsx` from hub/marketplace  
2. **Priya P0** — Terraform/chronoctl export exists in `code-config-view.tsx` but is not wired through Hub setup flows  
3. **Alex P0** — Datadog rosetta stone specified in PRD, absent in prototype Telemetry UI  
4. **Marcus P0/P1** — Flow 2 troubleshooting exists as a conditional tab but lacks named health checks and layer-specific guidance  
5. **Figma Server Configurations** — no dedicated Configurations tab/page for multi connect-account management  

---

## Persona × workflow map

| Workflow | Primary persona | Figma anchor | Prototype today |
|----------|-----------------|--------------|-----------------|
| **Flow 1** — Discover & install collector integration | Priya | `Integrations/Collector/Available` → `Set up` → `Installed` | `integrations-marketplace.tsx` → drawer Set up tab → demo hooks |
| **Flow 2** — Troubleshoot warning health | Marcus | `Integrations/Collector/Health`, warning badges on `Installed` | `integration-detail-drawer` Troubleshooting tab (conditional); hub status badges |
| **Flow 3** — Server-side cloud/API integration | Priya | `Integrations/Server/Available` → `Configurations` → `GCP/ Configure` drawer | `integration-setup.tsx`, `integration-configure.tsx`, drawer cloud-api forms |

---

## Figma MVP screen inventory

Canvas: **MVP Final** → section **Integrations Hub MVP FINAL**

### Collector path

| Figma frame | Purpose | Key elements |
|-------------|---------|--------------|
| `Integrations/Collector/Available` | Marketplace / not installed | 3-col cards, search, category filter, toggle |
| `Integrations/Collector/Set up` | Full-page setup | Tab group; Step 4 YAML, Step 2 restart, Step 3 Install dashboards, Step 9 troubleshooting |
| `Integrations/Collector/Installed` | Hub installed view | 3-col cards, instance health badges, health filter |
| `Integrations/Collector/Telem` | Telemetry catalog | Metrics table (5 rows per type in latest Figma) |
| `Integrations/Collector/Assets` | OOTB dashboards | Opt-in install |
| `Integrations/Collector/Health` | Health / Flow 2 | Instance health detail |

### Server pull path

| Figma frame | Purpose | Key elements |
|-------------|---------|--------------|
| `Integrations/Server/Available` | Cloud marketplace | Server-side tiles (GCP, Azure, Cloudflare…) |
| `Integrations/Server/Overview` | Installed detail | About, prerequisites, best practices, validation, troubleshooting |
| `Integrations/Server/Telem` | Telemetry catalog | Metrics/logs/traces tables |
| `Integrations/Server/Assets` | OOTB dashboards | Dashboard install |
| `Integrations/Server/Configurations` | Multi-account management | 3 variants — list, edit, empty states |
| `Integrations / GCP/ Configure` | 681px drawer | Name, API/SA key, endpoint, resource, polling interval |
| `Integrations/GCP` | Hub tile (installed) | Multi-instance health on card |

### Overlays

| Figma frame | Purpose |
|-------------|---------|
| `Health filter` | Filter hub by health status |
| `Request/Form` + `Request/Confirm` | Request unsupported integration |
| `Confirmation dialogue` | Delete GCP configuration |

### Figma annotations (design intent)

- **COLLECTOR** — Kubernetes, MySQL, Redis  
- **SERVER PULL** — GCP, Azure, Cloudflare  
- Explicit state labels: `COLLECTOR / NOT INSTALLED`, `COLLECTOR/Installed`, `SERVER PULL/Not Installed`, `SERVER PULL/Installed`

---

## Prototype inventory

| Route / component | Role | Tabs / features |
|-------------------|------|-----------------|
| `/integrations` — `integrations-hub.tsx` | Installed hub | Grid, health filters, multi-instance Redis/GCP demo, drawer on click |
| `/integrations/marketplace` — `integrations-marketplace.tsx` | Available browse | Toggle, search, category; drawer on card click |
| `integration-detail-drawer.tsx` | Primary detail UX | Overview, Set up, Metrics Preview, Telemetry, Dashboards, Recommendations, Troubleshooting |
| `/integrations/:id` — `integration-detail.tsx` | Alternate detail page | connection / config / telemetry (different IA than Figma) |
| `/integrations/:id/setup` — `integration-setup.tsx` | Full-page cloud setup | Form + validate route |
| `code-config-view.tsx` | Export | Terraform, Pulumi, chronoctl (not Hub-integrated) |
| `use-integration-instances-demo.ts` | Demo state | sessionStorage multi-instance Redis/GCP |
| `cloud-push-setup-panel.tsx` | Atlas push | Ingestion URL flow (not in Figma MVP canvas) |

---

## Gap analysis by persona need

### Priya — Platform Engineer (primary)

| Need | Figma | Prototype | Gap severity |
|------|-------|-----------|--------------|
| **P0 Terraform/chronoctl export** | GCP Configure + export affordance | `code-config-view` exists; partial in drawer GitOps blocks | **High** — not on critical path in Hub |
| **P0 Helm/K8s install docs** | Collector Set up steps + restart | Generic otelcol YAML in drawer | **High** — no Helm values fragment |
| **P1 Version matrix** | Not visualized in frames | Static collector version in drawer overview | **Medium** — missing table |
| **P2 Pre-deploy validation** | Validate on GCP save | `integration-setup` → validate route; inconsistent in drawer | **Medium** — unify validate pattern |
| **Flow 3 Configurations tab** | `Integrations/Server/Configurations` | No dedicated tab; instances in hub card + drawer overview | **High** — IA mismatch |
| **Git ↔ UI provenance** | Implied multi-source | sessionStorage demo only | **High** — product open question |

**Research quotes driving priority:** *"UI → Terraform → apply → UI shows same connect accounts"* · *"Helm values fragment, not raw otelcol"*

---

### Marcus — Advanced SRE

| Need | Figma | Prototype | Gap severity |
|------|-------|-----------|--------------|
| **P0 Health status at a glance** | Health filter + badges on Installed cards | Hub filters + badges; multi-instance summary | **Low** — largely aligned |
| **P1 Troubleshooting guidance** | Step 9 blocks, Server Overview validation | Troubleshooting tab when misconfigured/missing-data | **Medium** — needs named metrics + layers |
| **P1 OOTB dashboards** | Assets tab, explicit Install dashboards CTA | Dashboards tab in drawer | **Low** — present; confirm opt-in UX |
| **P2 License consumption** | Not in Figma frames | Partial cost fields in hub mock data | **Medium** — P2 |
| **P2 Control rule recommendations** | Not in Figma frames | Recommendations tab in drawer | **Low** — prototype ahead for demo |
| **Flow 2 full-page** | Health / Overview pages | Drawer-only for most flows | **Medium** — IA mismatch |

**Research quotes:** *"Name the missing health check"* · *"Which layer: auth, collector, drop rule"*

---

### Alex — Developer Lead

| Need | Figma | Prototype | Gap severity |
|------|-------|-----------|--------------|
| **P0 Telemetry catalog** | Telem tabs with metrics tables | Telemetry tab + drawers; mocks for Redis | **Low** — content exists |
| **P0 Datadog rosetta stone** | PRD toggle; not explicit in Figma frames | Not implemented in Telemetry UI | **High** — Alex P0 |
| **P0 OOTB dashboards** | Assets tab | Dashboards tab | **Low** |
| **Scoped "my services" view** | Not in Figma | No workspace/service filter on hub | **Medium** |
| **Request setup intake** | Request/Form dialog | Request flow partial in marketplace | **Medium** |
| **Dual-mode Set up** | Collector Set up is YAML-only in Figma | YAML-only; no guided form | **High** — research consensus |

**Research quotes:** *"Rosetta stone searchable P0"* · *"Request setup, not copy YAML"*

---

## Workflow gap detail

### Flow 1: Discover & install collector integration

| Step | Figma | Prototype | Gap |
|------|-------|-----------|-----|
| Browse Available | `Collector/Available` | `integrations-marketplace.tsx` | Aligned |
| Review telemetry/assets | Full-page Telem + Assets tabs | Drawer tabs | **Use full-page or widen drawer** |
| Copy config | Step 4 YAML + copy | Drawer Set up YAML | Add **Helm values** variant |
| Deploy | Step 2 restart collector | User manual; demo Test button for Redis | Add **pipeline-oriented** copy |
| Detect installed | Auto when metrics flow | Demo sessionStorage | Clarify **Detected vs Installed** (open question) |
| Install dashboards | Step 3 explicit CTA | Dashboards tab | Align CTA placement with Figma header |

### Flow 2: Troubleshoot warning health

| Step | Figma | Prototype | Gap |
|------|-------|-----------|-----|
| See warning on card | Yellow badge + health filter | `installed-missing-data`, `misconfigured` statuses | Align labels with Figma Health |
| Open detail | `Collector/Health` page | Troubleshooting tab (conditional) | **Always show health context** on Overview |
| Named failure | Implied in validation copy | Generic error strings | Add **metric name + last seen** |
| Layer guidance | Server Overview troubleshooting blocks | Collector-focused tips | Add **auth / collector / control rule** sections |
| Escalate | — | — | Add **Request Platform** / link to config (read-only) |

### Flow 3: Server-side cloud/API integration

| Step | Figma | Prototype | Gap |
|------|-------|-----------|-----|
| Browse Available | `Server/Available` | Marketplace with delivery labels | Aligned |
| Configure | `GCP/ Configure` drawer fields | `integration-setup.tsx` + drawer forms | Align field parity (name, API, endpoint, resource, polling) |
| Validate save | Implied | Partial on setup page | **Validate before green badge** |
| Multi-account | `Server/Configurations` | Hub card instances + drawer | **Add Configurations tab** |
| Export GitOps | Export button in Figma footer area | `code-config-view` disconnected | **Wire export to Hub** |
| Delete account | Confirmation dialogue | Uninstall demo on card | Add **per-config delete** confirm |

---

## Additional learning → design implications

| Open question | Research consensus | Prototype implication |
|---------------|-------------------|----------------------|
| **Detection threshold** | Publish required metrics + time window | Status tooltips; don't rely on opaque "Installed" |
| **OOTB name conflicts** | Never overwrite; suffix or skip | Assets install needs collision handling |
| **Dashboard ownership** | Fork on edit; preserve on uninstall | Track OOTB vs user fork in Assets tab |
| **Integration versioning** | Pin in Git; opt-in upgrades | Version matrix + changelog link (Priya P1) |
| **RBAC** | Platform/SRE install server-side; devs scoped | Hide Uninstall/Configure for Alex persona |
| **Multi-workspace** | Org integrations; workspace-tagged accounts | Filters on hub + marketplace |
| **Collector communication** | Config + detection; show mismatch | Health panel: "Config expects X; metrics from Y" |

---

## Recommended build sequence

Aligned to primary persona + Figma MVP:

### Phase A — IA alignment (Figma structure)

1. Route hub/marketplace card clicks to **full-page integration detail** (`integration-detail.tsx` refactor) matching Figma tab names: Overview, Set up, Telemetry, Assets, Health, Configurations (server only)  
2. Deprecate drawer as primary path; keep for quick configure (`GCP/ Configure` 681px pattern)  
3. Split marketplace mentally: **Collector/Available** vs **Server/Available** (footer labels already in prototype)

### Phase B — Priya P0 (primary persona)

4. **Export Terraform/chronoctl** from Set up and Configurations — reuse `code-config-view.tsx`  
5. **Helm values fragment** alongside raw YAML on Collector Set up  
6. **GCP Configure drawer** field parity with Figma + validate-on-save  
7. **Configurations tab** for server integrations (list/add/edit/delete connect accounts)

### Phase C — Marcus Flow 2

8. Named health check failures on Overview + Health tab  
9. Layered troubleshooting (auth, network, collector, control rules)  
10. Health filter menu per Figma on Installed hub

### Phase D — Alex P0

11. **Datadog ↔ XCOR rosetta stone** toggle on Telemetry tab (PRD requirement)  
12. **Request setup** intake form → pending state (Figma Request/Form)  
13. **Dual-mode Set up**: Guided (form/ticket) + Advanced (YAML/export)  
14. **My services / workspace** filter on hub (research; confirm with real users)

### Phase E — Polish & open questions

15. OOTB dashboard collision UX  
16. Version compatibility matrix component  
17. RBAC gates on destructive actions  
18. Detection vs Installed semantics (product decision)

---

## File reference for implementation

| Concern | Start here |
|---------|------------|
| Hub grid + health | `src/app/pages/integrations-hub.tsx` |
| Marketplace | `src/app/pages/integrations-marketplace.tsx` |
| Detail UX (refactor target) | `src/app/pages/integration-detail.tsx`, `integration-detail-drawer.tsx` |
| Setup forms | `src/app/components/integration-setup-form.tsx`, `integration-setup.tsx` |
| GCP / cloud push | `cloud-push-setup-panel.tsx`, `integration-setup-fields.ts` |
| Multi-instance demo | `use-integration-instances-demo.ts` |
| Export | `src/app/components/code-config-view.tsx` |
| Telemetry mocks | `src/app/data/integration-detail-mocks.ts` |

---

## Related research artifacts

- [integration-hub-personas.md](integration-hub-personas.md)  
- [synthetic-interview-priya-2026-07-22.md](synthetic-interview-priya-2026-07-22.md)  
- [synthetic-interview-marcus-2026-07-22.md](synthetic-interview-marcus-2026-07-22.md)  
- [synthetic-interview-alex-2026-07-22.md](synthetic-interview-alex-2026-07-22.md)
