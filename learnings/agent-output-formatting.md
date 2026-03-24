# Learning: Agent-Output korrekt in Dateien schreiben

**Date:** 2026-03-24
**Project:** both
**Phase:** build

## Problem
`analysis/repo-konzept.md` war auf GitHub unlesbar — gesamter Inhalt in 4 Zeilen mit escaped `\n` statt echten Zeilenumbrüchen.

## Root Cause
Der Agent-Output wurde per Python extrahiert und in eine Datei geschrieben. Dabei wurden `\n` als Literal-Strings statt als Zeilenumbrüche übernommen.

## Fix
```python
fixed = content.replace('\\n', '\n')
```

## Prevention
Beim Extrahieren von Agent-Outputs in Dateien:
- Output immer mit `cat` prüfen bevor committed wird
- Nicht `python3 -c` mit String-Manipulation auf Agent-Output nutzen
- Besser: Agent direkt in die Zieldatei schreiben lassen (Write-Tool im Agent)
- Nach Commit: `head -20 <file>` auf GitHub-Rendering prüfen

## Integrated Into
- [x] Dieses Learning dokumentiert
- [ ] Workflow-Konvention: Agent-Output vor Commit visuell prüfen
