# Learning: Fork-PRs haben keinen Zugriff auf Repo-Secrets

**Date:** 2026-03-24
**Project:** both
**Phase:** build

## Problem
Docker Build + Push Workflow schlug bei PR #64 (crowdsec_manager) fehl.
Login-Steps wurden "skipped", Build konnte nicht pushen.

## Root Cause
GitHub Actions Sicherheits-Feature: Pull Requests von Forks haben keinen
Zugriff auf die Secrets des Ziel-Repos (DOCKERHUB_USERNAME, GITHUB_TOKEN etc.).
Das ist beabsichtigt um Secret-Leaks zu verhindern.

## Rule
CI-Failures bei Fork-PRs die auf fehlende Secrets zurueckzufuehren sind,
sind KEINE Code-Probleme. Nicht versuchen zu "fixen" — einfach dokumentieren.

Der Build selbst funktioniert, nur der Push schlaegt fehl.
Nach dem Merge durch den Maintainer laeuft der Push-Workflow auf main erfolgreich.

## Prevention
- Bei Fork-PRs CI-Status pruefen: "skipped" Login-Steps = erwartetes Verhalten
- PR-Kommentar hinterlassen der das erklaert (haben wir bei #64 gemacht)

## Integrated Into
- [x] PR #64 Kommentar erklaert das Verhalten
