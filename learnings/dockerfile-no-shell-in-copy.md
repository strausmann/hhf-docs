# Learning: Docker COPY unterstuetzt keine Shell-Redirects

**Date:** 2026-03-24
**Project:** both
**Phase:** build

## Problem
`COPY --from=builder /app/public ./public 2>/dev/null || true` im Dockerfile
schlug fehl mit "/2>/dev/null: not found".

## Root Cause
COPY ist eine Dockerfile-Instruktion, kein Shell-Befehl.
Shell-Redirects (2>/dev/null) und Shell-Operatoren (||) funktionieren nicht.

## Fix
Entweder das Verzeichnis im Builder-Stage erstellen (mkdir -p) oder
die COPY-Zeile entfernen wenn das Verzeichnis nicht existiert.

## Prevention
- Dockerfile-Instruktionen (COPY, ADD, ENV) sind KEINE Shell-Befehle
- Shell-Logik nur in RUN-Instruktionen moeglich
- Optionale Dateien: Im Builder-Stage ein leeres Fallback erstellen

## Integrated Into
- [x] Dockerfile.fumadocs benutzt kein COPY mit Redirects
