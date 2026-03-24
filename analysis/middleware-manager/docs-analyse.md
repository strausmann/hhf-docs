# Middleware Manager Dokumentations-Analyse

**Datum:** 2026-03-23
**Repository:** `hhftechnology/middleware-manager`
**Live-Docs:** https://middleware-manager.hhf.technology/
**Docs-Framework:** Fumadocs (Next.js 16 + fumadocs-ui 16.2.2)

---

## 1. Aktuelle Docs-Struktur (File Tree)

```
docs/docs/
├── app/
│   ├── api/search/route.ts
│   ├── docs/layout.tsx
│   ├── docs/[[...slug]]/page.tsx
│   ├── global.css
│   ├── (home)/layout.tsx
│   ├── (home)/page.tsx
│   ├── layout.tsx
│   ├── llms-full.txt/route.ts
│   └── og/docs/[...slug]/route.tsx
├── content/docs/
│   ├── index.mdx                              # Landing / Overview
│   ├── meta.json                              # Globale Seitenreihenfolge
│   ├── test.mdx                               # Test-/Demoseite (nicht verlinkt)
│   ├── getting-started/
│   │   ├── meta.json
│   │   ├── onboarding.mdx
│   │   ├── deploy-pangolin.mdx
│   │   └── deploy-standalone.mdx
│   ├── configuration/
│   │   ├── meta.json
│   │   ├── config-overview.mdx
│   │   ├── data-sources.mdx
│   │   ├── templates.mdx
│   │   └── environment.mdx
│   ├── ui-guides/
│   │   ├── meta.json
│   │   ├── dashboard.mdx
│   │   ├── resources.mdx
│   │   ├── middlewares.mdx
│   │   ├── services.mdx
│   │   ├── plugin-hub.mdx
│   │   ├── security-mtls.mdx
│   │   ├── traefik-explorer.mdx
│   │   └── settings.mdx
│   ├── security/
│   │   ├── meta.json
│   │   └── risks.mdx
│   ├── operations/
│   │   ├── meta.json
│   │   ├── runbook.mdx
│   │   ├── troubleshooting.mdx
│   │   └── backups.mdx
│   ├── api/
│   │   ├── meta.json
│   │   └── overview.mdx
│   ├── reverting/
│   │   ├── meta.json
│   │   └── revert-traefik.mdx
│   └── development/
│       ├── meta.json
│       └── dev-guide.mdx
├── lib/
│   ├── layout.shared.tsx
│   └── source.ts
├── mdx-components.tsx
├── next.config.mjs
├── package.json
├── source.config.ts
└── tsconfig.json
```

**Insgesamt:** 20 MDX-Inhaltsdateien (davon 1 Test-Datei), 8 meta.json, 1 index.mdx

---

## 2. Feature-Inventar (aus Source Code)

### 2.1 API-Endpunkte (aus `api/server.go`)

| Bereich | Endpunkte | Im Code |
|---|---|---|
| Health | `GET /health` | Ja |
| Middlewares | CRUD (`GET/POST/PUT/DELETE /api/middlewares`) | Ja |
| Services | CRUD (`GET/POST/PUT/DELETE /api/services`) | Ja |
| Resources | `GET/DELETE /api/resources`, `POST /bulk-delete-disabled` | Ja |
| Resource Middleware Assign | `POST /:id/middlewares`, `POST /:id/middlewares/bulk`, `DELETE /:id/middlewares/:mid` | Ja |
| External Middlewares | `GET/POST/DELETE /:id/external-middlewares` | Ja |
| Resource Service Assign | `GET/POST/DELETE /:id/service` | Ja |
| Router Config | `PUT /:id/config/{http,tls,tcp,headers,priority,mtls,mtlswhitelist}` | Ja |
| Per-Resource Security | `PUT /:id/config/tls-hardening`, `PUT /:id/config/secure-headers` | Ja |
| Data Source | `GET/PUT /datasource`, `GET/PUT /datasource/active`, `POST /:name/test` | Ja |
| Plugins | `GET /plugins`, `GET /plugins/catalogue`, `POST /plugins/install`, `DELETE /plugins/remove`, `GET/PUT /plugins/configpath` | Ja |
| Traefik Explorer | `GET /traefik/{overview,version,entrypoints,routers,services,middlewares,data}` | Ja |
| mTLS | `GET /mtls/config`, `PUT /mtls/{enable,disable}`, `POST/DELETE /mtls/ca`, `PUT /mtls/config/path`, Client CRUD + Download + Revoke, Plugin Check, Middleware Config | Ja |
| Security | `GET /security/config`, TLS Hardening enable/disable, Secure Headers enable/disable/config, `POST /security/check-duplicates` | Ja |
| Config Proxy | `GET /traefik-config`, `POST /traefik-config/invalidate`, `GET /traefik-config/status` (unter `/api` und `/api/v1`) | Ja |

