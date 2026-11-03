# MyFM API

The backend API for MyFM, built with NestJS and TypeScript.

## Technology

<p align="left">
  <a href="https://nodejs.org/" target="_blank" rel="noopener noreferrer">
    <img src="https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d9/Node.js_logo.svg/330px-Node.js_logo.svg.png" height="64" alt="Node.js Logo" />
  </a>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://nestjs.com/" target="_blank" rel="noopener noreferrer">
    <img src="https://nestjs.com/img/logo-small.svg" height="64" alt="NestJS Logo" />
  </a>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://www.typescriptlang.org/" target="_blank" rel="noopener noreferrer">
    <img src="https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4c/Typescript_logo_2020.svg/960px-Typescript_logo_2020.svg.png" height="64" alt="TypeScript Logo" />
  </a>
</p>

- **Node.js 26** — Runtime
- **NestJS 11** — Backend framework
- **TypeScript** — Programming language
- **REST API** — API architecture
- **Jest** — Unit and end-to-end testing
- **ESLint and Prettier** — Code quality and formatting

## Prerequisites

- Node.js `>=26 <27`
- npm 11 or compatible
- Git

## Installation

From the repository root:

```bash
cd apps/api
npm ci
```

## Development

Start the API in development mode:

```bash
npm run start:dev
```

The default port is `3000`.

## Build

Compile the application:

```bash
npm run build
```

The compiled application is generated in `dist/`.

## Code quality

Check code quality:

```bash
npm run lint
```

Automatically fix supported lint issues:

```bash
npm run lint:fix
```

Format source and test files:

```bash
npm run format
```

## Testing

Run unit tests:

```bash
npm test -- --runInBand
```

Run end-to-end tests:

```bash
npm run test:e2e -- --runInBand
```

Run tests with coverage:

```bash
npm run test:cov
```

## Architecture

The API follows a **modular monolith** architecture. Business functionality will be organised into domain modules as the application evolves.

The planned database layer uses **Prisma** as the ORM and **PostgreSQL** as the database.

API endpoints will use the `/api/v1` URI prefix.

For further details, see the repository's `docs/architecture/` and `docs/development/` directories.

## Configuration and security

Environment-specific configuration and secrets must not be committed to the repository.

Never commit `.env` files, credentials, database passwords or private keys.

Development, staging and production environments must use separate configuration and database credentials.

## Environment Configuration

The API uses `@nestjs/config` to load environment variables and make application configuration available through NestJS dependency injection.

### Environment Variables

| Variable       | Required | Default       | Description                                                                          |
| -------------- | -------- | ------------- | ------------------------------------------------------------------------------------ |
| `NODE_ENV`     | No       | `development` | Application environment: `development`, `test`, or `production`.                     |
| `PORT`         | No       | `3000`        | HTTP server port (1–65535).                                                          |
| `DATABASE_URL` | Not yet  | —             | PostgreSQL connection URL. Will be required when database integration is introduced. |

Environment variables are validated during application startup. Invalid values prevent the API from starting.

### Local Setup

1. Copy `.env.example` to `.env` inside `apps/api/`.
2. Adjust the values in `.env` for your local environment.
3. Start the API using the development command.

Example:

```bash
cp apps/api/.env.example apps/api/.env
npm --prefix apps/api run start:dev
```

### Security

- Never commit `.env` files or actual credentials.
- `.env.example` contains placeholders only and is safe to commit.
- Keep environment-specific configuration separate between local development, DEV and PROD.
- Production secrets must be provided through the deployment environment, not stored in the repository.

### Configuration Implementation

Environment configuration is initialized globally in `src/app.module.ts`.

Validation is implemented in `src/config/env.validation.ts`, with automated tests in `src/config/env.validation.spec.ts`.
