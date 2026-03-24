# Repository-Konzept: hhf-docs

> Erstellt: 2026-03-24 | Refs: #101

## Repository-Konzept: `hhf-docs`

### 1. Repository-Name und Begründung

**Empfohlener Name: `hhf-docs`**

Begründung:
- Kurz und praegnant
- `hhf` steht klar fuer HHF Technology
- `docs` ist eindeutig als Dokumentations-Beitragsrepo erkennbar
- Alternativen wie `hhf-docs-contributions` oder `hhftechnology-docs` waeren laenger ohne Mehrwert
- GitHub-Owner: `strausmann/hhf-docs`

---

### 2. Verzeichnisstruktur

```
hhf-docs/
├── .claude/
│   ├── agents/
│   │   └── docs-agent.md                # Einziger Agent: Docs-Autor + Reviewer
│   ├── commands/
│   │   ├── docs/
│   │   │   ├── audit.md                 # documentation-audit als Command
│   │   │   ├── build.md                 # make docs-*-build Wrapper
│   │   │   └── review.md               # Code-Review fuer MDX-Aenderungen
│   │   └── quick-push.md               # Aus homelab uebernommen
│   ├── skills/
│   │   ├── docs-write/                  # 1:1 uebernehmen
│   │   │   └── SKILL.md
│   │   ├── documentation-audit/         # 1:1 uebernehmen
│   │   │   └── SKILL.md
│   │   ├── code-review/                 # 1:1 uebernehmen
│   │   │   └── SKILL.md
│   │   ├── code-review-expert/          # 1:1 uebernehmen (fuer PR-Reviews)
│   │   │   ├── SKILL.md
│   │   │   └── references/
│   │   ├── vercel-cli/                  # 1:1 uebernehmen (Fumadocs Vercel-Kontext)
│   │   │   └── SKILL.md
│   │   ├── tailwind-v4/                 # 1:1 uebernehmen (Fumadocs UI Styling)
│   │   │   └── SKILL.md
│   │   ├── github-actions-workflow/     # 1:1 uebernehmen (CI/CD)
│   │   │   ├── SKILL.md
│   │   │   └── references/
│   │   ├── gh-address-comments/         # 1:1 uebernehmen (Upstream PR Workflow)
│   │   │   ├── SKILL.md
│   │   │   └── scripts/
│   │   ├── fumadocs/                    # NEU: Fumadocs-spezifischer Skill
│   │   │   ├── SKILL.md
│   │   │   └── references/
│   │   │       ├── static-export.md
│   │   │       ├── mdx-components.md
│   │   │       └── troubleshooting.md
│   │   └── CLAUDE.md                    # Reduzierte Version (nur relevante Skills)
│   ├── settings.json
│   └── settings.local.json
├── projects/
│   ├── crowdsec-manager/                # Git Submodule: hhftechnology/crowdsec_manager (Fork)
│   └── middleware-manager/              # Git Submodule: hhftechnology/middleware-manager (Fork)
├── analysis/
│   ├── crowdsec-manager/
│   │   └── docs-analyse.md             # Aus homelab uebernommen
│   └── middleware-manager/
│       └── docs-analyse.md             # Aus homelab uebernommen
├── staging/
│   ├── Dockerfile.fumadocs              # Aus shared/ uebernommen
│   ├── docker-compose.yml               # NEU: Lokales Staging beider Projekte
│   └── nginx.conf                       # Falls Custom-Config noetig
├── .github/
│   ├── workflows/
│   │   ├── build-crowdsec-docs.yml      # CI: Docker Build bei Push
│   │   ├── build-middleware-docs.yml     # CI: Docker Build bei Push
│   │   └── pr-docs-check.yml           # CI: Lint + Build-Check bei PRs
│   └── ISSUE_TEMPLATE/
│       └── docs-contribution.yml        # Template fuer Docs-Issues
├── Makefile                             # Aus shared/ uebernommen + erweitert
├── CLAUDE.md                            # Angepasst fuer Docs-Kontext
├── README.md                            # Projekt-Uebersicht
├── .gitmodules                          # Submodule-Config
└── .gitignore
```

---

### 3. Skills-Auswahl und Begruendung

**Uebernehmen (9 Skills):**