### 2.2 Backend-Services (aus `services/`)

| Service | Beschreibung |
|---|---|
| `config_manager.go` | Data Source Verwaltung, config.json |
| `config_proxy.go` | Traefik HTTP-Provider Proxy mit Caching, mergt Pangolin + MM Overrides |
| `config_generator.go` | File-basierte Config-Generierung (optional via `ENABLE_FILE_CONFIG`) |
| `resource_watcher.go` | Periodisches Polling von Resources aus aktiver Datenquelle |
| `service_watcher.go` | Periodisches Polling von Services aus aktiver Datenquelle |
| `resource_fetcher.go` | Abstraktion fuer Pangolin/Traefik Resource Fetch |
| `service_fetcher.go` | Abstraktion fuer Pangolin/Traefik Service Fetch |
| `pangolin_fetcher.go` | Pangolin-spezifischer Fetcher |
| `traefik_fetcher.go` | Traefik-API-spezifischer Fetcher |
| `plugin_fetcher.go` | Plugin Catalogue Fetch (plugins.traefik.io) |
| `cert_generator.go` | CA und Client-Zertifikat-Generierung (mTLS) |
| `duplicate_detector.go` | Middleware-Namenskonflikte mit Traefik erkennen |
| `http_pool.go` | Shared HTTP Client Pool |
| `json_decoder.go` | Toleranter JSON Decoder |

### 2.3 UI-Features (aus `ui/src/components/`)

| UI-Bereich | Komponenten |
|---|---|
| Dashboard | `Dashboard.tsx`, `ResourceSummary.tsx`, `StatCard.tsx` |
| Resources | `ResourcesList.tsx`, `ResourceDetail.tsx` (HTTP/TLS/TCP Config, mTLS Toggle, External Middlewares, Service Override, TLS Hardening, Secure Headers) |
| Middlewares | `MiddlewaresList.tsx`, `MiddlewareForm.tsx` |
| Services | `ServicesList.tsx`, `ServiceForm.tsx` |
| Plugins | `PluginHub.tsx`, `PluginCard.tsx`, `CataloguePluginCard.tsx` |
| Security | `SecurityHub.tsx` (mTLS + TLS Hardening + Secure Headers), `CAManager.tsx`, `ClientCertList.tsx`, `CertImportGuide.tsx` |
| Traefik Explorer | `OverviewCards.tsx`, `VersionInfo.tsx`, `EntrypointList.tsx`, `RouterTabs.tsx`, `ServiceTabs.tsx`, `MiddlewareTabs.tsx` |
| Settings | `DataSourceSettings.tsx` |
| Common | `Header.tsx`, `Footer.tsx`, `DarkModeToggle.tsx`, `ErrorMessage.tsx`, `EmptyState.tsx`, `ConfirmationModal.tsx`, `LoadingSpinner.tsx` |

### 2.4 Environment Variables (aus `main.go`)

