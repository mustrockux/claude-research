# Integration Hub — Personas & Workflows

**Product:** XCOR Integration Hub  
**Last updated:** 2026-07-22  
**Persona files:** `personas/`

> Synthetic personas for design and research. Validate with real users before product decisions.

**Related:** Product PRD personas → [chrono-casestudy/source-docs](https://github.com/mustrockux/chrono-casestudy/tree/main/source-docs) · Prototype → [xcor-integrations-make](https://github.com/mustrockux/xcor-integrations-make) · Gap synthesis → [integrations/synthesis-figma-prototype-gaps-2026-07-22.md](./integrations/synthesis-figma-prototype-gaps-2026-07-22.md)

---

## Primary persona

**Priya Sharma — Platform Engineer** is the **primary persona** for Integration Hub. She manages XCOR collectors and standardizes integration configurations across environments. If the Hub fails for her, it fails for the organization.

---

## Persona index

| Persona | File | Role |
| :---- | :---- | :---- |
| **Priya Sharma** | [persona-priya-platform-engineer.md](personas/persona-priya-platform-engineer.md) | Platform Engineer — **primary** |
| **Marcus** | [persona-marcus-advanced-sre.md](personas/persona-marcus-advanced-sre.md) | Advanced SRE |
| **Alex Rivera** | [persona-alex-team-lead.md](personas/persona-alex-team-lead.md) | Developer Lead |

---

## Integration Hub needs by persona

### Platform Engineer (Priya) — Primary

| Priority | Need |
| :---- | :---- |
| **P0** | Exportable configs (**Terraform**, **chronoctl**) for GitOps — server-side configuration |
| **P0** | Installation instructions for XCOR collector and integrations (**Helm**, **Kubernetes**) |
| **P1** | Version compatibility matrix (collector version ↔ integration version) |
| **P2** | Configuration validation before deployment |

**Out of scope (phase 1):** Windows/Linux host agent integrations.

### SRE (Marcus)

| Priority | Need |
| :---- | :---- |
| **P0** | Quick access to integration **health status** |
| **P1** | Clear **troubleshooting guidance** when integrations break |
| **P1** | **Pre-built dashboards** without custom PromQL or deep domain knowledge |
| **P2** | License consumption visibility per integration |
| **P2** | Control rule recommendations to optimize costs |

### Developer Lead (Alex)

| Priority | Need |
| :---- | :---- |
| **P0** | What **telemetry is available** from the integration I'm using |
| **P0** | **Datadog → XCOR metric mapping** (rosetta stone) |
| **P0** | **XCOR dashboards** as a starting point to understand software/infrastructure |

---

## Canonical workflows

### Flow 1: Discover and install a collector integration (new integration)

Browse/search → review telemetry & assets → copy collector config (or guided intake) → deploy via Git/Helm → health auto-detects → optional OOTB dashboards.

| Persona | Role |
| :---- | :---- |
| **Priya** | Primary owner |
| **Alex** | Requests; uses catalog & dashboards |
| **Marcus** | Validates health |

### Flow 2: Troubleshoot "Installed" integrations with Warning health status

Warning tile → named health check failure → troubleshooting tips → fix or escalate → healthy.

| Persona | Role |
| :---- | :---- |
| **Marcus** | Primary owner |
| **Alex** | First to notice |
| **Priya** | Fixes config drift in Git |

### Flow 3: Configure a server-side cloud/API integration

Available tile → setup form → validate credentials → Installed + per-instance health → export Terraform/chronoctl.

| Persona | Role |
| :---- | :---- |
| **Priya** | Primary owner |
| **Marcus** | Reviews health |
| **Alex** | Consumes dashboards |

---

## Related project

Prototype and synthetic interviews: `~/projects/xcor-integrations-make/research/`
