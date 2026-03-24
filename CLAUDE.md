# CLAUDE.md — HHF Technology Documentation Contributions

## Project Overview

This repository manages documentation contributions for two HHF Technology open-source projects:

1. **CrowdSec Manager** — Web-based management interface for CrowdSec security stack
2. **Middleware Manager** — Custom middleware management for Pangolin/Traefik resources

Both projects use **Fumadocs** (Next.js/React) for their documentation sites.

## Repository Structure

```
hhf-docs/
├── .claude/                    # Claude Code configuration
├── projects/
│   ├── crowdsec-manager/       # Git Submodule: strausmann/crowdsec_manager fork
│   └── middleware-manager/     # Git Submodule: strausmann/middleware-manager fork
├── analysis/                   # Gap analyses, feature inventories
├── staging/                    # Dockerfile, docker-compose, nginx config
├── .github/workflows/          # CI/CD for Docker builds
├── Makefile                    # Build, serve, deploy targets
└── CLAUDE.md                   # This file
```

## Language

- **English** for upstream documentation (MDX files, PR descriptions, commit messages)
- **German** for internal planning, analysis, and comments in this repo

## Conventions

### Git

- Commit messages: English, Conventional Commits format
  - `docs:` — Documentation content changes
  - `fix:` — Corrections, typos, broken links
  - `feat:` — New documentation pages
  - `chore:` — Build tooling, CI/CD, maintenance
- Branch naming: `crowdsec/<topic>` or `middleware/<topic>`
- PRs to upstream: Author `Bjoern Strausmann <bjoern@strausmann.net>`
- **No Co-Authored-By Claude in upstream PRs**

### Documentation

- Follow the existing style of each project (don't introduce new patterns)
- Use Fumadocs MDX components where available (Callout, Card, Tab, Step)
- Screenshots: Only add if they show something not obvious from text
- Tables: Always sorted alphabetically
- API docs: Include request/response examples with realistic data

### Workflow

1. Work in the submodule (e.g. `projects/crowdsec-manager/docs/`)
2. Build locally: `make docs-crowdsec-build`
3. Test staging: `make docs-crowdsec-serve` (http://localhost:8081)
4. Commit in the submodule, push to fork
5. Create PR from fork to upstream
6. Update submodule pointer in this repo

### Issues

- No issue required for small fixes (typos, corrections)
- Issue required for new pages and major reworks
- Use labels: `project:crowdsec-manager`, `project:middleware-manager`
- Use phase labels: `phase:1-critical`, `phase:2-api`, `phase:3-guides`

## Staging

| Project | URL | Port |
|---------|-----|------|
| CrowdSec Manager Docs | https://docs-crowdsec.strausmann.cloud | 8081 |
| Middleware Manager Docs | https://docs-middleware.strausmann.cloud | 8082 |

Both staging environments run on hhdocker01 via Pangolin.

## Build

```bash
make help                    # Show all targets
make docs-crowdsec-build     # Build CrowdSec Manager Docs Docker image
make docs-middleware-build   # Build Middleware Manager Docs Docker image
make docs-crowdsec-serve     # Serve locally on port 8081
make docs-middleware-serve   # Serve locally on port 8082
```

## CI/CD Pipeline

```
Push to main → GitHub Actions → Docker Build → GHCR Push → hhdocker01 pulls latest
PR created   → GitHub Actions → Docker Build → GHCR Push (pr-<number> tag) → PR Comment with image
```

Images: `ghcr.io/strausmann/docs-crowdsec-manager` and `ghcr.io/strausmann/docs-middleware-manager`

See [WORKFLOW.md](WORKFLOW.md) for the complete contribution process.

## Learnings (Pflicht)

Jeder Fehler, jedes Problem, jeder Workaround wird dokumentiert:

1. Eintrag in `learnings/<topic>.md` erstellen
2. Fix in den betroffenen Skill/Agent/Dockerfile integrieren
3. Checkliste im Learning abhaken

**Nie dasselbe Problem zweimal debuggen — einmal loesen, fuer immer dokumentieren.**

## Upstream Repositories

- CrowdSec Manager: https://github.com/hhftechnology/crowdsec_manager
- Middleware Manager: https://github.com/hhftechnology/middleware-manager
- Fumadocs: https://fumadocs.dev/