| Skill | Begruendung |
|---|---|
| `docs-write` | Kern-Skill fuer MDX-Dokumentation schreiben |
| `documentation-audit` | Gap-Analyse und Drift-Erkennung gegen Codebase |
| `code-review` | Review von MDX-Aenderungen vor PR |
| `code-review-expert` | Tiefere Review mit SOLID-Lens fuer Code-Doku |
| `vercel-cli` | Fumadocs-Projekte laufen auf Vercel, Preview Deployments |
| `tailwind-v4` | Fumadocs UI nutzt Tailwind, Custom-Styling |
| `github-actions-workflow` | CI/CD fuer Docker-Builds |
| `gh-address-comments` | Upstream PR Review-Kommentare systematisch abarbeiten |
| `fumadocs` (NEU) | Dedizierter Skill fuer Fumadocs-Framework (Static Export, MDX, Config) |

**NICHT uebernehmen:**
- Alle homelab-spezifischen Skills (dockhand, pangolin, crowdsec, traefik, etc.)
- Alle Infrastruktur-Agents (ops-agent, ansible-agent, network-agent, etc.)
- Alle homelab-Commands (homelab/, pm/, agent/, notebooklm/)
- `sveltekit-svelte5-tailwind` und `svelte-skills-kit` (Fumadocs ist Next.js/React, nicht Svelte)

---

### 4. AI-Infrastruktur

**Uebernehmen:**
- **NICHT `load-vault.sh`** -- das neue Repo braucht keine Homelab-Secrets. GHCR-Auth laeuft ueber GitHub Actions `GITHUB_TOKEN`. Lokales Docker-Build braucht keine Vault-Credentials.
- **NICHT `load-env.sh`** -- kein Homelab-Service-Kontext.
- **NICHT `startup-check.sh`** -- keine SSH-Keys, kein Tailscale, keine Node-Pruefung noetig.

**MCP-Server:**
- **NICHT Pangolin MCP** -- Pangolin-Resources sind bereits erstellt, kein Laufzeit-Zugriff noetig
- **NICHT Vaultwarden MCP** -- keine Secrets im Docs-Repo
- **NICHT Proxmox MCP** -- kein Infrastruktur-Kontext
- **NICHT Cloudflare MCP** -- kein DNS-Management

Das Docs-Repo kommt komplett ohne MCP-Server und ohne `ai/` Verzeichnis aus. Alle Tools sind entweder in `.claude/skills/` oder im `Makefile`.

---

### 5. CLAUDE.md fuer das neue Repo

Das CLAUDE.md wird stark vereinfacht und fokussiert sich auf den Docs-Kontext:

**Kernpunkte:**
- Sprache: Englisch fuer die Upstream-Dokumentation (die HHF-Projekte sind englischsprachig), Deutsch fuer interne Planung/Analyse
- Commit-Messages: Englisch, Conventional Commits (`docs:`, `fix:`, `feat:`, `chore:`)
- Kein Doku-Policy-Zwang (das Repo IST die Doku)
- Kein Issue-Zwang fuer kleine Fixes (Typos, Korrekturen)
- Issue-Zwang fuer neue Seiten und groessere Ueberarbeitungen
- Git-Workflow: Feature-Branches pro Projekt (`crowdsec/fix-architecture`, `middleware/add-security-hub`)
- PR-Workflow: Erst lokales Staging bauen und pruefen, dann PR an upstream

**Konventionen aus homelab uebernehmen:**
- Secrets nie committen
- Tabellen alphabetisch sortiert
- Kein Co-Authored-By Claude in upstream PRs (Referenz: `feedback_no_coauthor_upstream.md`)
- Email fuer upstream PRs: `bjoern@strausmann.net`

---

### 6. Git Submodules vs. Forks

**Empfehlung: Forks als Git Submodules**

Workflow:
1. Fork `hhftechnology/crowdsec_manager` -> `strausmann/crowdsec_manager`
2. Fork `hhftechnology/middleware-manager` -> `strausmann/middleware-manager`
3. Beide Forks als Submodules in `projects/` einbinden:
   ```
   git submodule add git@github.com:strausmann/crowdsec_manager.git projects/crowdsec-manager
   git submodule add git@github.com:strausmann/middleware-manager.git projects/middleware-manager
   ```
