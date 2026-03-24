# Learning: Git Submodule Workflow — zwei Commits noetig

**Date:** 2026-03-24
**Project:** both
**Phase:** build

## Problem
Aenderungen in Submodules erfordern ZWEI separate Commits:
1. Commit im Submodule selbst (der Fork)
2. Commit im Parent-Repo (hhf-docs) der den Submodule-Pointer aktualisiert

Vergisst man Schritt 2, zeigt das Parent-Repo auf den alten Stand.

## Rule
Nach Aenderungen in einem Submodule immer:
```bash
# 1. Im Submodule committen und pushen
cd projects/crowdsec-manager
git add . && git commit -m "..." && git push

# 2. Zurueck zum Parent, Pointer updaten
cd ../..
git add projects/crowdsec-manager
git commit -m "docs: update submodule pointer"
git push
```

## Prevention
- CONTRIBUTING.md dokumentiert den Workflow
- Makefile koennte einen `make commit-with-submodules` Target bekommen
- `git status` im Parent zeigt "modified: projects/..." wenn Pointer veraltet

## Integrated Into
- [x] CONTRIBUTING.md: Branch + Submodule Workflow dokumentiert
- [x] WORKFLOW.md: Step-by-Step Anleitung
