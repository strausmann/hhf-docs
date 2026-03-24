# HHF Docs – Consolidated Backlog Overview

**Generated:** 2026-03-24
**Sources:**
- Gap analysis: crowdsec-manager/docs-analyse.md (2026-03-23)
- Gap analysis: middleware-manager/docs-analyse.md (2026-03-23)

---

## Summary

| Project | Feature Coverage | API Coverage | Env-Var Coverage | Overall Quality |
|---|---|---|---|---|
| crowdsec-manager | ~50% (stubs) | ~20% (1 wrong) | ~22% (9/40+) | Low-Medium |
| middleware-manager | ~70% (core covered) | ~60% (security missing) | ~75% (12/16) | Medium |

**Total estimated effort:** 12–15 days (crowdsec-manager: 9–11d, middleware-manager: 3–4d)

---

## Phase 1: Critical (Falsche Informationen, Security-Luecken, groesste Luecken)

### CSM-01 – Fix incorrect API docs and outdated architecture info [crowdsec-manager]
**Priority:** critical | **Effort:** M | **Team:** dev
- `api/docker.mdx`: All endpoints wrong (describes non-existent routes)
- `api/overview.mdx`: Response format wrong (`"status"` vs `"success"`)
- `development/architecture.mdx`: Router wrong (chi vs gin), missing packages
- `development/contributing.mdx`: Wrong Go version (1.21 vs 1.23), wrong main.go path
- `configuration/environment.mdx`: States "multi-proxy not available" (wrong – DOCKER_HOSTS exists)

### CSM-02 – Complete environment variables documentation [crowdsec-manager]
**Priority:** critical | **Effort:** M | **Team:** dev
- Currently 9 of 40+ env-vars documented
- Missing: DOCKER_HOSTS, HISTORY_DATABASE_PATH, all CROWDSEC_* paths, NATS_*, performance limits
- Critical omission: feature flags (INCLUDE_CROWDSEC, INCLUDE_PANGOLIN, INCLUDE_GERBIL)

### CSM-03 – Document Hub Browser feature [crowdsec-manager]
**Priority:** high | **Effort:** M | **Team:** dev
- 8 navigation entries, 12 API endpoints – no docs at all
- New file: `features/hub-browser.mdx`

### CSM-04 – Document History, Config Validation, and Simulation Mode [crowdsec-manager]
**Priority:** high | **Effort:** M | **Team:** dev
- History: own navigation page, no docs (decision/alert history, retention, repeated offenders)
- Config Validation / Drift Detection: 6 API endpoints, no docs
- Simulation Mode: 2 API endpoints, no docs
- New files: `features/history.mdx`, `features/config-validation.mdx`, `features/simulation.mdx`

### CSM-05 – Add Pangolin deployment guide [crowdsec-manager]
**Priority:** high | **Effort:** S | **Team:** dev
- `docker-compose.pangolin.yml` exists in repo but is completely undocumented
- New file: `installation-pangolin.mdx` or extend `installation.mdx`

### MM-01 – Fix incorrect and outdated content [middleware-manager]
**Priority:** critical | **Effort:** S | **Team:** dev
- `environment.mdx`: TRAEFIK_API_URL default wrong (host.docker.internal vs traefik:8080)
- `deploy-pangolin.mdx`: Typo TRAFFIC_API_URL (should be TRAEFIK_API_URL)
- `config-overview.mdx`: Describes File-Provider as default (wrong – API-Proxy is default)
- `test.mdx`: Demo page should be removed or hidden from navigation

### MM-02 – Document Security Hub: TLS Hardening and Secure Headers [middleware-manager]
**Priority:** high | **Effort:** M | **Team:** dev
- Both features exist in code and UI but are completely absent from docs
- `security-mtls.mdx` only covers mTLS – title is misleading
- New file: `security/security-hub.mdx` or extend existing security section

### MM-03 – Document External Middlewares feature [middleware-manager]
**Priority:** high | **Effort:** S | **Team:** dev
- Assigning Traefik-native middlewares to resources (not MM-managed)
- 3 API endpoints (GET/POST/DELETE /:id/external-middlewares)
- Extend `ui-guides/resources.mdx`

### MM-04 – Document ENABLE_FILE_CONFIG mode and complete env-vars [middleware-manager]
**Priority:** high | **Effort:** S | **Team:** dev
- API-Proxy mode vs File-Config mode distinction not explained
- 4 env-vars missing: GENERATE_INTERVAL_SECONDS, ENABLE_FILE_CONFIG, UI_PATH, CONFIG_DIR
- Extend `configuration/config-overview.mdx` and `configuration/environment.mdx`

