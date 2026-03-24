# HHF Technology Documentation — Build & Staging
DOCKER_REGISTRY ?= ghcr.io/strausmann

.PHONY: help
help: ## Show all targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# === Submodules ===

.PHONY: submodules-init
submodules-init: ## Initialize git submodules
	git submodule update --init --recursive

.PHONY: submodules-update
submodules-update: ## Update submodules to latest upstream
	git submodule update --remote --merge

# === CrowdSec Manager Docs ===

.PHONY: docs-crowdsec-build
docs-crowdsec-build: ## Build CrowdSec Manager Docs Docker image
	docker build -f staging/Dockerfile.fumadocs \
		-t $(DOCKER_REGISTRY)/docs-crowdsec-manager:latest \
		projects/crowdsec-manager/docs/

.PHONY: docs-crowdsec-serve
docs-crowdsec-serve: ## Serve CrowdSec Manager Docs locally (port 8081)
	docker run --rm -p 8081:3000 --name docs-crowdsec $(DOCKER_REGISTRY)/docs-crowdsec-manager:latest

.PHONY: docs-crowdsec-dev
docs-crowdsec-dev: ## Start Fumadocs dev server for CrowdSec (hot-reload)
	cd projects/crowdsec-manager/docs && npm run dev

# === Middleware Manager Docs ===

.PHONY: docs-middleware-build
docs-middleware-build: ## Build Middleware Manager Docs Docker image
	docker build -f staging/Dockerfile.fumadocs \
		-t $(DOCKER_REGISTRY)/docs-middleware-manager:latest \
		projects/middleware-manager/docs/docs/

.PHONY: docs-middleware-serve
docs-middleware-serve: ## Serve Middleware Manager Docs locally (port 8082)
	docker run --rm -p 8082:3000 --name docs-middleware $(DOCKER_REGISTRY)/docs-middleware-manager:latest

.PHONY: docs-middleware-dev
docs-middleware-dev: ## Start Fumadocs dev server for Middleware (hot-reload)
	cd projects/middleware-manager/docs/docs && npm run dev

# === Both ===

.PHONY: build-all
build-all: docs-crowdsec-build docs-middleware-build ## Build both Docs images

.PHONY: serve-all
serve-all: ## Start both Docs locally (ports 8081 + 8082)
	docker run -d --rm -p 8081:3000 --name docs-crowdsec $(DOCKER_REGISTRY)/docs-crowdsec-manager:latest
	docker run -d --rm -p 8082:3000 --name docs-middleware $(DOCKER_REGISTRY)/docs-middleware-manager:latest
	@echo "CrowdSec Manager Docs: http://localhost:8081"
	@echo "Middleware Manager Docs: http://localhost:8082"

.PHONY: stop-all
stop-all: ## Stop both local Docs containers
	docker stop docs-crowdsec docs-middleware 2>/dev/null || true

.PHONY: clean
clean: ## Remove Docker images
	docker rmi $(DOCKER_REGISTRY)/docs-crowdsec-manager:latest 2>/dev/null || true
	docker rmi $(DOCKER_REGISTRY)/docs-middleware-manager:latest 2>/dev/null || true
