# Workflow: Documentation Contribution Process

## Overview

```
1. Edit docs in submodule    ──→  2. Build & test locally
   (projects/*/docs/)              (make docs-*-build/serve)
         │                                │
         ▼                                ▼
3. Push to hhf-docs repo     ──→  4. GitHub Actions builds
   (main branch)                   Docker image → GHCR
         │                                │
         ▼                                ▼
5. Staging auto-updates      ──→  6. Maintainer reviews staging
   (docs-*.strausmann.cloud)       (shares link via Discord)
         │                                │
         ▼                                ▼
7. Create PR to upstream     ──→  8. Maintainer merges
   (fork → hhftechnology/*)        upstream PR
```

## Step-by-Step

### 1. Edit Documentation

```bash
cd projects/crowdsec-manager/docs/content/docs/
# Edit existing pages or create new MDX files
vi features/bouncers.mdx
```

### 2. Build & Test Locally

```bash
make docs-crowdsec-build
make docs-crowdsec-serve
# Open http://localhost:8081 and verify changes
```

### 3. Commit to hhf-docs

```bash
# Commit in the submodule first
cd projects/crowdsec-manager
git checkout -b crowdsec/fix-bouncer-docs
git add docs/
git commit -m "docs: add bouncer management documentation"
git push origin crowdsec/fix-bouncer-docs

# Then update the submodule pointer in hhf-docs
cd ../..
git add projects/crowdsec-manager
git commit -m "docs: update crowdsec-manager submodule (bouncer docs)"
git push
```

### 4. GitHub Actions Builds Image

- Push to `main` triggers `build-crowdsec-docs.yml`
- Image pushed to `ghcr.io/strausmann/docs-crowdsec-manager:latest`
- PR branches get tagged as `pr-<number>`

### 5. Staging Auto-Updates

On hhdocker01, pull the new image:
```bash
docker pull ghcr.io/strausmann/docs-crowdsec-manager:latest
docker restart docs-crowdsec-staging
```

### 6. Maintainer Reviews

Share the staging URL with the maintainer:
- https://docs-crowdsec.strausmann.cloud
- https://docs-middleware.strausmann.cloud

### 7. Create Upstream PR

```bash
cd projects/crowdsec-manager
# Ensure fork is synced with upstream
gh repo sync strausmann/crowdsec_manager
# Create PR from our fork to upstream
gh pr create --repo hhftechnology/crowdsec_manager \
  --title "docs: add bouncer management documentation" \
  --body "..."
```

### 8. After Merge

```bash
# Sync fork with upstream after merge
gh repo sync strausmann/crowdsec_manager
cd projects/crowdsec-manager && git pull
cd ../.. && git add projects/crowdsec-manager
git commit -m "chore: sync submodule after upstream merge"
```

## Branch Strategy

| Branch | Purpose | Image Tag |
|--------|---------|-----------|
| `main` | Current staging state | `latest` |
| `crowdsec/*` | Feature branches per topic | `pr-<number>` |
| `middleware/*` | Feature branches per topic | `pr-<number>` |

## Dev Instances (per Branch)

For testing individual features before merging to main:
```bash
# Pull PR-specific image
docker pull ghcr.io/strausmann/docs-crowdsec-manager:pr-42
# Run on a different port
docker run -d --rm -p 8083:3000 --name docs-crowdsec-pr42 \
  ghcr.io/strausmann/docs-crowdsec-manager:pr-42
```

Later: Pangolin resources per branch (docs-crowdsec-dev.strausmann.cloud) if needed.

---

## Feature Branch Preview (ohne Merge in Fork-Main)

Um Aenderungen auf Staging zu sehen, OHNE sie in den Fork-main zu mergen:

### Option 1: PR im hhf-docs Repo (empfohlen)

```bash
# 1. Feature-Branch im Submodule pushen (bereits getan)
cd projects/crowdsec-manager
git push origin crowdsec/fix-incorrect-docs

# 2. PR im hhf-docs Repo erstellen
cd ../..
git checkout -b crowdsec/fix-incorrect-docs
git add projects/crowdsec-manager
git commit -m "docs: preview crowdsec incorrect docs fixes"
git push origin crowdsec/fix-incorrect-docs
gh pr create --title "[Preview] CrowdSec incorrect docs fixes"

# 3. pr-preview.yml baut automatisch:
#    ghcr.io/strausmann/docs-crowdsec-manager:pr-<N>

# 4. Preview-Image lokal oder auf Staging testen:
docker run --rm -p 8083:3000 ghcr.io/strausmann/docs-crowdsec-manager:pr-<N>
```

### Option 2: Manueller Build vom Feature-Branch

```bash
# Submodule auf den Feature-Branch wechseln
cd projects/crowdsec-manager
git checkout crowdsec/fix-incorrect-docs

# Lokal bauen
cd ../..
make docs-crowdsec-build
# Image wird mit :latest getaggt, NUR lokal

# Lokal testen
make docs-crowdsec-serve
# http://localhost:8081
```

### Option 3: workflow_dispatch mit Branch

```bash
# Build-Workflow manuell triggern (baut immer vom aktuellen Submodule-Stand)
gh workflow run "Build CrowdSec Manager Docs" --repo strausmann/hhf-docs
```

### Aenderungen zuruecknehmen

- **PR nicht mergen**: Einfach den PR schliessen → kein Merge in Fork-main
- **Feature-Branch loeschen**: `git push origin --delete crowdsec/fix-incorrect-docs`
- **Submodule zuruecksetzen**: `cd projects/crowdsec-manager && git checkout main`
- **Staging zuruecksetzen**: Neuen Build von main triggern

Kein Merge in Fork-main noetig um Aenderungen auf Staging zu sehen.
PRs koennen jederzeit geschlossen werden ohne Auswirkungen.