---

## Phase 2: API Documentation

### CSM-06 – Document CrowdSec core API (Decisions, Alerts, Bouncers, Metrics, Enroll) [crowdsec-manager]
**Priority:** high | **Effort:** L | **Team:** dev
- 20+ endpoints completely undocumented
- Includes: bulk operations, decision import, history stats, repeated offenders, reapply
- New file: `api/crowdsec.mdx`

### CSM-07 – Document remaining API endpoints: Allowlists, Captcha, Scenarios [crowdsec-manager]
**Priority:** medium | **Effort:** M | **Team:** dev
- Allowlist API: 7 endpoints
- Captcha/AppSec API: 5 endpoints
- Scenarios API: 4 endpoints
- New files: `api/allowlist.mdx`, `api/captcha.mdx`, `api/scenarios.mdx`

### CSM-08 – Document management API endpoints: Notifications, Hub, Config Validation [crowdsec-manager]
**Priority:** medium | **Effort:** M | **Team:** dev
- Notifications API: 6 endpoints
- Hub API: 12 endpoints
- Config Validation API: 6 endpoints
- New files: `api/notifications.mdx`, `api/hub.mdx`, `api/config-validation.mdx`

### CSM-09 – Document system API endpoints: Cron, Profiles, Simulation, Events, Terminal, Hosts [crowdsec-manager]
**Priority:** low | **Effort:** S | **Team:** dev
- Cron: 3 endpoints, Profiles: 2, Simulation: 2, Events (SSE/WS): 2, Terminal: 1, Hosts: 1
- New files: `api/cron.mdx`, `api/profiles.mdx`, `api/simulation.mdx`, `api/events.mdx`, `api/terminal.mdx`

