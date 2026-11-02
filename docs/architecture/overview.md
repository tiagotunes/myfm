# MyFM Architecture Overview

## 1. Architectural Approach

MyFM will initially use a modular monolith architecture.

The backend will be a single NestJS application organised into independent business modules. This keeps initial development and deployment manageable without preventing future architectural evolution.

The mobile application and backend API will remain separate applications.

## 2. Technology Stack

| Component          | Technology          |
| ------------------ | ------------------- |
| Mobile application | Flutter / Dart      |
| Backend API        | NestJS / TypeScript |
| Database           | PostgreSQL          |
| ORM                | Prisma              |
| Containerisation   | Docker              |
| Orchestration      | Docker Compose      |
| Source control     | Git / GitHub        |

## 3. High-Level Architecture

```text
+---------------------------+
|      Flutter Mobile       |
|       Application         |
+-------------+-------------+
              |
              | HTTPS / API
              |
+-------------v-------------+
|        NestJS API         |
|                           |
|      Modular Monolith     |
+-------------+-------------+
              |
              | Prisma
              |
+-------------v-------------+
|        PostgreSQL         |
+---------------------------+
```

## 4. Repository Organisation

- `apps/mobile`: Flutter application.
- `apps/api`: NestJS backend.
- `infrastructure/docker`: Docker and Compose configuration.
- `infrastructure/scripts`: operational and maintenance scripts.
- `docs`: architecture, development, decisions and product documentation.

## 5. Environments

### Local Development

- Runs on the Windows development PC.
- Used for application development and debugging.
- Uses local API and PostgreSQL services.
- Mobile application can run on an emulator or connected Android device.

### DEV

- Deployed on Tasforge.
- Uses isolated development API and database services.
- Intended for integration and device testing.
- Development API access is private through Tailscale.

### PROD

- Deployed on Tasforge.
- Uses separate production configuration, credentials, database and persistent storage.
- Production deployments require controlled approval.
- Backups must be considered before database migrations.

## 6. Mobile Connectivity

Flutter builds will use environment-specific API endpoints.

The DEV application will communicate with the DEV API over Tailscale.

The production application will use its separately configured production endpoint.

Development APIs must not be made publicly accessible.

## 7. Architectural Evolution

The initial implementation prioritises:

- Clear module boundaries.
- Maintainability.
- Automated testing.
- Secure configuration.
- Reproducible deployments.

Microservices are not part of the initial architecture. They may be considered later if concrete requirements justify the additional complexity.
