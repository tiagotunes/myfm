# MyFM

MyFM is a mobile application and backend platform.

This repository contains the mobile application, backend API, infrastructure configuration and project documentation.

## Technology Stack

| Area             | Technology              |
| ---------------- | ----------------------- |
| Mobile           | Flutter / Dart          |
| Backend          | NestJS / TypeScript     |
| Database         | PostgreSQL              |
| ORM              | Prisma                  |
| Containerisation | Docker / Docker Compose |
| Source Control   | Git / GitHub            |

## Architecture

MyFM starts as a modular monolith:

- A Flutter mobile application.
- A NestJS backend API.
- A PostgreSQL database accessed through Prisma.
- Docker-based deployment environments.

See [Architecture Overview](docs/architecture/overview.md).

## Repository Structure

```text
apps/
  mobile/                 Flutter application
  api/                    NestJS backend

infrastructure/
  docker/                 Docker configuration
  scripts/                Operational scripts

docs/
  architecture/           Architecture documentation
  decisions/              Architecture decision records
  development/            Development guides
  product/                Product documentation

.github/
  workflows/              GitHub Actions workflows
  ISSUE_TEMPLATE/         Issue templates
```

## Development Environments

| Environment | Purpose                        | Location               |
| ----------- | ------------------------------ | ---------------------- |
| Local       | Application development        | Windows development PC |
| DEV         | Integration and device testing | Tasforge               |
| PROD        | Production deployment          | Tasforge               |

Development takes place on the Windows PC. Tasforge is reserved for deployment and testing.

Development APIs are intended to remain private and accessible through Tailscale.

## Branching Strategy

- `main`: production-approved code.
- `development`: integrated code for DEV testing.
- `feature/*`: new features.
- `bugfix/*`: development bug fixes.
- `hotfix/*`: urgent production fixes.

Changes to `main` and `development` must go through pull requests.

See [Contributing](CONTRIBUTING.md).

## Getting Started

Development setup instructions will be documented in:

- `docs/development/`

## Security

Never commit passwords, API keys, access tokens, private certificates or environment-specific secrets.

See [Security Policy](SECURITY.md).