### MM-05 – Complete API reference: Security, External Middlewares, Bulk-Delete, Pagination [middleware-manager]
**Priority:** medium | **Effort:** M | **Team:** dev
- Security endpoints (/api/security/*) completely absent from API overview
- External Middlewares endpoints missing
- bulk-delete-disabled not documented
- Pagination/filter query params (?page, ?page_size, ?source_type, ?status) not mentioned
- Extend `api/overview.mdx`

---

## Phase 3: Guides and Tutorials

### CSM-10 – Add Helm Chart / Kubernetes deployment guide [crowdsec-manager]
**Priority:** medium | **Effort:** M | **Team:** dev
- Full Helm chart exists in `charts/` directory – zero documentation
- New file: `installation-kubernetes.mdx`

### CSM-11 – Add advanced deployment guides: Multi-Host, Tailscale, NATS [crowdsec-manager]
**Priority:** medium | **Effort:** M | **Team:** dev
- Multi-Host Docker setup (DOCKER_HOSTS env-var)
- Tailscale sidecar integration (exists in README compose example)
- NATS messaging (optional pub/sub, undocumented env-vars)
- New files or sections in installation guide

### CSM-12 – Add Troubleshooting guide and Migration guide (1.x to 2.x) [crowdsec-manager]
**Priority:** medium | **Effort:** M | **Team:** marketing
- Troubleshooting: common issues, log analysis, health check failures
- Migration: breaking changes from 1.x to 2.x

### MM-06 – Add Screenshots and replace all placeholders [middleware-manager]
**Priority:** medium | **Effort:** L | **Team:** marketing
- 17+ screenshot placeholders exist across all MDX files – never filled
- Requires actual running instance for screenshots
- Affects all ui-guide pages and several configuration pages

### MM-07 – Add Architecture / How It Works documentation [middleware-manager]
**Priority:** medium | **Effort:** M | **Team:** dev
- Config-Proxy flow, Watcher pattern, DB schema not explained anywhere
- Helps users understand the system model before configuration
- New file: `development/architecture.mdx` (or similar)

### MM-08 – Add Changelog and FAQ pages [middleware-manager]
**Priority:** low | **Effort:** S | **Team:** marketing
- No release notes or changelog page
- FAQ from common Discord/issue questions
- New files: `operations/changelog.mdx`, `operations/faq.mdx`

---

## Phase 4: Static Export

### SHARED-01 – Migrate both docs to Fumadocs Static Export [crowdsec-manager + middleware-manager]
**Priority:** medium | **Effort:** L | **Team:** ops
- Add `output: 'export'` to next.config.mjs (both projects)
- Migrate Search API routes to fumadocs-core static search
- Convert dynamic routes (sitemap, robots.txt, OG images) to static files
- Add static export build scripts to package.json
- Validate builds and configure GitHub Pages or equivalent hosting
- **Dependency:** Requires all Phase 1 content corrections first

---

## Roadmap Summary (GitHub Issue Numbers)

| GH Issue | ID | Title | Project | Phase | Priority | Effort | Team |
|---|---|---|---|---|---|---|---|
| [#1](https://github.com/strausmann/hhf-docs/issues/1) | CSM-01 | Fix incorrect API docs and architecture | crowdsec-manager | 1 | critical | M | dev |
| [#2](https://github.com/strausmann/hhf-docs/issues/2) | CSM-02 | Complete environment variables | crowdsec-manager | 1 | critical | M | dev |
| [#3](https://github.com/strausmann/hhf-docs/issues/3) | CSM-03 | Document Hub Browser feature | crowdsec-manager | 1 | high | M | dev |
| [#4](https://github.com/strausmann/hhf-docs/issues/4) | CSM-04 | Document History, Config Validation, Simulation | crowdsec-manager | 1 | high | M | dev |
| [#5](https://github.com/strausmann/hhf-docs/issues/5) | CSM-05 | Add Pangolin deployment guide | crowdsec-manager | 1 | high | S | dev |
| [#6](https://github.com/strausmann/hhf-docs/issues/6) | MM-01 | Fix incorrect and outdated content | middleware-manager | 1 | critical | S | dev |
| [#7](https://github.com/strausmann/hhf-docs/issues/7) | MM-02 | Document Security Hub (TLS Hardening + Secure Headers) | middleware-manager | 1 | high | M | dev |
| [#8](https://github.com/strausmann/hhf-docs/issues/8) | MM-03 | Document External Middlewares | middleware-manager | 1 | high | S | dev |
| [#9](https://github.com/strausmann/hhf-docs/issues/9) | MM-04 | Document ENABLE_FILE_CONFIG and complete env-vars | middleware-manager | 1 | high | S | dev |
| [#10](https://github.com/strausmann/hhf-docs/issues/10) | CSM-06 | CrowdSec core API reference | crowdsec-manager | 2 | high | L | dev |
| [#11](https://github.com/strausmann/hhf-docs/issues/11) | CSM-07 | Allowlists, Captcha, Scenarios API | crowdsec-manager | 2 | medium | M | dev |
| [#12](https://github.com/strausmann/hhf-docs/issues/12) | CSM-08 | Notifications, Hub, Config Validation API | crowdsec-manager | 2 | medium | M | dev |
| [#13](https://github.com/strausmann/hhf-docs/issues/13) | CSM-09 | System API endpoints (Cron, Profiles, etc.) | crowdsec-manager | 2 | low | S | dev |
| [#15](https://github.com/strausmann/hhf-docs/issues/15) | MM-05 | Complete API reference (Security, Pagination) | middleware-manager | 2 | medium | M | dev |
| [#16](https://github.com/strausmann/hhf-docs/issues/16) | CSM-10 | Helm / Kubernetes deployment guide | crowdsec-manager | 3 | medium | M | dev |
| [#17](https://github.com/strausmann/hhf-docs/issues/17) | CSM-11 | Advanced guides (Multi-Host, Tailscale, NATS) | crowdsec-manager | 3 | medium | M | dev |
| [#18](https://github.com/strausmann/hhf-docs/issues/18) | CSM-12 | Troubleshooting + Migration guide | crowdsec-manager | 3 | medium | M | marketing |
| [#19](https://github.com/strausmann/hhf-docs/issues/19) | MM-06 | Add Screenshots (replace all placeholders) | middleware-manager | 3 | medium | L | marketing |
| [#20](https://github.com/strausmann/hhf-docs/issues/20) | MM-07 | Architecture / How It Works page | middleware-manager | 3 | medium | M | dev |
| [#21](https://github.com/strausmann/hhf-docs/issues/21) | MM-08 | Changelog and FAQ pages | middleware-manager | 3 | low | S | marketing |
| [#22](https://github.com/strausmann/hhf-docs/issues/22) | SHARED-01 | Static Export migration (both projects) | both | 4 | medium | L | ops |
| [#23](https://github.com/strausmann/hhf-docs/issues/23) | META | ROADMAP Master Tracking Issue | both | — | — | — | pm |

**Total Issues: 22 (21 work items + 1 roadmap meta-issue)**

Note: Issue #14 was a pre-existing "Maintainer Alignment" issue not part of this backlog.
