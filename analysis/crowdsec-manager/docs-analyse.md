# CrowdSec Manager Dokumentations-Analyse

**Datum:** 2026-03-23
**Repo:** `hhftechnology/crowdsec_manager`
**Live-Docs:** https://crowdsec-manager.hhf.technology/
**Docs-Framework:** Fumadocs (Next.js 16 + fumadocs-core 16.2.2 + fumadocs-mdx 14.0.4)
**App-Version im README:** 2.0.0 | **Live-Docs Version:** 2.1.0

---

## 1. Aktuelle Docs-Struktur (File-Tree)

```
docs/
├── content/docs/
│   ├── index.mdx                          (26 Zeilen)
│   ├── installation.mdx                   (75 Zeilen)
│   ├── quick-start.mdx                    (57 Zeilen)
│   ├── screenshots.mdx                    (169 Zeilen)
│   ├── meta.json
│   ├── api/
│   │   ├── overview.mdx                   (40 Zeilen)
│   │   ├── backup.mdx                     (54 Zeilen)
│   │   ├── docker.mdx                     (43 Zeilen)
│   │   ├── health.mdx                     (30 Zeilen)
│   │   ├── ip.mdx                         (40 Zeilen)
│   │   ├── logs.mdx                       (29 Zeilen)
│   │   └── whitelist.mdx                  (64 Zeilen)
│   ├── configuration/
│   │   ├── meta.json
│   │   ├── environment.mdx                (33 Zeilen)
│   │   ├── networking.mdx                 (33 Zeilen)
│   │   ├── notifications.mdx              (42 Zeilen)
│   │   ├── service-api.mdx                (43 Zeilen)
│   │   ├── settings.mdx                   (28 Zeilen)
│   │   └── volumes.mdx                    (34 Zeilen)
│   ├── development/
│   │   ├── architecture.mdx               (33 Zeilen)
│   │   └── contributing.mdx               (36 Zeilen)
│   └── features/
│       ├── meta.json
│       ├── alerts.mdx                     (53 Zeilen)
│       ├── allowlists.mdx                 (53 Zeilen)
│       ├── backups.mdx                    (32 Zeilen)
│       ├── captcha.mdx                    (61 Zeilen)
│       ├── cron-jobs.mdx                  (21 Zeilen)
│       ├── dashboard.mdx                  (35 Zeilen)
│       ├── decisions.mdx                  (69 Zeilen)
│       ├── engines.mdx                    (57 Zeilen)
│       ├── health.mdx                     (48 Zeilen)
│       ├── ip-management.mdx              (26 Zeilen)
│       ├── logs-monitoring.mdx            (31 Zeilen)
│       ├── profiles.mdx                   (30 Zeilen)
│       ├── remediation.mdx                (43 Zeilen)
│       ├── scenarios.mdx                  (57 Zeilen)
│       ├── stack-updates.mdx              (32 Zeilen)
│       └── whitelist-management.mdx       (33 Zeilen)
├── src/                                   (Next.js App-Code)
├── next.config.mjs
├── package.json
├── vercel.json
└── source.config.ts
```

**Gesamt:** 35 MDX-Dateien, ca. 1.500 Zeilen Content.
Durchschnitt ~43 Zeilen pro Datei -- die meisten Seiten sind Stubs oder Skelette.

---

## 2. Feature-Inventar (aus Source Code)

### 2.1 Backend-Features (Go, routes.go + handlers)

