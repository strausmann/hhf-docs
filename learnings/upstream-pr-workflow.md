# Learning: Upstream PRs nur nach Staging-Freigabe

**Date:** 2026-03-24
**Project:** both
**Phase:** review

## Problem
Agent hat gefragt ob Upstream-PRs sofort erstellt werden sollen, obwohl der Workflow klar definiert ist.

## Rule
PRs an Upstream-Repos werden NIEMALS direkt erstellt. Immer dieser Ablauf:

1. Aenderungen in Fork-Branch committen
2. Staging-Build ausloesen
3. Auf Staging-Umgebung verifizieren
4. Freigabe durch den User
5. ERST DANN Upstream-PR erstellen

Keine Ausnahmen — auch nicht fuer "offensichtliche" Fixes.

## Prevention
- CONTRIBUTING.md dokumentiert den Workflow bereits korrekt
- Agents duerfen nicht selbststaendig Upstream-PRs vorschlagen
- "Sollen wir den PR erstellen?" ist die falsche Frage — die richtige ist "Staging ist bereit zur Pruefung"

## Integrated Into
- [x] Dieses Learning dokumentiert
- [x] CONTRIBUTING.md hat den Workflow korrekt beschrieben
- [ ] Agent-Instruktionen aktualisieren: Nie Upstream-PR vorschlagen
