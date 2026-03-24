# Copilot Instructions — HHF Docs

## Context
This repository coordinates documentation contributions for HHF Technology projects
(CrowdSec Manager, Middleware Manager). Both use Fumadocs (Next.js/React).

## Review Focus
When reviewing PRs, focus on:
- **Technical accuracy**: Does the documentation match the actual source code?
- **Audience**: Written for HomeLab beginners, not DevOps professionals
- **Fumadocs components**: Correct usage of Callout, Card, Tab, Step, Accordion
- **MDX syntax**: Valid MDX, no broken imports, correct frontmatter
- **Links**: No broken internal links, correct navigation references
- **English**: Clear, concise, no jargon without explanation

## Do NOT flag
- German language in files under `analysis/`, `learnings/`, `CLAUDE.md` (internal docs are German)
- Submodule pointer changes (these are intentional)
- Missing screenshots (placeholder divs are expected until test instances are ready)

## Project Structure
- `projects/crowdsec-manager/` — Git submodule (fork of hhftechnology/crowdsec_manager)
- `projects/middleware-manager/` — Git submodule (fork of hhftechnology/middleware-manager)
- `analysis/` — Gap analyses and planning (German, internal)
- `staging/` — Docker build files
- `learnings/` — Lessons learned (German, internal)