| # | Feature-Bereich | API-Routen | Handler-Dateien |
|---|---|---|---|
| 1 | **Health & Diagnostics** | `/health/stack`, `/health/crowdsec`, `/health/complete` | `health.go`, `health_diagnostics.go` |
| 2 | **IP Management** | `/ip/public`, `/ip/blocked/:ip`, `/ip/security/:ip`, `/ip/unban` | `ip.go`, `ip_security.go` |
| 3 | **Whitelist (Traefik+CrowdSec)** | `/whitelist/view`, `/current`, `/manual`, `/cidr`, `/crowdsec`, `/traefik`, `/comprehensive`, `/remove` | `whitelist.go`, `whitelist_ops.go` |
| 4 | **Allowlists (LAPI-Level)** | `/allowlist/list`, `/create`, `/inspect/:name`, `/add`, `/remove`, `/import`, `DELETE /:name` | `allowlists.go` |
| 5 | **Scenarios** | `/scenarios/setup`, `/list`, `/files`, `DELETE /file` | `scenarios.go`, `scenarios_files.go` |
| 6 | **Captcha/AppSec** | `/captcha/setup`, `/status`, `/detect`, `/config`, `/apply` | `captcha.go`, `captcha_config.go`, `captcha_detect.go`, `captcha_profiles.go`, `captcha_setup.go` |
| 7 | **Logs** | `/logs/crowdsec`, `/traefik`, `/traefik/advanced`, `/:service`, `/stream/:service`, `/structured/:service` | `logs.go`, `logs_analysis.go` |
| 8 | **Backup & Restore** | `/backup/list`, `/create`, `/restore`, `DELETE /:id`, `/cleanup`, `/latest` | `backups.go` |
| 9 | **Updates** | `/update/check`, `/with-crowdsec`, `/without-crowdsec` | `updates.go`, `updates_ops.go` |
| 10 | **Services/Docker** | `/services/verify`, `/shutdown`, `/action` | `services.go`, `services_config.go` |
| 11 | **CrowdSec Core** | `/crowdsec/bouncers` (CRUD), `/decisions` (CRUD + import + analysis + history + repeated-offenders + reapply + bulk-reapply), `/alerts/analysis` + `/history` + `/:id` (inspect/delete), `/history/stats`, `/history/config`, `/metrics`, `/enroll` (+ finalize + preferences + status) | `bouncers.go`, `decisions.go`, `decisions_import.go`, `dashboard_analysis.go`, `alerts_inspect.go`, `history.go` |
| 12 | **Traefik Config** | `/traefik/config`, `/config-path` (GET+POST) | `services_config.go` |
| 13 | **Settings/Config** | `/config/settings` (GET+PUT), `/config/files/:container/:fileType` | `services_config.go` |
| 14 | **Notifications (Discord)** | `/notifications/discord` (GET+POST), `/discord/preview`, `/detect`, `/config`, `/apply` | `notifications.go`, `notifications_compose.go`, `notifications_config.go`, `notifications_detect.go`, `notifications_templates.go`, `notifications_yaml.go` |
| 15 | **Cron Jobs** | `/cron/setup`, `/list`, `DELETE /:id` | `cron.go` |
| 16 | **Profiles** | `/profiles` (GET+POST) | `profiles.go` |
| 17 | **Multi-Host Docker** | `/hosts/list` | `hosts.go` + `internal/docker/multihost.go` |
| 18 | **Terminal (WebSocket)** | `/terminal/:container` | `terminal.go` |
| 19 | **Config Validation/Drift** | `/config/validation/validate`, `/snapshots`, `/snapshot`, `/restore/:type`, `/accept/:type`, `DELETE /snapshot/:type` | `config_validation.go` + `internal/configvalidator/validator.go` |
| 20 | **Hub Browser** | `/hub/list`, `/upgrade`, `/categories`, `/:category/items`, `/:category/install`, `/:category/remove`, `/:category/manual-apply`, `/preferences` (GET+PUT), `/history` | `hub.go` |
| 21 | **Simulation Mode** | `/simulation/status`, `/toggle` | `simulation.go` |
| 22 | **Real-Time Events** | `/events/ws`, `/events/sse` | `events.go` + `internal/messaging/` |
| 23 | **History Service** | Background-Sync (5 Min), Retention-Cleanup, Repeated Offender Detection, Reapply | `internal/history/` |
| 24 | **NATS Messaging** | Optional Pub/Sub | `internal/messaging/` |
| 25 | **Dashboard Analysis** | Aggregierte Metriken, GeoIP, Charts | `dashboard.go`, `dashboard_analysis.go` |

### 2.2 Frontend-Pages (React, web/src/pages/)

