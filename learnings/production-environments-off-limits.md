# Learning: Produktions-Instanzen sind tabu

**Date:** 2026-03-24
**Project:** both
**Phase:** build

## Problem
Es wurde vorgeschlagen die private CrowdSec Manager Instanz (crowdsec.strausmann.cloud) fuer Screenshots und Tests zu nutzen.

## Rule
Produktions-Instanzen des Users duerfen NIEMALS fuer Docs-Arbeit verwendet werden:
- Keine Screenshots von Produktions-UIs
- Keine API-Calls gegen Produktions-Endpoints
- Keine Test-Daten in Produktions-Systeme schreiben

Nur dedizierte Test-Instanzen (test-*.strausmann.cloud) sind erlaubt.

## Prevention
- CLAUDE.md hat eine "Environment Separation" Tabelle
- Alle Agents muessen Test-URLs verwenden, nie Produktions-URLs
- Screenshots: Immer pruefen ob die URL eine Test-Instanz ist

## Integrated Into
- [x] CLAUDE.md: Environment Separation table
- [x] Alle Agents: Nur Test-Instanzen