4. Arbeiten erfolgt in Feature-Branches innerhalb der Submodules
5. PRs gehen von `strausmann/crowdsec_manager:feature-branch` -> `hhftechnology/crowdsec_manager:main`

**Vorteile:**
- Saubere Trennung: Eigenes Repo hat die Planung/Analyse/Staging, Submodules haben den Code
- Submodule-Pointer trackt exakt welcher Stand gebaut wird
- `git submodule update --remote` holt upstream-Aenderungen
- Lokales Arbeiten in den Submodules fuehlt sich an wie ein normales Repo

**Nachteile (akzeptabel):**
- Submodule-Handling ist etwas umstaendlicher (Makefile-Targets helfen)
- Clone braucht `--recurse-submodules`

---

### 7. Issue-Management

**Strategie: Issues im neuen Repo, Referenz im alten**

1. **Issue #101** (Meta-Issue) im homelab-Repo bleibt offen als Verweis:
   - Kommentar ergaenzen: \"Arbeit verlagert nach strausmann/hhf-docs\"
   - Label `status:moved` setzen
   
2. **Issues #102 und #103** im homelab-Repo schliessen mit:
   - Kommentar: \"Migrated to strausmann/hhf-docs#N\"
   - `Closes`-Referenz im neuen Issue

3. Im neuen Repo neue Issues anlegen:
   - `#1` — CrowdSec Manager Docs: Phase 1 (Kritische Luecken) — aus #102
   - `#2` — CrowdSec Manager Docs: Phase 2 (API-Doku) — aus #102
   - `#3` — Middleware Manager Docs: Phase 1 (Fehlende Features) — aus #103
   - `#4` — Middleware Manager Docs: Phase 2 (Korrekturen) — aus #103
   - `#5` — Staging-Infrastruktur: CI/CD + Pangolin-Deployment
   - `#6` — Fumadocs Static Export fuer beide Projekte

**Labels fuer das neue Repo:**
- `project:crowdsec-manager`
- `project:middleware-manager`
- `phase:1-critical`, `phase:2-api`, `phase:3-guides`
- `type:new-page`, `type:correction`, `type:infra`

---

### 8. Build-Tooling (Makefile)

Das bestehende Makefile wird erweitert fuer Submodule-Workflow:

```makefile
# Neue Targets (zusaetzlich zu den bestehenden):

submodules-init:     ## Submodules initialisieren
submodules-update:   ## Submodules auf neuesten upstream-Stand bringen
lint-crowdsec:       ## MDX-Lint fuer CrowdSec Docs
lint-middleware:     ## MDX-Lint fuer Middleware Docs
docs-crowdsec-dev:   ## Fumadocs Dev-Server fuer CrowdSec (Hot-Reload)
docs-middleware-dev: ## Fumadocs Dev-Server fuer Middleware (Hot-Reload)
```

Die bestehenden Clone-Targets (`docs-crowdsec-clone`, `docs-middleware-clone`) werden durch Submodule-Targets ersetzt. Der Dockerfile bleibt identisch, nur die Pfade aendern sich von `/tmp/` auf `projects/`.

---

### 9. CI/CD mit GitHub Actions

Zwei Workflows, analog zum bestehenden `docs-container-build.yml`:

**build-crowdsec-docs.yml:**
```yaml
on:
  push:
    branches: [main]
    paths: ['projects/crowdsec-manager/docs/**']
  workflow_dispatch:

# Build mit Dockerfile.fumadocs
# Push zu ghcr.io/strausmann/docs-crowdsec-manager:latest
# Optional: Dockhand Hawser Webhook
```

**build-middleware-docs.yml:**
```yaml
on:
  push:
    branches: [main]
    paths: ['projects/middleware-manager/docs/**']
  workflow_dispatch:

# Build mit Dockerfile.fumadocs
# Push zu ghcr.io/strausmann/docs-middleware-manager:latest
# Optional: Dockhand Hawser Webhook
```

**pr-docs-check.yml:**
```yaml
on:
  pull_request:
    paths: ['projects/*/docs/**']

# npm ci + npm run build in Fumadocs-Verzeichnis
# Validiert dass der Build nicht bricht
```

