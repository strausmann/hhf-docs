# Learning: Zielgruppe und Community als Dokumentations-Quelle

**Date:** 2026-03-24
**Project:** both
**Phase:** authoring

## Erkenntnis 1: Zielgruppe sind Anfaenger

Die Dokumentation richtet sich an HomeLab-Einsteiger die mit Docker experimentieren,
nicht an erfahrene DevOps-Ingenieure. Jede Seite muss so geschrieben sein, dass
jemand ohne tiefes IT-Wissen damit klarkommt.

Das bedeutet:
- Keine impliziten Annahmen ueber Vorwissen
- Befehle vollstaendig zeigen (nicht nur Snippets)
- Ergebnis jedes Schritts beschreiben ("Du solltest jetzt X sehen")
- Fachbegriffe beim ersten Auftreten erklaeren
- Fehlerszenarien und deren Loesung dokumentieren

## Erkenntnis 2: Community-Forum als Qualitaetssignal

https://forum.hhf.technology/ — Wenn ein User dort eine Frage stellen muss,
war die Dokumentation nicht klar genug. Jede Forum-Frage ist ein Hinweis
auf eine Dokumentationsluecke.

**PFLICHT:** Vor dem Schreiben einer neuen Seite das Forum nach verwandten
Fragen durchsuchen. Haeufige Fragen muessen in der Doku beantwortet werden.

## Erkenntnis 3: Discord als Echtzeit-Feedback

Der Discord-Server hat ebenfalls User-Fragen und Maintainer-Antworten.
Diese sind wertvolle Quellen fuer:
- Haeufige Missverstaendnisse
- Workarounds die dokumentiert werden sollten
- Feature-Erklaerungen vom Maintainer selbst

## Prevention

Diese Erkenntnisse muessen in ALLE Teams/Agents integriert werden:
- team:marketing: Schreibstil an Anfaenger anpassen
- team:dev: API-Doku mit vollstaendigen Beispielen
- team:pm: Forum-Recherche als Pflicht-Schritt bei Issue-Klaerung

## Integrated Into
- [x] CLAUDE.md: Zielgruppen-Konvention
- [x] All agents: Forum-Recherche als Pflicht
- [x] content-plan.md: Style-Guide Update