| Page-Datei | Navigation-Titel | Sektion |
|---|---|---|
| `Dashboard.tsx` | Dashboard | Getting started |
| `Bouncers.tsx` | Engines | Getting started |
| `Health.tsx` | Health | Getting started |
| `AlertAnalysis.tsx` | Alerts | Activity |
| `DecisionAnalysis.tsx` | Decisions | Activity |
| `History.tsx` | History | Activity |
| `CrowdSecHealth.tsx` | Remediation Metrics | Activity |
| `Metrics.tsx` | Engine Metrics | Activity |
| `Hub.tsx` | Hub Home | Hub |
| `HubBrowser.tsx` | Hub Browser | Hub |
| `HubCategory.tsx` | Hub Categories (7x) | Hub |
| `Scenarios.tsx` | Scenarios | Hub |
| `Captcha.tsx` | Captcha | Hub |
| `Services.tsx` | Service API | Configuration |
| `Notifications.tsx` | Notification settings | Configuration |
| `Allowlist.tsx` | Allowlists | Configuration |
| `Whitelist.tsx` | Whitelists | Configuration |
| `Profiles.tsx` | Profiles | Configuration |
| `IPManagement.tsx` | IP Management | Configuration |
| `Backup.tsx` | Backups | System |
| `Cron.tsx` | Cron Jobs | System |
| `Terminal.tsx` | Terminal | System |
| `Logs.tsx` | Logs | System |
| `Update.tsx` | Updates | System |
| `ConfigValidation.tsx` | Config Validation | System |
| `Configuration.tsx` | Settings | System |

---

## 3. Gap-Analyse: Dokumentiert vs. Nicht-dokumentiert

### 3.1 Fehlende Feature-Dokumentation

| Feature | Docs-Status | Prioritaet |
|---|---|---|
| **History (Decision/Alert History)** | FEHLT komplett | HOCH -- eigene Seite in Navigation, kein Docs-Pendant |
| **Hub Browser** | FEHLT komplett | HOCH -- 8 Navigation-Eintraege, 12 API-Endpunkte, kein Docs-Pendant |
| **Config Validation / Drift Detection** | FEHLT komplett | HOCH -- eigene Seite, 6 API-Endpunkte, kein Docs-Pendant |
| **Terminal (WebSocket Shell)** | FEHLT komplett | MITTEL -- eigene Seite, 1 Endpunkt |
| **Simulation Mode** | FEHLT komplett | MITTEL -- 2 API-Endpunkte |
| **Multi-Host Docker** | FEHLT komplett | MITTEL -- env-var `DOCKER_HOSTS`, 1 API-Endpunkt |
| **Real-Time Events (SSE/WebSocket)** | FEHLT komplett | MITTEL -- 2 Endpunkte, untermauert viele UI-Features |
| **NATS Messaging** | FEHLT komplett | NIEDRIG -- optional, env-vars undokumentiert |
| **Repeated Offender Detection** | FEHLT komplett | MITTEL -- automatischer Hintergrund-Service mit Benachrichtigung |
| **Decision Import** | FEHLT komplett | MITTEL -- POST `/crowdsec/decisions/import` |
| **Decision Reapply / Bulk Reapply** | FEHLT komplett | MITTEL -- 2 Endpunkte |
| **Pangolin-Deployment (docker-compose.pangolin.yml)** | FEHLT komplett | HOCH -- separates Compose-File vorhanden, kein Guide |
| **Helm Chart / Kubernetes** | FEHLT komplett | MITTEL -- `charts/` Verzeichnis mit kompletter Chart, kein Docs-Pendant |
| **Tailscale Sidecar** | FEHLT in Docs | MITTEL -- nur im README Compose-Beispiel |
| **Mobile App** | FEHLT in Docs | NIEDRIG -- nur im README erwaehnt |

### 3.2 Fehlende API-Dokumentation

Dokumentierte API-Seiten: 7 (backup, docker, health, ip, logs, overview, whitelist)

| API-Bereich | Endpunkte | Docs-Status |
|---|---|---|
| Allowlist API | 7 Endpunkte | FEHLT |
| Scenarios API | 4 Endpunkte | FEHLT |
| Captcha API | 5 Endpunkte | FEHLT |
| CrowdSec API (Bouncers, Decisions, Alerts, Metrics, Enroll) | 20+ Endpunkte | FEHLT |
| Traefik API | 3 Endpunkte | FEHLT |
| Config/Settings API | 3 Endpunkte | FEHLT |
| Notifications API | 6 Endpunkte | FEHLT |
| Cron API | 3 Endpunkte | FEHLT |
| Profiles API | 2 Endpunkte | FEHLT |
| Hosts API | 1 Endpunkt | FEHLT |
| Terminal API | 1 Endpunkt | FEHLT |
| Config Validation API | 6 Endpunkte | FEHLT |
| Hub API | 12 Endpunkte | FEHLT |
| Simulation API | 2 Endpunkte | FEHLT |
| Events API | 2 Endpunkte | FEHLT |
| Update API | 3 Endpunkte | Teilweise (in docker.mdx, aber falsche Pfade) |

