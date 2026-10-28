# DevOps CI/CD Pipeline

A complete, beginner-friendly DevOps project: a small Python (Flask) web service wrapped in a modern delivery pipeline.

![CI](https://github.com/YOUR_USERNAME/devops-cicd-pipeline/actions/workflows/ci.yml/badge.svg)

## What's inside

| Area | Tool | Location |
|---|---|---|
| Application | Python, Flask, Gunicorn | `app/` |
| Automated tests and linting | Pytest, Flake8 | `tests/` |
| Containerization | Docker | `Dockerfile` |
| Local multi-service stack | Docker Compose | `docker-compose.yml` |
| CI/CD | GitHub Actions, GHCR | `.github/workflows/ci.yml` |
| Monitoring | Prometheus and Grafana | `monitoring/` |
| Orchestration | Kubernetes | `k8s/` |
| Infrastructure as Code | Terraform | `terraform/` |
| Automation | Make, Bash | `Makefile`, `scripts/` |

## Architecture

```
 git push ──► GitHub Actions ──► lint + test ──► build Docker image ──► push to GHCR
                                                                          │
                                  ┌───────────────────────────────────────┘
                                  ▼
                     Docker Compose / Kubernetes / Terraform
                                  │
                     App (/metrics) ──► Prometheus ──► Grafana
```

## Quick start

### Run locally (no Docker)
```bash
make install
make run          # http://localhost:5000
make test
```

### Run the full stack with Docker
```bash
make up
```
- App: http://localhost:5000 (also `/health` and `/metrics`)
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000 (login `admin` / `admin`, change this for anything real)

In Grafana, add a Prometheus data source with the URL `http://prometheus:9090`.

### Deploy to Kubernetes
Edit the image name in `k8s/deployment.yaml`, then:
```bash
kubectl apply -f k8s/
```

### Terraform (local Docker)
```bash
make build
cd terraform && terraform init && terraform apply
```

## CI/CD

On every push or pull request the pipeline lints and tests the code. On pushes to `main` it also builds the Docker image and publishes it to GitHub Container Registry (`ghcr.io/<you>/devops-cicd-pipeline`). No extra secrets are needed; it uses the built-in `GITHUB_TOKEN`.

## Ideas to extend it

- Add automatic deployment to a cloud provider (AWS, Azure, GCP)
- Add security scanning (Trivy, CodeQL)
- Add a Grafana dashboard JSON under `monitoring/`
- Use Helm or Kustomize for the Kubernetes manifests

## License

MIT
