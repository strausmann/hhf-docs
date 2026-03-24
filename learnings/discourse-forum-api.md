# Learning: Discourse Forum hat oeffentliche JSON-API

**Date:** 2026-03-24
**Project:** both
**Phase:** authoring

## Erkenntnis
Das HHF Forum (forum.hhf.technology) basiert auf Discourse und hat eine
frei zugaengliche JSON-API:

```bash
# Alle Topics
curl -sf "https://forum.hhf.technology/latest.json"

# Einzelnes Topic mit Posts
curl -sf "https://forum.hhf.technology/t/<slug>/<id>.json"

# Suche
curl -sf "https://forum.hhf.technology/search.json?q=keyword"
```

Kein API-Key noetig, kein Auth. Rate-Limiting beachten.

## Nutzung
- forum-scan.yml Workflow nutzt die API woechentlich
- Forum-Analyse kann jederzeit aktualisiert werden
- Top-Topics nach Views sortiert zeigen die groessten User-Schmerzpunkte

## Integrated Into
- [x] forum-scan.yml GitHub Actions Workflow
- [x] Forum-Analyse: analysis/forum-analysis.md
- [x] Alle Agents: Forum-Recherche als Pflicht