**Fazit:** Nur ca. 20 von ~90+ Endpunkten sind dokumentiert. Die vorhandene API-Doku ist unvollstaendig und teilweise veraltet.

### 3.3 Fehlende Environment-Variablen

Die Docs listen 9 Env-Vars. Der Source Code (`config.go`) definiert **40+ Variablen**. Fehlend u.a.:

| Variable | Default | Zweck |
|---|---|---|
| `DOCKER_HOSTS` | `""` | Multi-Host-Konfiguration |
| `HISTORY_DATABASE_PATH` | `./data/history.db` | Separate History-DB |
| `CROWDSEC_WHITELIST_PATH` | `.../mywhitelists.yaml` | Whitelist-Pfad |
| `CROWDSEC_PROFILES_PATH` | `.../profiles.yaml` | Profiles-Pfad |
| `CROWDSEC_NOTIFICATIONS_DIR` | `.../notifications` | Notification-Dir |
| `CROWDSEC_SCENARIOS_DIR` | `.../scenarios` | Scenarios-Dir |
| `CROWDSEC_METRICS_URL` | `http://localhost:6060/metrics` | Prometheus-Metrics |
| `CROWDSEC_CONSOLE_URL` | CrowdSec Console URL | Console-Link |
| `CROWDSEC_CTI_URL_PATTERN` | CTI URL Template | CTI-Integration |
| `TRAEFIK_CAPTCHA_HTML_PATH` | Captcha HTML Pfad | Captcha-Feature |
| `TRAEFIK_CAPTCHA_ENV_PATH` | Captcha Env Pfad | Captcha-Feature |
| `CAPTCHA_GRACE_PERIOD` | `1800` | Captcha Grace Period |
| `CROWDSEC_CONTAINER_NAME` | `crowdsec` | Container-Name |
| `PANGOLIN_CONTAINER_NAME` | `pangolin` | Container-Name |
| `GERBIL_CONTAINER_NAME` | `gerbil` | Container-Name |
| `INCLUDE_CROWDSEC` | `true` | Feature-Flag |
| `INCLUDE_PANGOLIN` | `true` | Feature-Flag |
| `INCLUDE_GERBIL` | `true` | Feature-Flag |
| `DECISION_LIST_LIMIT` | `200` | Performance-Limit |
| `ALERT_LIST_LIMIT` | `200` | Performance-Limit |
| `NATS_URL` | `""` | NATS Server |
| `NATS_TOKEN` | `""` | NATS Auth |
| `NATS_ENABLED` | `false` | NATS Feature-Flag |
| `SHUTDOWN_TIMEOUT` | `30` | Graceful Shutdown |
| `READ_TIMEOUT` | `15` | HTTP Read Timeout |
| `WRITE_TIMEOUT` | `15` | HTTP Write Timeout |
| `CONFIG_DIR` | `./config` | Config-Verzeichnis |
| `PANGOLIN_DIR` | `.` | Pangolin Root |
| `LOG_FILE` | `./logs/crowdsec-manager.log` | Log-Pfad |
| `COMPOSE_FILE` | `./docker-compose.yml` | Compose-Pfad |

---

## 4. Spezifisch veraltete Inhalte

### 4.1 Architecture (development/architecture.mdx)
- **Falsch:** "Uses `chi` router" -- tatsaechlich wird `gin-gonic/gin` verwendet (siehe `routes.go` Import)
- **Fehlend:** Messaging-System (NATS/WebSocket/SSE Hub), History-Service, Config-Validator, Multi-Host-Client, Cache-Layer
- **Fehlend:** Go 1.23+ (README sagt 1.23, Docs contributing sagt 1.21)

