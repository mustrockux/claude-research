# Filesystem reorganization — 2026-09-30

Three canonical roots under `/Users/rmustafa`: **`~/projects`**, **`~/docs`**, **`~/research`**.

## Before → after (top level)

| Before | After |
|---|---|
| Code in `~/projects/` (APFS same as `~/Projects`) | **`~/projects/`** — all code repos |
| `~/docs/product_design`, `claude_docs`, `learning`, **`claude_research`** | **`~/docs/`** — product_design, claude_docs, learning only |
| Local `~/research/` (empty git, overlapping copies) | **`~/research/`** — canonical git clone of `mustrockux/claude-research` |

## Step 1 — Research merge (no deletes)

| Action | Detail |
|---|---|
| Pre-merge backup | Copied entire former `~/research/` (excl. `.git`) → `~/research/_archive/pre-reorg-2026-09-30/` |
| Removed empty git | Deleted uncommitted `~/research/.git` |
| Canonical merge | Rsynced `~/docs/claude_research/` → `~/research/` (including `.git`, remote `mustrockux/claude-research`) |
| Content duplicates | Same-hash files: canonical from claude_research. Differing copies archived → `~/research/_archive/duplicates/*.from-old-research-root*` |
| Product source docs | `PRD - Integration Hub.md`, learning plan, overview PDF moved from old `~/research/integrations/` → `~/research/_archive/from-old-research-root/` (canonical product docs: `~/projects/chrono-casestudy/source-docs/`) |
| Docs pointer | Replaced `~/docs/claude_research/` repo with **`MOVED.md`** → points to `~/research` |

## Step 2 — Dedupe (archive only)

| Asset | Canonical home | Action |
|---|---|---|
| Figma `.fig` / `.jam` | `~/docs/product_design/figma_files/` | Already correct; `chrono-casestudy/docs/product-design/figma_files/` is README pointer only |
| Design narrative (Integrations Hub) | `~/projects/chrono-casestudy/source-docs/design-narrative-integrations-hub.md` | No duplicate copies archived |
| Persona / interview `.md` outside research | — | None found under `~/projects` or `~/docs` (excl. node_modules) |

## Step 3 — Hub READMEs

| Path | Status |
|---|---|
| `~/projects/README.md` | Created |
| `~/docs/README.md` | Updated (research moved out of docs tree) |
| `~/research/README.md` | Updated local path + reorg note |
| `~/research/RESEARCH-INDEX.md` | Path references updated |

## Step 4 — Cross-reference updates

Replaced in `*.md`, `*.mdc`, and skill files under `~/projects`, `~/docs`, `~/research`:

- `~/docs/claude_research` → `~/research`
- `/Users/rmustafa/docs/claude_research` → `/Users/rmustafa/research`
- `~/Projects/` → `~/projects/`
- `/Users/rmustafa/Projects/` → `/Users/rmustafa/projects/`

Touched repos/files include: `chrono-casestudy` (CLAUDE.md, README.md), `docs/product_design` (README, persona-review & synthetic-research skills), `docs/claude_docs/README.md`, `research` index files.

## Canonical homes (quick reference)

| Content | Location |
|---|---|
| Code / prototypes | `~/projects/` |
| Agent skills & Figma binaries | `~/docs/product_design/` |
| Templates | `~/docs/claude_docs/` |
| Career / course PDFs | `~/docs/learning/` |
| Synthetic personas & interviews | `~/research/` → GitHub `mustrockux/claude-research` |
| PRD, design narrative, case study | `~/projects/chrono-casestudy/source-docs/` |

## Push record (main @ mustrockux)

| Repo | Path | Commit SHA |
|---|---|---|
| claude-research | `~/research` | `3df7d30` |
| product-design | `~/docs/product_design` | `dc7346582683d5b0f7230ba4ee7c290b1e68dd11` |
| Learning | `~/docs/learning` | `e4e3f985f1b046ed873f15a475e1eb7ed7b0712e` (unchanged) |
| chrono-casestudy | `~/projects/chrono-casestudy` | `892b764` (clone instructions → `~/docs/README.md`) |
| xcor-integrations-make | `~/projects/xcor-integrations-make` | `5663c6a5c5f688f2fe3b71a7e397bc43c426ed57` (unchanged) |
| synthetics | `~/projects/synthetics` | `f3cf7707dfc821422df62c277589d5abe7b23349` (unchanged) |

## Local-only hub files (not in a git repo)

- `~/REORG-CHANGELOG-2026-09-30.md` (copy also in this repo)
- `~/docs/README.md`, `~/docs/REORG-NOTE.md`
- `~/docs/claude_research/MOVED.md`
- `~/projects/README.md`, `~/projects/REORG-NOTE.md`

## Follow-up (post-reorg)

| Date | Action |
|---|---|
| 2026-09-30 | chrono-casestudy `892b764`: `CLAUDE.md` + `README.md` reference `~/docs/README.md` for sibling clone layout |
| 2026-09-30 | Added **Clone repos** section to local `~/docs/README.md` so that cross-reference resolves |

---

*Generated during 2026-09-30 reorg automation.*
