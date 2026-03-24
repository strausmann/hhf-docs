# Learnings

This directory captures lessons learned during the documentation contribution process.
Each learning is documented here AND integrated into the relevant skills/agents.

## Process

1. **Problem encountered** → Document in a learning file
2. **Root cause identified** → Add to the relevant skill's `references/troubleshooting.md`
3. **Prevention defined** → Update agent instructions or CLAUDE.md conventions

## Index

| File | Topic | Date | Integrated Into |
|------|-------|------|-----------------|
| fumadocs-build.md | Fumadocs build issues and workarounds | 2026-03-24 | ops-agent, Dockerfile |

## Template

```markdown
# Learning: <Title>

**Date:** YYYY-MM-DD
**Project:** crowdsec-manager / middleware-manager / both
**Phase:** build / authoring / review / deployment

## Problem
What happened?

## Root Cause
Why did it happen?

## Fix
How was it resolved?

## Prevention
How do we prevent this in the future?

## Integrated Into
- [ ] Skill: <skill-name> / references/troubleshooting.md
- [ ] Agent: <agent-name> instructions updated
- [ ] CLAUDE.md convention added
- [ ] Dockerfile / Makefile updated
```