### 4.2 Contributing (development/contributing.mdx)
- **Falsch:** `go run main.go` -- korrekt waere `go run cmd/server/main.go`
- **Falsch:** Go 1.21+ -- sollte Go 1.23+ sein
- **Fehlend:** `air` fuer Hot-Reload (configs/.air.toml vorhanden), Docker-Dev-Setup (Dockerfile.dev vorhanden)

### 4.3 Docker API (api/docker.mdx)
- **Falsch:** Endpunkte `GET /api/docker/containers` und `POST /api/docker/container/:action` existieren nicht in routes.go
- Die tatsaechlichen Endpunkte sind unter `/api/services/` und `/api/update/`
- Dieses Dokument beschreibt eine API die so nicht existiert

### 4.4 API Overview (api/overview.mdx)
- **Falsch:** Response-Format zeigt `"status": "success"` -- tatsaechlich nutzt der Code `models.Response` mit `"success": true/false`
- **Fehlend:** Rate-Limiting Middleware (`internal/api/middleware/ratelimit.go`)
- **Fehlend:** Docker-Host Middleware (`internal/api/middleware/docker_host.go`)

### 4.5 Environment Variables (configuration/environment.mdx)
- Nur 9 von 40+ Variablen dokumentiert
- "Multi-proxy support is not available" -- Multi-Host ist ueber `DOCKER_HOSTS` implementiert

### 4.6 README.md
- Version "2.0.0" vs. Live-Docs "2.1.0" -- inkonsistent
- React 18.3 Badge -- Frontend nutzt React 19.2.1 (laut docs/package.json)
- App-Links (Google Play, F-Droid, App Store) verlinken auf Platzhalter-URLs

### 4.7 Backup API (api/backup.mdx)
- **Fehlend:** `GET /api/backup/latest` Endpunkt (existiert in routes.go, nicht dokumentiert)

---

## 5. Build-Konfiguration (Static Export)

### 5.1 Aktueller Stand

**next.config.mjs:**
```js
const config = {
  reactStrictMode: true,
};
```

- **KEIN `output: 'export'`** konfiguriert
- Aktuell: Standard Next.js SSR/Server-Mode
- Vercel-Deployment via `vercel.json` (outputDirectory: `.next`)
- Fumadocs hat eine Search API Route (`src/app/api/search/route.ts`) -- inkompatibel mit Static Export
- Sitemap und OG-Image-Routes nutzen dynamische Server-Features

### 5.2 Static Export Machbarkeit

| Komponente | Static-Export-kompatibel? | Aenderung noetig |
|---|---|---|
| MDX Content | Ja | Keine |
| Search API Route (`/api/search`) | Nein | Muss durch Client-Side-Search ersetzt werden (fumadocs-core bietet `SearchDialog` mit Static-Search) |
| Sitemap (`sitemap.ts`) | Nein | Muss als statische `sitemap.xml` generiert werden |
| OG Image Route | Nein | Muss entfernt oder pre-rendered werden |
| `robots.ts` | Nein | Muss als statische `robots.txt` bereitgestellt werden |
| llms-full.txt Route | Nein | Muss als statisches File generiert werden |

**Fazit:** Static Export erfordert moderate Anpassungen. Fumadocs unterstuetzt Static Export, aber die dynamischen Routes muessen migriert werden.

### 5.3 package.json Build-Scripts

```json
{
  "build": "next build",
  "dev": "next dev",
  "start": "next start",
  "types:check": "fumadocs-mdx && tsc --noEmit",
  "postinstall": "fumadocs-mdx"
}
```

- Kein `export`-Script vorhanden
- Fuer Static Export: `output: 'export'` in next.config.mjs + dynamische Routes migrieren

### 5.4 Dependencies

- `fumadocs-core`: 16.2.2
- `fumadocs-mdx`: 14.0.4
- `fumadocs-ui`: 16.2.2
- `next`: ^16.0.7
- `react`: ^19.2.1
- Alle aktuell und kompatibel

---

## 6. Empfehlungen und Priorisierung

### Phase 1: Kritische Luecken schliessen (Aufwand: ~3-4 Tage)