| Variable | Default | Dokumentiert? |
|---|---|---|
| `PORT` | `3456` | Ja |
| `DB_PATH` | `/data/middleware.db` | Ja |
| `TRAEFIK_CONF_DIR` | `/conf` | Ja |
| `TRAEFIK_STATIC_CONFIG_PATH` | `/etc/traefik/traefik.yml` | Ja |
| `ACTIVE_DATA_SOURCE` | `pangolin` | Ja |
| `PANGOLIN_API_URL` | `http://pangolin:3001/api/v1` | Ja |
| `TRAEFIK_API_URL` | `http://traefik:8080` | Ja |
| `CHECK_INTERVAL_SECONDS` | `30` | Ja |
| `SERVICE_INTERVAL_SECONDS` | `30` | Ja |
| `DEBUG` | `false` | Ja |
| `ALLOW_CORS` | `false` | Ja |
| `CORS_ORIGIN` | `""` | Ja |
| `GENERATE_INTERVAL_SECONDS` | `10` | Nein |
| `ENABLE_FILE_CONFIG` | `false` (implicit) | Nein |
| `UI_PATH` | `/app/ui/dist` | Nein |
| `CONFIG_DIR` | `/app/config` | Nein |

---

## 3. Gap-Analyse (Dokumentiert vs. Undokumentiert)

### 3.1 Vollstaendig undokumentierte Features

| Feature | Quelle | Schwere |
|---|---|---|
| **Security Hub: TLS Hardening** | `api/handlers/security.go`, `SecurityHub.tsx` - Global enable/disable + per-Resource TLS Hardening | Hoch |
| **Security Hub: Secure Headers** | `api/handlers/security.go`, `SecurityHub.tsx` - Global enable/disable + konfigurierbare Header (X-Content-Type-Options, X-Frame-Options, HSTS, CSP, etc.) | Hoch |
| **Middleware Duplicate Detection** | `services/duplicate_detector.go`, `POST /security/check-duplicates` - Prueft Namenskonflikte mit bestehenden Traefik-Middlewares | Mittel |
| **External Middlewares** | `GET/POST/DELETE /:id/external-middlewares` - Traefik-native Middlewares an Resources zuweisen (nicht MM-managed) | Hoch |
| **Bulk Delete Disabled Resources** | `POST /resources/bulk-delete-disabled` - Deaktivierte Resources massenhaft loeschen | Mittel |
| **Resource Filtering** | `?source_type=pangolin\|traefik`, `?status=active\|disabled\|all` Query-Parameter | Mittel |
| **Pagination** | `?page=N&page_size=M` auf Resources | Niedrig |
| **ENABLE_FILE_CONFIG** | Optionaler File-Config-Generator (standardmaessig deaktiviert, nur API-Proxy) | Hoch |
| **GENERATE_INTERVAL_SECONDS** | Intervall fuer File-Config-Generierung | Niedrig |
| **UI_PATH / CONFIG_DIR** | Interne Pfad-Konfiguration | Niedrig |
| **Traefik API Auto-Discovery** | `DiscoverTraefikAPI()` in `main.go` - probiert mehrere URLs wenn `TRAEFIK_API_URL` nicht gesetzt | Mittel |
| **Database Cleanup on Startup** | `db.PerformFullCleanup()` bei jedem Start | Niedrig |
| **WAL Mode / SQLite Tuning** | Automatisches WAL-Mode, busy_timeout, Connection-Limits | Niedrig |
| **mTLS Certs Base Path** | `PUT /mtls/config/path` - Aenderung des CA-Basispfads | Niedrig |
| **CertImportGuide** | UI-Komponente fuer Client-Zertifikat-Import-Anleitung | Niedrig |

### 3.2 Teilweise dokumentierte Features

