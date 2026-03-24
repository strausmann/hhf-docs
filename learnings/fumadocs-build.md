# Learning: Fumadocs Build Issues

**Date:** 2026-03-24
**Project:** both
**Phase:** build

## Problem 1: Node.js Version Mismatch
Next.js 16 requires Node.js >= 20. Using Node 18 in Dockerfile caused silent build failure.

## Root Cause
Package.json specifies `next: ^16.0.7` but Dockerfile used `node:18-alpine`.

## Fix
Changed Dockerfile to `node:20-alpine`.

## Prevention
Always check `next` version in package.json before choosing Node.js base image.

---

## Problem 2: Static Export Not Possible
Both projects have server-side API routes (search, robots.txt, OG images, sitemap, llms-full.txt) that prevent `output: 'export'` in next.config.

## Root Cause
Fumadocs projects use dynamic routes that require a Node.js server at runtime.

## Fix
Use server mode instead of static export. Dockerfile runs `npx next start` instead of serving static files with nginx.

## Prevention
Before attempting static export, always check for:
- `src/app/api/` routes
- `robots.ts`, `sitemap.ts` files
- Dynamic `[...slug]` routes with `revalidate`
- OG image generation routes

---

## Problem 3: npm ci Fails Without Source Files
`fumadocs-mdx` has a `postinstall` script that needs `source.config.ts` and `content/` directory.

## Root Cause
Standard Docker pattern copies package.json first, runs npm ci, then copies source. But postinstall runs during npm ci and needs the config file.

## Fix
Copy ALL files before running `npm ci` (sacrifices layer caching but works reliably).

## Prevention
In Dockerfile, always `COPY . .` before `RUN npm ci` for Fumadocs projects.

---

## Integrated Into
- [x] Dockerfile.fumadocs updated (Node 20, server mode, full COPY before npm ci)
- [x] ops-agent instructions include these known issues
- [x] Makefile uses correct build targets