| Aufgabe | Dateien | Aufwand |
|---|---|---|
| **Hub Browser Feature-Docs** | Neue Seite `features/hub-browser.mdx` | 2-3h |
| **History Feature-Docs** | Neue Seite `features/history.mdx` | 2h |
| **Config Validation Feature-Docs** | Neue Seite `features/config-validation.mdx` | 2h |
| **Terminal Feature-Docs** | Neue Seite `features/terminal.mdx` | 1h |
| **Pangolin Deployment Guide** | Neue Seite `installation-pangolin.mdx` oder Erweiterung von `installation.mdx` | 3h |
| **Environment Variables komplett** | Ueberarbeitung `configuration/environment.mdx` | 2-3h |
| **Architecture korrigieren** | Fix `development/architecture.mdx` (chi -> gin, fehlende Packages) | 1h |
| **Contributing korrigieren** | Fix `development/contributing.mdx` (Go-Version, Pfade, Dev-Setup) | 1h |
| **Docker API entfernen/korrigieren** | `api/docker.mdx` komplett ueberarbeiten oder durch korrekte Services/Update API ersetzen | 1-2h |
| **API Overview Response-Format** | Fix `api/overview.mdx` | 0.5h |

### Phase 2: API-Dokumentation vervollstaendigen (Aufwand: ~3-4 Tage)

| Aufgabe | Neue Datei | Endpunkte | Aufwand |
|---|---|---|---|
| CrowdSec API (Decisions, Alerts, Bouncers, Metrics, Enroll) | `api/crowdsec.mdx` | 20+ | 4-5h |
| Allowlist API | `api/allowlist.mdx` | 7 | 1.5h |
| Captcha API | `api/captcha.mdx` | 5 | 1.5h |
| Scenarios API | `api/scenarios.mdx` | 4 | 1h |
| Services API | `api/services.mdx` | 3 | 1h |
| Notifications API | `api/notifications.mdx` | 6 | 1.5h |
| Config Validation API | `api/config-validation.mdx` | 6 | 1.5h |
| Hub API | `api/hub.mdx` | 12 | 2-3h |
| Simulation API | `api/simulation.mdx` | 2 | 0.5h |
| Events API (SSE/WS) | `api/events.mdx` | 2 | 1h |
| Cron API | `api/cron.mdx` | 3 | 0.5h |
| Profiles API | `api/profiles.mdx` | 2 | 0.5h |
| Hosts API | `api/hosts.mdx` | 1 | 0.5h |
| Terminal API | `api/terminal.mdx` | 1 | 0.5h |

### Phase 3: Zusaetzliche Guides und Referenz (Aufwand: ~2 Tage)

| Aufgabe | Aufwand |
|---|---|
| Helm Chart / Kubernetes Deployment Guide | 2-3h |
| Tailscale Sidecar Guide | 1-2h |
| Multi-Host Docker Setup | 1-2h |
| NATS Messaging Integration | 1h |
| Simulation Mode Feature-Docs | 1h |
| Repeated Offender Feature-Docs | 1h |
| Troubleshooting Guide | 2-3h |
| Migration Guide (1.x -> 2.x) | 1-2h |

### Phase 4: Static Export (optional, Aufwand: ~1 Tag)

| Aufgabe | Aufwand |
|---|---|
| `output: 'export'` in next.config.mjs | 0.5h |
| Search API -> fumadocs Static Search migrieren | 2-3h |
| Dynamische Routes (sitemap, robots, OG) zu statischen Files | 1-2h |
| Build-Validierung und Test | 1h |

---

## 7. Zusammenfassung

| Kategorie | Status |
|---|---|
| **Feature-Abdeckung** | ~50% -- 16 von ~25 Features haben Docs-Seiten, aber viele sind Stubs |
| **API-Abdeckung** | ~20% -- 7 von ~15 API-Bereichen dokumentiert, davon 1 komplett falsch |
| **Env-Var-Abdeckung** | ~22% -- 9 von 40+ Variablen dokumentiert |
| **Inhaltliche Qualitaet** | Niedrig-Mittel -- die meisten Seiten sind 25-55 Zeilen, kaum Tiefe |
| **Aktualitaet** | Veraltet -- Router falsch (chi statt gin), Go-Version falsch, API-Pfade falsch |
| **Build/Deploy** | Nicht Static-Export-ready, aber mit moderatem Aufwand machbar |
| **Geschaetzter Gesamt-Aufwand** | ~9-11 Tage fuer vollstaendige Ueberarbeitung |
