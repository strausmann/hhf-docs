# HHF Technology — Documentation Contributions

Upstream documentation contributions for [HHF Technology](https://github.com/hhftechnology) projects.

## Projects

| Project | Upstream | Docs Staging |
|---------|----------|-------------|
| CrowdSec Manager | [hhftechnology/crowdsec_manager](https://github.com/hhftechnology/crowdsec_manager) | [docs-crowdsec.strausmann.cloud](https://docs-crowdsec.strausmann.cloud) |
| Middleware Manager | [hhftechnology/middleware-manager](https://github.com/hhftechnology/middleware-manager) | [docs-middleware.strausmann.cloud](https://docs-middleware.strausmann.cloud) |

## Quick Start

```bash
git clone --recurse-submodules https://github.com/strausmann/hhf-docs.git
cd hhf-docs
make help
```

## Build & Serve

```bash
make docs-crowdsec-build     # Build Docker image
make docs-crowdsec-serve     # Serve on http://localhost:8081
make docs-middleware-build   # Build Docker image
make docs-middleware-serve   # Serve on http://localhost:8082
```

See [CLAUDE.md](CLAUDE.md) for full workflow documentation.
