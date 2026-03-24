# Learning: GitHub Actions immer auf neueste Version

**Date:** 2026-03-24
**Project:** both
**Phase:** build

## Problem
Node.js 20 Deprecation-Warnung in allen Workflows. Ab Juni 2026 werden
Actions auf Node.js 24 erzwungen.

## Rule
Bei jedem neuen Workflow und bei jedem Review immer die neuesten
Major-Versionen der GitHub Actions verwenden:

```yaml
# Korrekt (Stand Maerz 2026):
- uses: actions/checkout@v6
- uses: docker/build-push-action@v7
- uses: docker/login-action@v4
- uses: docker/metadata-action@v6
- uses: docker/setup-buildx-action@v4
```

Pruefen: `gh api repos/<owner>/<action>/releases/latest --jq '.tag_name'`

## Prevention
- Vor jedem Commit von Workflow-Dateien: Versionen pruefen
- Dependabot oder Renovate fuer automatische Updates einrichten (optional)

## Integrated Into
- [x] Alle 8 Workflows aktualisiert
- [x] Dieses Learning dokumentiert