| Feature | Was fehlt |
|---|---|
| **API Overview** | Endpoints fuer Security (`/api/security/*`) fehlen komplett. External Middlewares Endpoints fehlen. `bulk-delete-disabled` fehlt. Pagination/Filter-Parameter nicht erwaehnt. |
| **Security & mTLS (UI Guide)** | Beschreibt nur mTLS. TLS Hardening und Secure Headers (die im selben SecurityHub.tsx leben) fehlen komplett. |
| **Environment Variables** | 4 Variablen fehlen (`GENERATE_INTERVAL_SECONDS`, `ENABLE_FILE_CONFIG`, `UI_PATH`, `CONFIG_DIR`) |
| **Config Overview** | Erwaehnt nicht den API-Proxy-Modus (Standard) vs. File-Config-Modus (`ENABLE_FILE_CONFIG`) |
| **Resources UI Guide** | External Middlewares, TLS Hardening Toggle, Secure Headers Toggle pro Resource nicht erwaehnt |

### 3.3 Gut dokumentierte Features

- Middleware CRUD und Zuweisung
- Service CRUD und Typen (loadBalancer, weighted, mirroring, failover)
- Data Source Wechsel (Pangolin/Traefik)
- Plugin Hub Workflow
- mTLS (CA, Client Certs, Plugin-Detection, Per-Resource mTLS)
- Traefik Explorer
- Deploy-Guides (Pangolin + Standalone)
- Reverting/Rollback
- Troubleshooting (Grundlagen)
- Backups

---

## 4. Veraltete oder inkorrekte Inhalte

| Datei | Problem |
|---|---|
| `environment.mdx` | `TRAEFIK_API_URL` Default ist als `http://host.docker.internal:8080` angegeben, im Code steht `http://traefik:8080` |
| `config-overview.mdx` | Beschreibt nur File-Provider-Modus ("emitted into `/conf`"), aber Standard ist jetzt API-Proxy-Modus (`ENABLE_FILE_CONFIG` muss explizit aktiviert werden) |
| `docker-compose.yml` (Root) | Nutzt `version: '3.8'` (deprecated in aktuellen Docker Compose Versionen), Volumes und Env-Vars passen nicht zum aktuellen Code |
| `test.mdx` | Demo/Testseite mit "Hello World" Code-Block und Fumadocs-Links - sollte entfernt oder versteckt werden |
| `api/overview.mdx` | Screenshot-Platzhalter referenziert "Swagger link (if added)" - Swagger existiert nicht |
| Alle MDX-Dateien | Enthalten `Screenshot placeholder` Bloecke die nie befuellt wurden (17+ Platzhalter) |
| `deploy-pangolin.mdx` | Schreibt `TRAFFIC_API_URL` (Typo) statt `TRAEFIK_API_URL` |
| `security-mtls.mdx` | Titel ist "Security & mTLS" aber beschreibt nur mTLS - kein Wort ueber TLS Hardening / Secure Headers |

---

## 5. Build-Konfiguration (Static Export)

### next.config.mjs

```js
import { createMDX } from 'fumadocs-mdx/next';
const withMDX = createMDX();
const config = {
  reactStrictMode: true,
};
export default withMDX(config);
```

**Status: Kein `output: 'export'` vorhanden.**

Die Docs nutzen Next.js 16 mit Fumadocs. Fuer einen statischen Build (z.B. GitHub Pages Deployment) muss `output: 'export'` hinzugefuegt werden. Allerdings gibt es Einschraenkungen:

- `app/api/search/route.ts` (Server-Side API Route) ist inkompatibel mit Static Export
- `app/llms-full.txt/route.ts` (Server-Side Route) ebenfalls inkompatibel
- `app/og/docs/[...slug]/route.tsx` (OG Image Generation) ebenfalls inkompatibel

**Fazit:** Fuer Static Export muessen die API-Routes entfernt oder durch Client-Side-Alternativen ersetzt werden. Fumadocs unterstuetzt Static Export offiziell, aber die Search-Route muss auf `fumadocs-core` Static Search umgestellt werden.

### package.json

- Build-Script: `next build` (Standard)
- Kein explizites Export-Script vorhanden
- Dependencies sind aktuell (Next.js 16, React 19, fumadocs 16.2.2)
- Keine veralteten oder unsicheren Dependencies erkennbar