**Wichtig:** Submodules muessen in den Actions mit `submodules: recursive` ausgecheckt werden:
```yaml
- uses: actions/checkout@v4
  with:
    submodules: recursive
```

---

### 10. Staging-Deployment

**Pangolin-Resources (bereits erstellt laut Konzept):**

| Projekt | Subdomain | Container-Port |
|---|---|---|
| CrowdSec Manager Docs | docs-crowdsec.strausmann.cloud | 80 |
| Middleware Manager Docs | docs-middleware.strausmann.cloud | 80 |

**Deployment-Flow:**
1. Push auf `main` im `hhf-docs` Repo
2. GitHub Actions baut Docker-Image und pushed zu GHCR
3. Dockhand Hawser Webhook auf dem Ziel-Node triggered Pull
4. Oder: manuell `make docs-crowdsec-deploy` / `make docs-middleware-deploy`

**docker-compose.yml fuer Staging:**
```yaml
services:
  docs-crowdsec:
    image: ghcr.io/strausmann/docs-crowdsec-manager:latest
    ports: [\"8081:80\"]
    labels:
      - pangolin-resource: docs-crowdsec
  docs-middleware:
    image: ghcr.io/strausmann/docs-middleware-manager:latest
    ports: [\"8082:80\"]
    labels:
      - pangolin-resource: docs-middleware
```

---

### 11. Neuer Fumadocs-Skill

Der Fumadocs-Skill ist der wichtigste neue Skill, der im Homelab-Repo nicht existiert. Er sollte abdecken:

- Fumadocs Projektstruktur (`source.config.ts`, `content/docs/`, `meta.json`)
- MDX-Authoring mit Fumadocs-Komponenten (`Callout`, `Card`, `Tab`, `Step`, `Accordion`)
- Static Export Konfiguration und Einschraenkungen
- Search-Migration (Server-Side -> Client-Side Static Search)
- `next.config.mjs` Anpassungen
- Bekannte Issues (dynamische Routes, OG Images, Sitemap)

Die Inhalte der `docs-analyse.md` Dateien (CrowdSec + Middleware) liefern bereits viel Material fuer `references/static-export.md` und `references/troubleshooting.md`.

---

### 12. Implementierungsreihenfolge

**Schritt 1: Repo erstellen und Grundstruktur**
- `gh repo create strausmann/hhf-docs --private --description \"Documentation contributions for HHF Technology projects\"`
- Verzeichnisstruktur anlegen
- CLAUDE.md, README.md, .gitignore, Makefile schreiben
- `.claude/settings.json` einrichten

**Schritt 2: Forks und Submodules**
- Forks erstellen (falls nicht vorhanden)
- Submodules einbinden
- Submodule-Workflow testen

**Schritt 3: Skills uebertragen**
- 8 existierende Skills kopieren
- Fumadocs-Skill neu erstellen
- `.claude/skills/CLAUDE.md` erstellen (reduziert)

**Schritt 4: Analyse uebertragen**
- `docs-analyse.md` Dateien kopieren
- Staging-Dateien (Dockerfile, Makefile) anpassen

**Schritt 5: CI/CD einrichten**
- GitHub Actions Workflows erstellen
- GHCR-Zugang testen
- Erster Build-Test

**Schritt 6: Issues migrieren**
- Neue Issues im neuen Repo anlegen
- Alte Issues referenzieren und schliessen

**Schritt 7: Pangolin-Staging verifizieren**
- Docker-Images bauen und deployen
- Pangolin-Resources konfigurieren
- Staging-Umgebungen testen

---

### Critical Files for Implementation

- `/opt/homelab-management/docs/upstream-contributions/shared/Makefile` - Build-Grundlage, wird adaptiert fuer Submodule-Pfade
- `/opt/homelab-management/docs/upstream-contributions/shared/Dockerfile.fumadocs` - Docker-Build 1:1 uebernehmen
- `/opt/homelab-management/.github/workflows/docs-container-build.yml` - CI/CD-Pattern fuer die neuen Workflows
- `/opt/homelab-management/.claude/skills/docs-write/SKILL.md` - Kern-Skill fuer Dokumentations-Authori