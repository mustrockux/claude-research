# Priya Sharma — Platform Engineer

> **Primary persona** for XCOR Integration Hub

## Demographics

| Attribute | Detail |
| :---- | :---- |
| **Age** | Mid 30s |
| **Location** | Big tech city |
| **Occupation** | Platform Engineer, Observability Platform team |
| **Education** | BS Computer Science; CKA certified |
| **Income range** | High |
| **Tenure at org** | 4 years |

## Tech Comfort

- **Level:** Very high — lives in YAML, Helm, Terraform, and CI pipelines
- **Daily tools:** Terraform, ArgoCD, Kubernetes, XCOR collector Helm chart, internal GitOps repos, Datadog (migrating from), chronoctl
- **Comfort with new tech:** Early adopter for platform tooling; conservative about production rollouts without version pins and rollback paths

## Responsibilities

- Manage XCOR collectors across dev, staging, and production clusters
- Standardize integration configurations across environments
- Own the GitOps repos that define server-side connect accounts and collector receivers
- Partner with SRE on integration health; partner with app teams on onboarding new telemetry sources
- **Not in scope (phase 1):** Windows/Linux host agent integrations — focused on Kubernetes workloads and cloud/API pull integrations

## Integration Hub needs

| Priority | Need |
| :---- | :---- |
| **P0** | Exportable configs (**Terraform**, **chronoctl**) for GitOps workflows — especially server-side configuration |
| **P0** | Installation instructions for XCOR collector and integrations (**Helm**, **Kubernetes**) |
| **P1** | Version compatibility matrix — which collector version supports which integration versions |
| **P2** | Configuration validation before deployment |

## Primary workflows

| Workflow | Role |
| :---- | :---- |
| **Flow 1:** Discover and install a collector integration (new integration) | **Primary owner** — defines standard patterns, merges PRs, validates rollout |
| **Flow 3:** Configure a server-side cloud/API integration | **Primary owner** — creates connect accounts, exports to Terraform, promotes across envs |

## Goals

- One blessed path for adding Redis, GCP, or any integration — no snowflake configs per team
- UI that accelerates discovery and docs, but **Git remains source of truth**
- Catch misconfiguration before it hits prod (wrong poll interval, missing project ID, incompatible collector version)
- Reduce "integration archaeology" — know what's installed where without reading five repos

## Pain Points

- App teams paste collector YAML from docs that doesn't match the platform Helm chart structure
- Server-side integrations get configured in the UI but never exported — drift within weeks
- No single place to answer "what collector version is prod on and does it support Redis receiver v2?"
- Integration Hub treats setup like a one-off wizard; platform work is repeatable and environment-scoped

## Frustrations with Current Solutions

- Datadog UI config doesn't round-trip to Terraform cleanly — had to maintain parallel sources of truth during migration
- Docs assume you install a collector from scratch; platform teams wrap collectors in Helm with opinions
- "Installed" in a UI doesn't mean "merged to `main` and deployed to prod-eu"

## Behaviors

- Starts in Git; uses UI for discovery, telemetry catalog, and generating export blocks
- Copies YAML/Terraform from Hub → PR → CI validate → ArgoCD sync
- Maintains internal modules: `xcor-integration-gcp`, `xcor-collector-receivers`
- Reviews integration PRs from app teams; rejects configs that skip validation or version matrix
- Collaborates with Marcus on health semantics; trains Alex's team on the blessed path

## Context

- **Primary environment:** Desktop, terminal + IDE, multiple monitors
- **On-call:** Secondary for collector fleet; primary for integration rollout failures
- **Usage pattern:** Proactive — weekly integration reviews, ad-hoc when teams request new sources

## Quotes

> "If I can't export it to Terraform, it's a demo — not a platform."

> "Tell me which collector version supports which integration *before* I merge the PR."

> "The Hub should generate the config; Git should own it."

## Backstory

Priya joined the Observability Platform team four years ago when XCOR collectors were installed by hand on a handful of clusters. She wrote the Helm chart that now runs collectors in twelve Kubernetes environments and the Terraform modules the company uses for GCP and AWS server-side pull integrations.

When leadership mandated a Datadog migration, Priya became the hinge person: she needed Integration Hub to replace not just Datadog's marketplace tiles, but the **operating model** — how configs get proposed, reviewed, exported, and promoted. Marcus cares whether integrations are healthy; Alex cares whether their app's Redis is monitored. Priya cares whether the **pattern** is repeatable.

She's the primary persona for Integration Hub because most integrations ultimately flow through her: collector receivers land in her Helm values, connect accounts land in her Terraform state. If the Hub doesn't speak GitOps — export, version matrix, validation, Helm-aligned install docs — she'll bypass the UI entirely and maintain internal runbooks, and the product becomes shelfware for everyone except app developers clicking through once.
