# HHF Docs Content Plan

**Date:** 2026-03-24
**Scope:** CrowdSec Manager + Middleware Manager documentation sites
**Framework:** Fumadocs (Next.js 16 + fumadocs-ui 16.2.2)

---

## Table of Contents

1. [CrowdSec Manager](#1-crowdsec-manager)
   - [A) Page Structure Plan](#1a-page-structure-plan)
   - [B) Content Styleguide](#1b-content-styleguide)
   - [C) Prioritized Content Roadmap](#1c-prioritized-content-roadmap)
2. [Middleware Manager](#2-middleware-manager)
   - [A) Page Structure Plan](#2a-page-structure-plan)
   - [B) Content Styleguide](#2b-content-styleguide)
   - [C) Prioritized Content Roadmap](#2c-prioritized-content-roadmap)
3. [Cross-Project Standards](#3-cross-project-standards)

---

# 1. CrowdSec Manager

## 1A) Page Structure Plan

### Current State: 35 MDX files, ~1,500 lines total, avg ~43 lines/page

### Pages to KEEP (no major changes needed)

| File | Notes |
|------|-------|
| `features/alerts.mdx` | Good structure, uses Fumadocs components |
| `features/decisions.mdx` | Best-in-class page -- uses Steps, Callout, covers filtering/import/export |
| `features/captcha.mdx` | Solid, covers setup + detection |
| `features/allowlists.mdx` | Adequate |
| `features/whitelist-management.mdx` | Adequate |
| `configuration/networking.mdx` | Adequate |
| `configuration/volumes.mdx` | Adequate |
| `api/backup.mdx` | Mostly correct (add `/latest` endpoint) |
| `api/health.mdx` | Correct |
| `api/ip.mdx` | Correct |
| `api/logs.mdx` | Correct |
| `api/whitelist.mdx` | Correct |

### Pages to REWORK (with specific changes)

| File | Required Changes |
|------|-----------------|
| `index.mdx` | (1) Update version to 2.1.0. (2) Remove "Multi-proxy support: not available" (multi-host exists). (3) Add Cards navigation like MW docs. (4) Mention Hub, History, Config Validation in feature list. |
| `installation.mdx` | (1) Add Pangolin deployment section (docker-compose.pangolin.yml). (2) Add Tailscale sidecar example. (3) Add Helm/K8s pointer. |
| `quick-start.mdx` | (1) Verify compose snippets match current docker-compose.yml. (2) Add "verify installation" step with health endpoint. |
| `screenshots.mdx` | (1) Replace with actual screenshots or convert to feature-overview gallery. (2) Consider removing as standalone page -- distribute screenshots into feature pages instead. |
| `configuration/environment.mdx` | (1) Add ALL 40+ env vars from config.go (currently only 9). (2) Group by category: Core, Docker, CrowdSec Paths, Feature Flags, Performance, NATS, Timeouts. (3) Use table format with Variable / Default / Description columns. |
| `configuration/notifications.mdx` | (1) Document Discord webhook setup end-to-end. (2) Add notification templates. (3) Add repeated-offender notifications. |
| `configuration/service-api.mdx` | (1) Verify all described env vars still exist. (2) Add rate-limiting middleware info. |
| `configuration/settings.mdx` | (1) Expand beyond stub. (2) Document UI settings page. |
| `features/dashboard.mdx` | (1) Add GeoIP visualization. (2) Add aggregated metrics description. (3) Add chart types. (4) Reference dashboard_analysis.go capabilities. |
| `features/engines.mdx` | (1) Verify bouncer management operations match current API. |
| `features/health.mdx` | (1) Add `/health/complete` endpoint. (2) Document diagnostic checks. |
| `features/scenarios.mdx` | (1) Add file management (upload/delete). (2) Reference Hub Browser for scenario installation. |
| `features/remediation.mdx` | (1) Add metrics dashboard description. |
| `features/profiles.mdx` | (1) Expand stub into real content. (2) Document profile YAML structure. |
| `features/ip-management.mdx` | (1) Expand stub. (2) Document security check feature. |
| `features/backups.mdx` | (1) Add restore flow. (2) Add cleanup/retention. (3) Add latest-backup endpoint. |
| `features/cron-jobs.mdx` | (1) Expand from 21-line stub. (2) Document job types and scheduling. |
| `features/logs-monitoring.mdx` | (1) Add structured logs. (2) Add log streaming (SSE). (3) Add advanced Traefik log analysis. |
| `features/stack-updates.mdx` | (1) Document with-crowdsec vs without-crowdsec update paths. |
| `development/architecture.mdx` | (1) Fix router: chi -> gin-gonic/gin. (2) Add messaging system (NATS/WS/SSE). (3) Add history service. (4) Add config validator. (5) Add multi-host client. (6) Add cache layer. (7) Update Go version to 1.23+. |
| `development/contributing.mdx` | (1) Fix `go run main.go` -> `go run cmd/server/main.go`. (2) Fix Go 1.21 -> 1.23+. (3) Add `air` hot-reload. (4) Add Docker dev setup (Dockerfile.dev). |
| `api/overview.mdx` | (1) Fix response format: `"status": "success"` -> `models.Response` with `"success": true/false`. (2) Add rate-limiting middleware docs. (3) Add Docker-host middleware docs. (4) Add complete endpoint table. |
| `api/docker.mdx` | **DELETE or REPLACE entirely.** Describes endpoints that do not exist (`/api/docker/containers`, `/api/docker/container/:action`). Replace with `api/services.mdx` covering `/api/services/*` and `api/updates.mdx` covering `/api/update/*`. |

### NEW Pages to Create

| File | Content | Priority |
|------|---------|----------|
| `features/hub-browser.mdx` | Hub home, category browsing, install/remove/upgrade, manual-apply, preferences, history. 8 nav entries in UI, 12 API endpoints, zero docs. | HIGH |
| `features/history.mdx` | Decision/alert history, repeated offender detection, retention config, stats. Own nav page in UI. | HIGH |
| `features/config-validation.mdx` | Drift detection, snapshots, restore, accept. Own nav page, 6 API endpoints. | HIGH |
| `features/terminal.mdx` | WebSocket shell into containers. Security considerations. | MEDIUM |
| `features/simulation.mdx` | Simulation mode toggle, what it does, when to use it. | MEDIUM |
| `features/multi-host.mdx` | DOCKER_HOSTS config, host switching, use cases. | MEDIUM |
| `installation-pangolin.mdx` | Dedicated Pangolin deployment guide using docker-compose.pangolin.yml. | HIGH |
| `installation-kubernetes.mdx` | Helm chart deployment from `charts/` directory. Values reference, examples. | MEDIUM |
| `guides/tailscale-sidecar.mdx` | Tailscale sidecar pattern from README example. | LOW |
| `guides/repeated-offenders.mdx` | Background detection, notification integration, reapply workflow. | MEDIUM |
| `guides/decision-import.mdx` | CSV import format, bulk operations, reapply. | MEDIUM |
| `guides/migration-v2.mdx` | Migration from 1.x to 2.x. Breaking changes, new features. | LOW |
| `guides/troubleshooting.mdx` | Common issues, diagnostic steps, log interpretation. | MEDIUM |
| `api/crowdsec.mdx` | Bouncers, decisions (CRUD + import + analysis + history + repeated-offenders + reapply + bulk-reapply), alerts (analysis + history + inspect/delete), metrics, enroll. 20+ endpoints. | HIGH |
| `api/allowlist.mdx` | 7 endpoints for LAPI-level allowlists. | MEDIUM |
| `api/captcha.mdx` | 5 endpoints for captcha/appsec setup and config. | MEDIUM |
| `api/scenarios.mdx` | 4 endpoints for scenario management. | MEDIUM |
| `api/services.mdx` | Replaces docker.mdx. 3 endpoints for service verification and actions. | HIGH |
| `api/updates.mdx` | 3 endpoints for stack updates. | MEDIUM |
| `api/notifications.mdx` | 6 endpoints for Discord notification config. | LOW |
| `api/config-validation.mdx` | 6 endpoints for drift detection. | MEDIUM |
| `api/hub.mdx` | 12 endpoints for hub browser. | MEDIUM |
| `api/simulation.mdx` | 2 endpoints. | LOW |
| `api/events.mdx` | SSE + WebSocket real-time event streams. | LOW |
| `api/cron.mdx` | 3 endpoints. | LOW |
| `api/profiles.mdx` | 2 endpoints. | LOW |
| `api/hosts.mdx` | 1 endpoint for multi-host listing. | LOW |
| `api/terminal.mdx` | WebSocket terminal endpoint. | LOW |

### Target Navigation (meta.json)

**Root `meta.json`:**
```json
{
  "pages": [
    "index",
    "installation",
    "installation-pangolin",
    "installation-kubernetes",
    "quick-start",
    "features",
    "configuration",
    "guides",
    "api",
    "development"
  ]
}
```

**`features/meta.json`:**
```json
{
  "title": "Features",
  "pages": [
    "dashboard",
    "engines",
    "health",
    "alerts",
    "decisions",
    "history",
    "remediation",
    "scenarios",
    "captcha",
    "hub-browser",
    "allowlists",
    "whitelist-management",
    "profiles",
    "ip-management",
    "simulation",
    "config-validation",
    "multi-host",
    "terminal",
    "backups",
    "cron-jobs",
    "logs-monitoring",
    "stack-updates"
  ]
}
```

**`guides/meta.json`** (NEW section):
```json
{
  "title": "Guides",
  "pages": [
    "repeated-offenders",
    "decision-import",
    "tailscale-sidecar",
    "migration-v2",
    "troubleshooting"
  ]
}
```

**`api/meta.json`:**
```json
{
  "title": "API Reference",
  "pages": [
    "overview",
    "crowdsec",
    "allowlist",
    "captcha",
    "scenarios",
    "services",
    "updates",
    "notifications",
    "config-validation",
    "hub",
    "simulation",
    "events",
    "cron",
    "hosts",
    "profiles",
    "terminal"
  ]
}
```

**`configuration/meta.json`** (unchanged):
```json
{
  "pages": [
    "service-api",
    "notifications",
    "settings",
    "environment",
    "networking",
    "volumes"
  ]
}
```

**`development/meta.json`** (unchanged):
```json
{
  "pages": [
    "architecture",
    "contributing"
  ]
}
```

**Remove:** `screenshots.mdx` from root navigation. Distribute screenshots into individual feature pages.

---

## 1B) Content Styleguide

### Existing Style Analysis

**Strengths:**
- Consistent frontmatter (`title` + `description`)
- Good use of Fumadocs components in newer pages (Steps, Callout in `decisions.mdx`)
- Clear H2/H3 hierarchy
- Bullet-point-driven explanations

**Weaknesses:**
- Most pages are stubs (25-55 lines) with no depth
- Inconsistent component usage -- some pages use Fumadocs components, most do not
- No screenshots despite a dedicated screenshots page
- No code examples for API endpoints (no curl/fetch examples)
- Older pages read like feature lists rather than user guides

### Style Recommendations

**Voice and Tone:**
- Second person ("you can", "your CrowdSec instance")
- Active voice, imperative for instructions
- Brief intro paragraph (1-2 sentences) explaining what the feature does and why it matters
- No marketing language -- direct and technical

**Page Structure Template:**
```
---
title: Feature Name
description: One-line summary
---

import { Steps } from 'fumadocs-ui/components/steps';
import { Callout } from 'fumadocs-ui/components/callout';
import { Tab, Tabs } from 'fumadocs-ui/components/tabs';

# Feature Name

Brief intro: what it does, when you need it.

## Prerequisites (if applicable)

## How It Works (conceptual overview)

## Usage
<Steps> ... </Steps>

## Configuration (if applicable)

## API Reference (link to API section)

## Troubleshooting (common issues)
```

**Minimum page length target:** 80-120 lines (currently avg 43).

**Fumadocs Components to Use:**
- `<Steps>` for all multi-step workflows
- `<Callout type="info|warn|error">` for important notes, warnings, destructive actions
- `<Tabs>` for Docker Compose vs Helm, or different deployment modes
- `<Cards>` for navigation hubs (index page, feature overview)
- `<Tab>` for API request/response examples (curl / JavaScript / Go)
- Code blocks with language hints for all config snippets and API examples

**Screenshot Strategy:**
- Screenshots for: Dashboard, Hub Browser, Config Validation, Terminal, Security features
- No screenshots for: API reference pages, environment variable tables, architecture
- Format: PNG, dark mode, 1200px wide, cropped to relevant UI area
- Store in `docs/public/images/features/` with naming `{feature}-{description}.png`
- Use `<img>` with alt text, not raw markdown images (for sizing control)

---

## 1C) Prioritized Content Roadmap

### Phase 1: Critical Gaps (highest user impact) -- Est. 3-4 days

These are features that exist in the UI navigation but have zero documentation.

| # | Task | Depends On | Est. |
|---|------|-----------|------|
| 1 | Rework `index.mdx` (version, features list, Cards nav) | Nothing | 1h |
| 2 | Rework `configuration/environment.mdx` (9 -> 40+ vars) | team:dev to extract all vars from config.go | 3h |
| 3 | Create `features/hub-browser.mdx` | team:dev for Hub API behavior | 3h |
| 4 | Create `features/history.mdx` | team:dev for history service internals | 2h |
| 5 | Create `features/config-validation.mdx` | team:dev for validator logic | 2h |
| 6 | Fix `development/architecture.mdx` (chi->gin, add systems) | team:dev for architecture review | 2h |
| 7 | Fix `development/contributing.mdx` (paths, versions, dev setup) | Nothing | 1h |
| 8 | Delete `api/docker.mdx`, create `api/services.mdx` + `api/updates.mdx` | team:dev for endpoint verification | 2h |
| 9 | Fix `api/overview.mdx` (response format, middleware docs) | Nothing | 1h |
| 10 | Create `installation-pangolin.mdx` | team:dev for compose file review | 2h |

### Phase 2: Feature Page Depth (parallel work) -- Est. 3-4 days

Expand existing stubs to full pages. Can be done in parallel by multiple contributors.

| # | Task | Depends On | Est. |
|---|------|-----------|------|
| 11 | Expand `features/dashboard.mdx` (GeoIP, charts, metrics) | Screenshots | 2h |
| 12 | Expand `features/profiles.mdx` | team:dev for YAML structure | 1.5h |
| 13 | Expand `features/cron-jobs.mdx` | team:dev for job types | 1h |
| 14 | Expand `features/logs-monitoring.mdx` (streaming, structured) | Nothing | 1.5h |
| 15 | Expand `features/backups.mdx` (restore, cleanup, latest) | Nothing | 1h |
| 16 | Expand `features/stack-updates.mdx` (with/without CrowdSec) | Nothing | 1h |
| 17 | Expand `features/ip-management.mdx` | Nothing | 1h |
| 18 | Create `features/terminal.mdx` | Nothing | 1h |
| 19 | Create `features/simulation.mdx` | Nothing | 1h |
| 20 | Create `features/multi-host.mdx` | team:dev for DOCKER_HOSTS behavior | 1.5h |
| 21 | Rework `configuration/notifications.mdx` (Discord, templates) | team:dev for template system | 2h |

### Phase 3: API Reference -- Est. 3-4 days

Systematic API documentation. Requires team:dev to verify endpoint behavior.

| # | Task | Endpoints | Est. |
|---|------|----------|------|
| 22 | `api/crowdsec.mdx` | 20+ | 5h |
| 23 | `api/hub.mdx` | 12 | 3h |
| 24 | `api/allowlist.mdx` | 7 | 1.5h |
| 25 | `api/captcha.mdx` | 5 | 1.5h |
| 26 | `api/notifications.mdx` | 6 | 1.5h |
| 27 | `api/config-validation.mdx` | 6 | 1.5h |
| 28 | `api/scenarios.mdx` | 4 | 1h |
| 29 | `api/events.mdx` | 2 | 1h |
| 30 | Remaining small API pages (simulation, cron, hosts, profiles, terminal) | 9 total | 2h |

### Phase 4: Guides & Polish -- Est. 2 days

| # | Task | Depends On | Est. |
|---|------|-----------|------|
| 31 | `guides/troubleshooting.mdx` | Phases 1-3 complete | 2h |
| 32 | `guides/repeated-offenders.mdx` | team:dev | 1.5h |
| 33 | `guides/decision-import.mdx` | Nothing | 1h |
| 34 | `installation-kubernetes.mdx` | team:dev for Helm chart review | 3h |
| 35 | `guides/tailscale-sidecar.mdx` | Nothing | 1h |
| 36 | `guides/migration-v2.mdx` | team:dev for changelog | 2h |
| 37 | Remove `screenshots.mdx`, add real screenshots to feature pages | Screenshots captured | 3h |

### Dependencies on team:dev

The following tasks require code analysis by the dev agent before docs can be written:

- **config.go full extraction** (needed for env vars page)
- **Hub Browser behavior** (install/upgrade/remove flow, catalogue source)
- **History service internals** (retention, repeated offender logic, sync interval)
- **Config validator logic** (what is validated, snapshot format, drift detection rules)
- **Architecture review** (confirm all subsystems, package structure)
- **Helm chart review** (values.yaml reference, supported configurations)
- **DOCKER_HOSTS multi-host behavior** (format, discovery, switching)
- **Notification template system** (template vars, Discord embed structure)

---

# 2. Middleware Manager

## 2A) Page Structure Plan

### Current State: 20 MDX files (+ 1 test.mdx), well-organized sections

### Pages to KEEP (no major changes needed)

| File | Notes |
|------|-------|
| `getting-started/onboarding.mdx` | Good onboarding flow |
| `getting-started/deploy-pangolin.mdx` | Solid (fix typo only) |
| `getting-started/deploy-standalone.mdx` | Good |
| `configuration/data-sources.mdx` | Well-written |
| `configuration/templates.mdx` | Adequate |
| `ui-guides/dashboard.mdx` | Good structure |
| `ui-guides/middlewares.mdx` | Good |
| `ui-guides/services.mdx` | Solid (4 service types documented) |
| `ui-guides/plugin-hub.mdx` | Good workflow documentation |
| `ui-guides/traefik-explorer.mdx` | Adequate |
| `ui-guides/settings.mdx` | Adequate |
| `operations/runbook.mdx` | Good operational content |
| `operations/troubleshooting.mdx` | Good foundation |
| `operations/backups.mdx` | Adequate |
| `reverting/revert-traefik.mdx` | Important safety content, keep as-is |
| `development/dev-guide.mdx` | Adequate |

### Pages to REWORK (with specific changes)

| File | Required Changes |
|------|-----------------|
| `index.mdx` | (1) Remove screenshot placeholder. (2) Add version info. (3) Update "What you can do" to include TLS Hardening, Secure Headers, External Middlewares. |
| `configuration/config-overview.mdx` | (1) **Critical:** Document API-proxy mode as the DEFAULT (currently describes file-provider as default). (2) Explain `ENABLE_FILE_CONFIG` toggle. (3) Add architecture diagram showing config proxy flow. |
| `configuration/environment.mdx` | (1) Fix `TRAEFIK_API_URL` default: `host.docker.internal:8080` -> `traefik:8080`. (2) Add missing vars: `GENERATE_INTERVAL_SECONDS`, `ENABLE_FILE_CONFIG`, `UI_PATH`, `CONFIG_DIR`. (3) Add Traefik auto-discovery note. |
| `ui-guides/resources.mdx` | (1) Add External Middlewares section (assign Traefik-native middlewares). (2) Add TLS Hardening toggle description. (3) Add Secure Headers toggle description. (4) Replace screenshot placeholder with real screenshot. |
| `ui-guides/security-mtls.mdx` | (1) **Critical:** Rename to "Security Hub" or split into sub-pages. (2) Add TLS Hardening section (global enable/disable + per-resource). (3) Add Secure Headers section (X-Content-Type-Options, X-Frame-Options, HSTS, CSP, etc.). (4) Add Duplicate Detection section. |
| `security/risks.mdx` | (1) Add TLS Hardening risks/considerations. (2) Add Secure Headers impact assessment. |
| `api/overview.mdx` | (1) Add Security endpoints (`/api/security/*`). (2) Add External Middlewares endpoints. (3) Add `bulk-delete-disabled` endpoint. (4) Add pagination/filter query parameters. (5) Remove Swagger placeholder text. |
| `getting-started/deploy-pangolin.mdx` | (1) Fix typo: `TRAFFIC_API_URL` -> `TRAEFIK_API_URL`. |

### Pages to DELETE

| File | Reason |
|------|--------|
| `test.mdx` | Demo/test page with "Hello World". Not linked in navigation but still in file tree. |

### NEW Pages to Create

| File | Content | Priority |
|------|---------|----------|
| `ui-guides/security-hub.mdx` | Comprehensive Security Hub page covering: mTLS (moved from security-mtls.mdx), TLS Hardening (global + per-resource), Secure Headers (global + per-resource config), Duplicate Detection. **Alternative:** expand security-mtls.mdx and rename. | HIGH |
| `configuration/api-proxy.mdx` | Deep-dive into config proxy mode: how it works, caching, merge logic (Pangolin + MM overrides), invalidation, status endpoint. | HIGH |
| `guides/external-middlewares.mdx` | How to assign Traefik-native (non-MM-managed) middlewares to resources. Use cases, limitations. | HIGH |
| `guides/bulk-operations.mdx` | Bulk delete disabled resources, resource filtering by source/status, pagination. | MEDIUM |
| `architecture/how-it-works.mdx` | Config proxy flow diagram, watcher pattern, DB schema overview, resource fetcher abstraction. | MEDIUM |
| `architecture/changelog.mdx` | Release notes, version history. | LOW |
| `guides/faq.mdx` | Common questions from Discord/Issues. | LOW |

### Target Navigation (meta.json)

**Root `meta.json`:**
```json
{
  "title": "Middleware Manager Docs",
  "icon": "BookOpen",
  "pages": [
    "index",
    "getting-started/onboarding",
    "getting-started/deploy-pangolin",
    "getting-started/deploy-standalone",
    "configuration/config-overview",
    "configuration/api-proxy",
    "configuration/data-sources",
    "configuration/templates",
    "configuration/environment",
    "ui-guides/dashboard",
    "ui-guides/resources",
    "ui-guides/middlewares",
    "ui-guides/services",
    "ui-guides/plugin-hub",
    "ui-guides/security-hub",
    "ui-guides/traefik-explorer",
    "ui-guides/settings",
    "security/risks",
    "operations/runbook",
    "operations/troubleshooting",
    "operations/backups",
    "guides/external-middlewares",
    "guides/bulk-operations",
    "api/overview",
    "reverting/revert-traefik",
    "architecture/how-it-works",
    "development/dev-guide"
  ]
}
```

**`configuration/meta.json`:**
```json
{
  "title": "Configuration",
  "pages": [
    "config-overview",
    "api-proxy",
    "data-sources",
    "templates",
    "environment"
  ]
}
```

**`ui-guides/meta.json`:**
```json
{
  "title": "UI Guides",
  "pages": [
    "dashboard",
    "resources",
    "middlewares",
    "services",
    "plugin-hub",
    "security-hub",
    "traefik-explorer",
    "settings"
  ]
}
```

**`guides/meta.json`** (NEW):
```json
{
  "title": "Guides",
  "pages": [
    "external-middlewares",
    "bulk-operations",
    "faq"
  ]
}
```

**`architecture/meta.json`** (NEW):
```json
{
  "title": "Architecture",
  "pages": [
    "how-it-works",
    "changelog"
  ]
}
```

---

## 2B) Content Styleguide

### Existing Style Analysis

**Strengths:**
- Better overall structure than CrowdSec Manager docs
- Consistent use of Fumadocs components (Callout, Cards on index)
- Practical, operator-focused tone
- Good separation of concerns (UI guides vs config vs operations)
- Callout boxes used effectively for warnings

**Weaknesses:**
- 17+ screenshot placeholders never filled (`<div className="mt-6 rounded-xl border border-dashed ...">`)
- Pages are short (avg ~35 lines for UI guides)
- Security section covers only mTLS, missing TLS Hardening + Secure Headers entirely
- No code examples for API calls
- `config-overview.mdx` describes the wrong default mode

### Style Recommendations

**Voice and Tone:**
- Already good -- keep the direct, operator-focused style
- Continue using "you" address
- Keep the warning callouts for destructive or risky operations

**Page Structure Template:**
```
---
title: Feature Name
description: One-line summary
---

import { Callout } from 'fumadocs-ui/components/callout';
import { Steps } from 'fumadocs-ui/components/steps';

# Feature Name

Brief intro: what it does in the MM context.

## Overview (what you see in the UI)

## Workflow
<Steps> ... </Steps>

## Configuration (env vars, settings)

## Tips

<Callout type="warning"> ... </Callout>

## Related
- Link to API overview
- Link to related features
```

**Minimum page length target:** 60-100 lines (currently avg ~35 for UI guides).

**Fumadocs Components to Use:**
- `<Callout type="warning">` -- already used well, continue for all destructive ops
- `<Callout type="info">` -- for "who this is for" and prerequisites
- `<Steps>` -- for all setup workflows (currently underused)
- `<Tabs>` -- for Pangolin vs Standalone differences
- `<Cards>` -- keep on index page
- `<Accordion>` -- for FAQ page and long env var descriptions

**Screenshot Strategy:**
- **Priority screenshots:** Dashboard, Resources detail (with External MW + TLS toggles), Security Hub (mTLS + TLS Hardening + Secure Headers), Plugin Hub, Traefik Explorer
- **Remove all placeholder divs** -- either add real screenshots or remove the block entirely
- Format: PNG, dark mode, 1200px wide
- Store in `docs/docs/public/images/` with naming `{section}-{feature}.png`
- Every UI guide page should have at least one screenshot of the primary view

---

## 2C) Prioritized Content Roadmap

### Phase 1: Critical Corrections (highest user impact) -- Est. 1.5 days

These fix actively wrong information that misleads users.

| # | Task | Depends On | Est. |
|---|------|-----------|------|
| 1 | Fix `config-overview.mdx`: API-proxy as default, ENABLE_FILE_CONFIG | Nothing | 1.5h |
| 2 | Rework `security-mtls.mdx` -> `security-hub.mdx` (add TLS Hardening + Secure Headers + Duplicate Detection) | team:dev for Security handler review | 3h |
| 3 | Fix `environment.mdx` (TRAEFIK_API_URL default, add 4 missing vars) | Nothing | 0.5h |
| 4 | Fix `deploy-pangolin.mdx` typo (TRAFFIC -> TRAEFIK) | Nothing | 5min |
| 5 | Delete `test.mdx`, remove from any references | Nothing | 5min |
| 6 | Update `resources.mdx` (add External MW, TLS Hardening, Secure Headers toggles) | task #2 | 1.5h |
| 7 | Update `api/overview.mdx` (add security endpoints, external MW, bulk-delete, pagination) | team:dev for endpoint verification | 2h |
| 8 | Update `index.mdx` (remove placeholder, add version, update feature list) | Nothing | 0.5h |

### Phase 2: New Content (parallel work) -- Est. 2 days

| # | Task | Depends On | Est. |
|---|------|-----------|------|
| 9 | Create `configuration/api-proxy.mdx` (config proxy deep-dive) | team:dev for config_proxy.go analysis | 2.5h |
| 10 | Create `guides/external-middlewares.mdx` | team:dev for handler review | 1.5h |
| 11 | Create `guides/bulk-operations.mdx` (bulk delete, filtering, pagination) | Nothing | 1h |
| 12 | Create `architecture/how-it-works.mdx` | team:dev for architecture overview | 2.5h |
| 13 | Update `security/risks.mdx` (add TLS Hardening + Secure Headers risks) | task #2 | 1h |
| 14 | Expand `operations/troubleshooting.mdx` with common issues | Nothing | 1h |

### Phase 3: Screenshots & Polish -- Est. 1 day

| # | Task | Depends On | Est. |
|---|------|-----------|------|
| 15 | Capture and add screenshots for all UI guide pages | Running instance | 3h |
| 16 | Remove all 17+ screenshot placeholder divs | task #15 | 0.5h |
| 17 | Create `guides/faq.mdx` | Phases 1-2 | 1h |
| 18 | Create `architecture/changelog.mdx` | team:dev for release history | 1h |

### Dependencies on team:dev

- **config_proxy.go analysis** (merge logic, caching, Pangolin interaction)
- **Security handler review** (TLS Hardening config options, Secure Headers defaults, duplicate detection logic)
- **External Middlewares handler** (what types supported, validation, ordering)
- **Architecture overview** (watcher intervals, DB schema, fetcher abstraction)

---

# 3. Cross-Project Standards

## Shared Fumadocs Conventions

Both projects use the same Fumadocs stack. Standardize on:

| Convention | Standard |
|-----------|----------|
| Frontmatter | Always `title` + `description`. Add `icon` only for top-level sections. |
| H1 | One per page, matches `title` in frontmatter. |
| Component imports | Top of file, after frontmatter, before any content. |
| Callout types | `info` = context/prerequisites, `warn` = caution/might break, `error` = data loss/security risk |
| Code blocks | Always specify language (`bash`, `yaml`, `json`, `go`, `typescript`). |
| API examples | Use `<Tabs>` with curl + JavaScript tabs for all endpoints. |
| Links | Relative paths (`/docs/feature/name`), never absolute URLs to own docs site. |
| Screenshot alt text | Descriptive, e.g., "Dashboard showing alert count and GeoIP map". |

## Content Quality Checklist (per page)

Before merging any docs page, verify:

- [ ] Title + description in frontmatter
- [ ] Opening paragraph explains what and why (not just what)
- [ ] All env vars mentioned have default values documented
- [ ] All API endpoints show method, path, request body, response format
- [ ] Callout on any destructive or risky operation
- [ ] No screenshot placeholders -- either real screenshot or no placeholder
- [ ] Links to related pages (features <-> API, config <-> UI guide)
- [ ] Minimum 60 lines of meaningful content

## Parallel Work Strategy

The following can happen in parallel across both projects:

| Stream | CrowdSec Manager | Middleware Manager |
|--------|------------------|-------------------|
| **Critical fixes** (no deps) | index, contributing, api/overview | config-overview, environment, deploy-pangolin typo, test.mdx |
| **team:dev analysis** | config.go vars, architecture, Hub/History/ConfigValidation behavior | config_proxy.go, security handlers, external MW |
| **New feature pages** (after dev analysis) | hub-browser, history, config-validation | security-hub, api-proxy, external-middlewares |
| **API reference** | 15 new API pages | Expand api/overview |
| **Screenshots** | Capture after feature pages written | Capture + remove 17 placeholders |

## Issue Tracking Recommendation

Create one GitHub issue per phase per project (6 issues total):
1. `docs(crowdsec-manager): Phase 1 -- Critical gaps and corrections`
2. `docs(crowdsec-manager): Phase 2 -- Feature page depth`
3. `docs(crowdsec-manager): Phase 3 -- API reference`
4. `docs(middleware-manager): Phase 1 -- Critical corrections`
5. `docs(middleware-manager): Phase 2 -- New content`
6. `docs(middleware-manager): Phase 3 -- Screenshots and polish`

Each issue should contain the task table from the corresponding phase as a checklist.
