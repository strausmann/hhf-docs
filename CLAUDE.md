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
- **Upstream PRs via dedicated branch**: Work on feature branches in the fork submodule,
  merge to a `docs-contribution` branch (not main), then create upstream PR from there.
  This keeps our main clean and allows multiple parallel topics.
- PRs to upstream: Author `Bjoern Strausmann <bjoern@strausmann.net>`
- **No Co-Authored-By Claude in upstream PRs**

### Target Audience

The documentation targets **HomeLab beginners** who are experimenting with Docker —
not experienced DevOps engineers. Every page must be understandable without deep IT knowledge.

**Mandatory rules:**
- No implicit assumptions about prior knowledge
- Show complete commands (not just snippets), including expected output
- Explain technical terms on first use
- Document error scenarios and how to fix them
- Every step explains what happens and what the user should see
- "If you see X, do Y" patterns for troubleshooting

### Community Sources (Pflicht)

**Before writing any new page**, research these community sources for common questions:

- **Forum:** https://forum.hhf.technology/ — If a user had to ask there, the docs were unclear
- **Discord:** HHF Technology Discord — Maintainer answers and user workarounds
- **GitHub Issues:** Both upstream repos — Feature requests often reveal missing docs

**Every forum/Discord question about a documented topic is a docs bug.**
Integrate the answer into the documentation, not just the forum thread.

### Environment Separation (Strict)

| Environment | Purpose | Access |
|------------|---------|--------|
| **Production** (crowdsec.strausmann.cloud etc.) | Personal HomeLab | **OFF LIMITS — never use for testing, screenshots, or docs** |
| **Test** (test-crowdsec.strausmann.cloud etc.) | Release testing, screenshots, feature verification | Dedicated instances on hhdocker01 |
| **Staging** (docs-crowdsec.strausmann.cloud etc.) | Documentation preview | Fumadocs builds from this repo |

**NEVER use production instances for documentation work. Always use dedicated test instances.**

### Documentation Style

- Use Fumadocs MDX components where available (Callout, Card, Tab, Step)
- Screenshots: Only from **test instances**, never from production
- Tables: Always sorted alphabetically
- API docs: Include complete request/response examples with realistic data
- Getting Started pages: Step-by-step with numbered instructions
- Configuration pages: Show defaults, explain every option, give examples

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
