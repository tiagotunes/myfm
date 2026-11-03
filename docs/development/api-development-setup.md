# API Development Setup

## 1. Purpose

This document defines the development standards, conventions and initial structure for the MyFM backend API.

The API will be developed using NestJS and TypeScript, following a modular monolith architecture.

The initial development environment runs the API directly on Windows 11, with PostgreSQL running in Docker.

## 2. Technology Stack

| Component            | Technology                                |
| -------------------- | ----------------------------------------- |
| Backend framework    | NestJS                                    |
| Programming language | TypeScript                                |
| Runtime              | Node.js 26 LTS                            |
| Package manager      | npm                                       |
| API architecture     | REST                                      |
| API documentation    | OpenAPI / Swagger                         |
| Database             | PostgreSQL                                |
| ORM                  | Prisma                                    |
| Configuration        | `@nestjs/config`                          |
| Request validation   | `class-validator` and `class-transformer` |
| Testing              | Jest                                      |
| Code quality         | ESLint and Prettier                       |

Dependencies must be managed through npm. The `package-lock.json` file must be committed to Git to ensure reproducible dependency installations.

## 3. Node.js and npm Requirements

The API development environment requires Node.js 26 LTS.

The current verified workstation baseline is:

- Node.js: 26.13.0
- npm: 11.20.0

The project should declare its supported Node.js major version through the `engines` field in `package.json`.

The supported range should be Node.js 26, excluding other major versions unless explicitly approved.

Use `npm ci` when installing dependencies from an existing lockfile, particularly in CI environments.

## 4. NestJS Project Structure

The API will reside in:

`apps/api/`

The initial project structure will follow this organisation:

```text
apps/api/
├── src/
│   ├── main.ts
│   ├── app.module.ts
│   ├── config/
│   ├── common/
│   │   ├── decorators/
│   │   ├── filters/
│   │   ├── guards/
│   │   ├── interceptors/
│   │   └── pipes/
│   └── modules/
│       ├── health/
│       └── ...
├── prisma/
│   └── schema.prisma
├── test/
├── package.json
├── package-lock.json
├── tsconfig.json
└── nest-cli.json
```

The structure may evolve as the application grows.

Business functionality must be organised into domain-specific modules.

The `common` directory is reserved for genuinely shared infrastructure and cross-cutting functionality. It must not become a general-purpose location for unrelated business logic.

Business modules should encapsulate their own controllers, services, DTOs and related functionality.

Modules must communicate through clearly defined interfaces and dependency injection.

## 5. Architecture Principles

The API will follow a modular monolith architecture.

Each business domain will be represented by a NestJS module.

The initial architecture will prioritise:

- Clear separation of responsibilities.
- High cohesion within modules.
- Controlled dependencies between modules.
- Reusable shared infrastructure.
- Testable business logic.
- Dependency injection through NestJS.

Microservices will not be introduced during the initial development phase.

## 6. REST API Conventions

The API will use REST principles and JSON for request and response payloads.

URI-based versioning will be used.

The initial global API prefix is:

`/api/v1`

Examples:

- `/api/v1/health`
- `/api/v1/auth`
- `/api/v1/users`

The initial version is `v1`.

Breaking API changes must be handled through an explicit versioning strategy rather than silently changing existing contracts.

HTTP methods and status codes must follow their intended semantics.

## 7. API Documentation

OpenAPI documentation will be generated using NestJS Swagger integration.

The documentation should describe:

- Available endpoints.
- HTTP methods.
- Request parameters and payloads.
- Response schemas.
- Authentication requirements.
- Relevant HTTP status codes.

Swagger UI will be available in local development.

Its exposure in DEV and PROD must be controlled through environment configuration and appropriate security measures.

## 8. Request Validation

All externally supplied request data must be validated.

The application will use:

- `class-validator` for validation rules.
- `class-transformer` for transformation.
- NestJS `ValidationPipe` for request validation.

The global validation configuration should:

- Reject invalid requests.
- Reject requests containing unexpected properties.
- Transform incoming payloads where appropriate.
- Use DTOs to define request contracts.

Validation must not rely exclusively on Flutter client-side checks.

The API remains responsible for validating all incoming requests.

## 9. Configuration and Environment Variables

Environment-specific configuration will be managed through `@nestjs/config`.

The application must support separate LOCAL, DEV and PROD configuration.

Initial configuration variables are expected to include:

| Variable       | Purpose                    |
| -------------- | -------------------------- |
| `NODE_ENV`     | Execution environment      |
| `PORT`         | API listening port         |
| `DATABASE_URL` | Prisma database connection |

Additional variables will be introduced when required by specific functionality.

Configuration must be validated during application startup.

Secrets must never be committed to Git.

Actual environment files must remain excluded through `.gitignore`.

## 10. Database Integration

Prisma will be the database access layer.

The Prisma schema and migrations will be maintained inside the API project.

The responsibilities will be separated as follows:

- Prisma defines database models and relationships.
- Prisma migrations manage database schema changes.
- NestJS modules implement business logic.
- Services use Prisma for database operations.

Business logic must not be placed inside controllers or duplicated in database schema definitions.

Database transactions must be used when a business operation requires multiple related changes to succeed or fail together.

## 11. Testing Strategy

The API will use Jest and the testing facilities provided by NestJS.

The initial testing strategy includes:

### Unit Tests

Test individual services, business rules and isolated components.

### Integration Tests

Test interactions between related components and infrastructure where appropriate.

### End-to-End Tests

Test complete HTTP request flows through the API.

Tests must be maintainable, repeatable and independent of production data.

Critical business logic and security-sensitive functionality must receive appropriate test coverage.

## 12. Code Quality and Development Standards

The project will use ESLint and Prettier.

Development standards include:

- TypeScript strictness where supported by the generated project configuration.
- Consistent formatting.
- Meaningful names for modules, classes and methods.
- Small, focused services and controllers.
- Explicit DTOs for request validation.
- No committed secrets or local environment files.
- Automated tests for relevant functionality.

Conventional Commits must be used for Git commit messages, following the repository contribution guidelines.

## 13. Local Development Workflow

The standard API development workflow is:

1. Start Docker Desktop.
2. Start the local PostgreSQL container.
3. Install dependencies using npm when necessary.
4. Start NestJS in development mode.
5. Develop and debug using Visual Studio Code.
6. Run unit and end-to-end tests as appropriate.
7. Verify API functionality locally.
8. Commit changes to a feature branch.
9. Submit a pull request to `development`.

The API will initially listen on port `3000`.

The network binding must support Windows local development, Android Emulator access and authorised physical-device access through Tailscale, without exposing the API publicly.

## 14. Security Principles

The API must follow these principles:

- Validate all external input.
- Keep secrets outside source control.
- Use separate credentials and configuration per environment.
- Restrict CORS to explicitly configured origins.
- Do not expose PostgreSQL publicly.
- Restrict physical-device API access to the authorised Tailscale network.
- Use HTTPS in production.
- Control Swagger documentation exposure in production.
- Never trust client-side validation as a substitute for backend validation.

Authentication, authorisation, rate limiting and other security controls will be implemented and documented as the corresponding application functionality is introduced.

## 15. Related Documentation

- [Architecture Overview](../architecture/overview.md)
- [Local Development Architecture](local-development-architecture.md)
- [Windows Development Setup](windows-setup.md)
- [Contributing Guidelines](../../CONTRIBUTING.md)
- [Security Policy](../../SECURITY.md)
