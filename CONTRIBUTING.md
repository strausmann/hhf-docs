# Contributing Guide — HHF Docs

This document describes how we organize work, manage issues, create pull requests, and use the GitHub Project board in this repository.

## Table of Contents

- [Overview](#overview)
- [GitHub Project Board](#github-project-board)
- [Issues](#issues)
- [Branches and Pull Requests](#branches-and-pull-requests)
- [Review Process](#review-process)
- [Upstream PR Workflow](#upstream-pr-workflow)
- [Labels Reference](#labels-reference)
- [Automation](#automation)

---

## Overview

This repository coordinates documentation contributions for two HHF Technology projects. All work flows through GitHub Issues → Project Board → Pull Requests → Upstream PRs.

```
Forum/Discord Research → Issue Created → Project Board (Backlog)
    → Branch Created → Docs Written → PR to this repo
    → Staging Preview → Review → Merge to main
    → Upstream PR to hhftechnology/* → Maintainer Review → Merged
```

**Key principle:** Nothing gets implemented without a clear issue. Nothing gets merged without staging verification.

---

## GitHub Project Board

**URL:** https://github.com/users/strausmann/projects/1

### Board Views

| View | Filter | Purpose |
|------|--------|---------|
| **Board** (default) | Status columns | See what's in progress |
| **By Phase** | Group by Phase | Plan which phase to work on |
| **By Team** | Group by Team | See team workload |
| **By Project** | Group by Projekt | Focus on one product |

### Status Columns

Every issue moves through these stages:

```
Todo → In Progress → Done
```

Additionally, use these **status labels** on issues for finer tracking:

| Label | Meaning | When to use |
|-------|---------|-------------|
| `status:draft` | Issue exists but scope not finalized | New issues (auto-applied) |
| `status:needs-clarification` | Waiting for answers (maintainer, community) | Questions open in issue |
| `status:blocked` | Cannot proceed (dependency, missing test env) | Depends on another issue |
| `status:waiting-for-input` | Waiting for team member or reviewer | PR submitted, waiting |
| `status:in-review` | Work done, under review | PR open, staging live |
| `status:ready-for-upstream` | Reviewed and approved, ready to PR upstream | After staging sign-off |
| `status:merged` | Upstream PR merged | Done, can close |

### Custom Fields

| Field | Purpose | Values |
|-------|---------|--------|
| **Phase** | Which documentation phase | 1-Critical, 2-API, 3-Guides, 4-Static-Export, Infra |
| **Team** | Responsible team | PM, Dev, Marketing, Ops |
| **Projekt** | Which product | CrowdSec Manager, Middleware Manager, Both |
| **Effort** | Estimated work | S (<2h), M (2-4h), L (4-8h), XL (>8h) |

### How to Update the Board

Issues are auto-added to the board when created. To update status:
1. Open the issue on the project board
2. Drag to the appropriate column (Todo → In Progress → Done)
3. Update the status label on the issue itself

---

## Issues

### Creating Issues

Always use one of the **issue templates** (blank issues are disabled):

| Template | When to use |
|----------|-------------|
| **New Documentation Page** | A new MDX page needs to be created |
| **Documentation Correction** | Existing content is wrong or outdated |
| **API Documentation** | API endpoints need to be documented |
| **Infrastructure Task** | CI/CD, staging, Docker, tooling |

### Issue Lifecycle

```
1. Created (status:draft)
   └── Auto-added to Project Board (Todo column)
   └── Auto-labeled status:draft

2. Clarified (90% clarity)
   └── Scope, acceptance criteria, team assignment defined
   └── Community research done (Forum, Discord, GitHub Issues)
   └── Remove status:draft, issue moves to "ready to work"

3. In Progress
   └── Branch created, work started
   └── Move to "In Progress" on board

4. Review
   └── PR created against this repo
   └── Staging preview available
   └── Label: status:in-review

5. Approved
   └── PR merged to main
   └── Staging updated automatically
   └── Label: status:ready-for-upstream

6. Upstream PR
   └── PR created from fork to hhftechnology/*
   └── Maintainer reviews (can use our staging URL)

7. Done
   └── Upstream PR merged
   └── Label: status:merged
   └── Issue closed, board column: Done
```

### Issue Conventions

- **Title format:** `[project-name] Brief description` (e.g. `[crowdsec-manager] Document Hub Browser feature`)
- **Language:** English (upstream is English)
- **Acceptance criteria:** Every issue must have testable acceptance criteria
- **Community reference:** Link relevant Forum/Discord threads in the issue
- **Dependencies:** Reference blocking issues with `Blocked by #14`
- **Effort estimate:** Set the Effort field (S/M/L/XL) before starting work

---

## Branches and Pull Requests

### Branch Naming

```
crowdsec/<topic>        # CrowdSec Manager docs changes
middleware/<topic>       # Middleware Manager docs changes
infra/<topic>           # Build tooling, CI/CD, staging
```

Examples:
```
crowdsec/fix-api-architecture
crowdsec/document-hub-browser
middleware/add-security-hub-tls
infra/add-forum-scan-workflow
```

### Creating a Branch

Work happens in the **submodule** (the fork), not in the main repo:

```bash
# Navigate to the submodule
cd projects/crowdsec-manager

# Create feature branch
git checkout -b crowdsec/document-hub-browser

# Make changes in docs/
vi docs/content/docs/features/hub-browser.mdx

# Commit in the submodule
git add docs/
git commit -m "docs: add Hub Browser documentation"
git push origin crowdsec/document-hub-browser
```

Then update the submodule reference in the main repo:

```bash
cd ../..  # back to hhf-docs root
git checkout -b crowdsec/document-hub-browser
git add projects/crowdsec-manager
git commit -m "docs: update submodule for hub browser docs"
git push origin crowdsec/document-hub-browser
```

### Pull Request to This Repo

```bash
gh pr create --title "[crowdsec-manager] Document Hub Browser feature" \
  --body "Closes #3

## Changes
- New page: content/docs/features/hub-browser.mdx
- Updated navigation: meta.json

## Staging Preview
After merge, preview at: https://docs-crowdsec.strausmann.cloud/docs/features/hub-browser

## Checklist
- [ ] Fumadocs build passes (docs-lint workflow)
- [ ] Staging preview looks correct
- [ ] Community research done (Forum threads linked)
- [ ] Written for beginners (no assumed knowledge)"
```

### PR Review Checklist

Before approving a PR, verify:

- [ ] **Builds:** docs-lint workflow passes
- [ ] **Staging:** Preview looks correct on staging URL
- [ ] **Accuracy:** Technical content verified against source code
- [ ] **Audience:** Written for HomeLab beginners
- [ ] **Community:** Forum/Discord questions about this topic addressed
- [ ] **Components:** Fumadocs MDX components used appropriately
- [ ] **Navigation:** meta.json updated if new pages added
- [ ] **Screenshots:** From test instance only (never production)

---

## Upstream PR Workflow

After changes are merged to our `main` branch and verified on staging:

### 1. Prepare the Fork

```bash
cd projects/crowdsec-manager

# Ensure fork is synced with upstream
gh repo sync strausmann/crowdsec_manager

# Create a clean branch from main for the upstream PR
git checkout main && git pull
git checkout -b docs/hub-browser-feature

# Cherry-pick or merge the relevant commits
git cherry-pick <commit-hash>
git push origin docs/hub-browser-feature
```

### 2. Create Upstream PR

```bash
gh pr create --repo hhftechnology/crowdsec_manager \
  --head strausmann:docs/hub-browser-feature \
  --title "docs: add Hub Browser feature documentation" \
  --body "## Summary
Adds documentation for the Hub Browser feature.

## Preview
Live preview: https://docs-crowdsec.strausmann.cloud/docs/features/hub-browser

## Changes
- New page: docs/content/docs/features/hub-browser.mdx
- Updated navigation meta.json

## Source
Based on code analysis of internal/api/handlers/ and web/src/pages/Hub*"
```

### 3. After Upstream Merge

```bash
# Sync fork
gh repo sync strausmann/crowdsec_manager

# Update submodule
cd projects/crowdsec-manager && git checkout main && git pull
cd ../..
git add projects/crowdsec-manager
git commit -m "chore: sync submodule after upstream merge of hub browser docs"
git push
```

---

## Labels Reference

### Category: scope (Feature areas)

**CrowdSec Manager** (green): scope:alerts, scope:allowlists, scope:appsec, scope:backups, scope:bouncers, scope:captcha, scope:config-validation, scope:cron-jobs, scope:dashboard, scope:decisions, scope:health, scope:history, scope:hub, scope:ip-management, scope:logs, scope:multi-host, scope:notifications, scope:profiles, scope:scenarios, scope:simulation, scope:terminal, scope:updates, scope:whitelist

**Middleware Manager** (blue): scope:external-middlewares, scope:middlewares, scope:mtls, scope:plugin-hub, scope:proxy-mode, scope:rate-limiting, scope:resources, scope:secure-headers, scope:security-hub, scope:services, scope:tls-hardening, scope:traefik-explorer, scope:traefik-integration

**Cross-cutting** (blue): scope:api-docs, scope:architecture, scope:configuration, scope:deployment, scope:getting-started, scope:troubleshooting

### Category: type

type:new-page, type:correction, type:api-docs, type:screenshot, type:example, type:env-vars, type:guide, type:refactor, type:typo

### Category: status

status:draft, status:in-review, status:ready-for-upstream, status:merged, status:needs-clarification, status:waiting-for-input, status:blocked

### Category: priority

priority:critical, priority:high, priority:medium, priority:low

### Category: phase

phase:1-critical, phase:2-api, phase:3-guides, phase:4-static-export

### Category: team

team:pm, team:dev, team:marketing, team:ops

### Category: project

project:crowdsec-manager, project:middleware-manager

---

## Automation

### GitHub Actions Workflows

| Workflow | Trigger | What it does |
|----------|---------|-------------|
| **build-crowdsec-docs** | Push to main (docs changed) | Build Docker image → push to GHCR |
| **build-middleware-docs** | Push to main (docs changed) | Build Docker image → push to GHCR |
| **pr-preview** | Pull Request | Build preview image, comment PR with pull command |
| **docs-lint** | Pull Request | Validate Fumadocs build compiles without errors |
| **sync-forks** | Daily 06:00 UTC | Sync forks with upstream, update submodules |
| **issue-triage** | Issue created | Auto-add to project board, label status:draft |
| **stale-check** | Mondays 09:00 UTC | Remind about issues inactive for 14+ days |
| **forum-scan** | Mondays 08:00 UTC | Scan HHF Forum for new user questions |

### GitHub Projects Built-in Automations

| Automation | What it does |
|-----------|-------------|
| Auto-add sub-issues | Sub-issues automatically appear on the board |
| Auto-close issue | Issues with merged PRs auto-close |
| Item added to project | New items appear in Todo column |
| Item closed | Closed items move to Done |
| PR linked to issue | Links PR to issue on the board |
| PR merged | Updates board when PR is merged |

---

## Quick Reference

### Start working on an issue

```bash
# 1. Check the board for Todo items
open https://github.com/users/strausmann/projects/1

# 2. Pick an issue, read it carefully

# 3. Research community sources
open https://forum.hhf.technology/
# Search for related user questions

# 4. Create branch and start working
cd projects/crowdsec-manager
git checkout -b crowdsec/<topic>

# 5. Build and test locally
cd ../..
make docs-crowdsec-build
make docs-crowdsec-serve
# Open http://localhost:8081

# 6. Create PR when ready
gh pr create --title "[crowdsec-manager] ..."
```

### Common Commands

```bash
make help                       # List all targets
make docs-crowdsec-build        # Build CS docs image
make docs-crowdsec-serve        # Serve CS docs locally (:8081)
make docs-middleware-build      # Build MW docs image
make docs-middleware-serve      # Serve MW docs locally (:8082)
make submodules-update          # Sync submodules with upstream
make build-all                  # Build both images
```
