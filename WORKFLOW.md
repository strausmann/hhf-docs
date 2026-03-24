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