### Deployment-Status

Die Live-Docs unter https://middleware-manager.hhf.technology/ sind erreichbar und zeigen die gleiche Seitenstruktur wie im Repo. Die Seite wird vermutlich ueber Vercel oder einen aehnlichen SSR-faehigen Host deployed (nicht statisch).

---

## 6. Empfehlungen und Aufwandsschaetzung

### Prioritaet 1: Fehlende Feature-Dokumentation

| Aufgabe | Datei(en) | Aufwand |
|---|---|---|
| Security Hub komplett dokumentieren (TLS Hardening + Secure Headers + Duplicate Detection) | Neue Datei `security/security-hub.mdx` oder `security-mtls.mdx` erweitern | 3-4h |
| External Middlewares dokumentieren | `ui-guides/resources.mdx` erweitern | 1-2h |
| API Overview vervollstaendigen (Security, External MW, Bulk-Delete, Pagination) | `api/overview.mdx` | 2-3h |
| ENABLE_FILE_CONFIG vs. API-Proxy-Modus erklaeren | `configuration/config-overview.mdx` + `environment.mdx` | 1-2h |
| Fehlende Env-Vars ergaenzen | `configuration/environment.mdx` | 30min |

### Prioritaet 2: Korrekturen veralteter Inhalte

| Aufgabe | Datei(en) | Aufwand |
|---|---|---|
| TRAEFIK_API_URL Default korrigieren | `environment.mdx` | 15min |
| TRAFFIC_API_URL Typo fixen | `deploy-pangolin.mdx` | 5min |
| Config-Overview: API-Proxy als Standard beschreiben | `config-overview.mdx` | 30min |
| test.mdx entfernen oder aus Navigation nehmen | `test.mdx`, `meta.json` | 5min |
| Screenshot-Platzhalter durch echte Screenshots ersetzen oder entfernen | Alle MDX-Dateien (17+) | 2-4h |

### Prioritaet 3: Strukturelle Verbesserungen

| Aufgabe | Beschreibung | Aufwand |
|---|---|---|
| Security-Sektion aufteilen | Eigene Seiten fuer mTLS, TLS Hardening, Secure Headers, Duplicate Detection | 2-3h |
| Changelog / Release Notes Seite | Aenderungshistorie fuer Nutzer | 1-2h |
| Architecture / How It Works Seite | Erklaerung Config-Proxy-Flow, Watcher-Pattern, DB-Schema | 2-3h |
| FAQ Seite | Haeufige Fragen aus Discord/Issues | 1-2h |
| Static Export vorbereiten | `output: 'export'`, Search umstellen, API-Routes entfernen | 2-3h |

### Gesamtaufwand

| Prioritaet | Geschaetzter Aufwand |
|---|---|
| P1: Fehlende Features | 8-12h |
| P2: Korrekturen | 3-5h |
| P3: Strukturell | 8-13h |
| **Gesamt** | **19-30h** |

---

## 7. Zusammenfassung

Die bestehende Dokumentation deckt die Kern-Features (Middlewares, Services, Plugins, mTLS, Data Sources) solide ab und hat eine saubere Struktur. Die kritischsten Luecken sind:

1. **Security Hub ist nur halb dokumentiert** - TLS Hardening und Secure Headers (beides in Code und UI vorhanden) fehlen komplett in den Docs
2. **External Middlewares** - ein signifikantes Feature (Traefik-native Middlewares zuweisen) ohne jede Dokumentation
3. **API-Proxy vs. File-Config** - der Default-Betriebsmodus (API-Proxy) ist nicht als solcher dokumentiert; die Docs beschreiben noch den File-Provider-Modus als Standard
4. **API Reference unvollstaendig** - ca. 15 Endpoints fehlen in der API Overview
5. **17+ Screenshot-Platzhalter** - alle Seiten haben leere Platzhalter die nie befuellt wurden
6. **Kein Static Export** - `output: 'export'` fehlt, Server-Side Routes verhindern statischen Build
