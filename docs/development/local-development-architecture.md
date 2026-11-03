# Local Development Architecture

## 1. Purpose

This document defines the architecture and operating principles for the MyFM local development environment.

The objective is to provide a reliable, reproducible development environment on Windows 11 while keeping development infrastructure independent from the DEV and PROD environments hosted on Tasforge.

## 2. Architecture Overview

MyFM uses a hybrid local development architecture:

- Flutter runs directly on Windows.
- NestJS runs directly on Windows.
- Prisma runs as part of the NestJS project.
- PostgreSQL runs inside a Docker container.
- Docker Compose manages the local database infrastructure.

This approach combines native development tooling with database isolation and reproducibility.

## 3. Components and Execution Environment

| Component          | Execution environment      | Responsibility                      |
| ------------------ | -------------------------- | ----------------------------------- |
| Flutter SDK        | Windows                    | Mobile application development      |
| Android Emulator   | Windows / Android Emulator | Mobile application testing          |
| NestJS             | Windows / Node.js          | Backend API                         |
| Prisma             | Windows / Node.js          | Database access and migrations      |
| PostgreSQL         | Docker container           | Relational database                 |
| Docker Compose     | Windows / Docker Desktop   | Local infrastructure management     |
| Visual Studio Code | Windows                    | Code editing and project management |
| Git                | Windows / Git Bash         | Version control                     |

The API will initially run directly on Windows in development mode, supporting automatic reload when source files change.

## 4. Network Configuration

The following addresses are the intended local development endpoints:

| Service                          | Address                 |
| -------------------------------- | ----------------------- |
| NestJS API from Windows          | `http://localhost:3000` |
| PostgreSQL from Windows          | `localhost:5432`        |
| NestJS API from Android Emulator | `http://10.0.2.2:3000`  |

### 4.1 Windows

The API and PostgreSQL will communicate through the local Windows network interface.

PostgreSQL will be published on the Windows loopback interface only, using Docker port mapping bound explicitly to `127.0.0.1`. It must not be exposed to the public or Tailscale network.

### 4.2 Android Emulator

The Android Emulator uses `10.0.2.2` as its special address for reaching services running on the Windows host.

The Flutter development build will therefore use:

`http://10.0.2.2:3000`

Android may restrict unencrypted HTTP traffic depending on application configuration. If necessary, the development build will use an Android network security configuration to permit cleartext traffic to the local development API.

Production builds must use HTTPS.

### 4.3 Physical Android Device

The Huawei Mate 20 Lite will access the development API through Tailscale.

When physical-device access is configured:

- The Windows workstation and Huawei must both be connected to the same authorised Tailscale network.
- NestJS must listen on an interface reachable through the Tailscale network.
- Windows Firewall rules must restrict access to the appropriate private network and API port.
- PostgreSQL must remain restricted to local access.
- The API must not be exposed through public port forwarding.

Tailscale connectivity does not automatically configure API access; the required network and firewall settings must be implemented separately.

### 4.4 API Network Binding

NestJS must be configured to listen on an appropriate network interface to support the intended clients.

The final configuration must support:

- Windows local development.
- Android Emulator access.
- Authorised physical-device access through Tailscale.

The API must not be made publicly accessible as a consequence of this configuration.

## 5. Database Isolation

MyFM will maintain three independent database environments:

| Environment | Location                    | Purpose                                      |
| ----------- | --------------------------- | -------------------------------------------- |
| LOCAL       | Windows workstation, Docker | Development and local testing                |
| DEV         | Tasforge                    | Integrated development and device validation |
| PROD        | Tasforge                    | Production application data                  |

Each environment must have independent:

- Database instances or isolated database deployments.
- Database credentials.
- Environment configuration.
- Persistent storage.
- Backup and recovery procedures appropriate to the environment.

Production credentials and production database data must not be used in the local development environment.

## 6. Configuration and Secrets

Environment-specific configuration must be kept outside source control.

The project will use:

- `.env` for local configuration.
- `.env.example` to document required configuration variables without containing actual secrets.
- Separate configuration and credentials for LOCAL, DEV and PROD.

Actual environment files and credentials must never be committed to Git.

The repository's `.gitignore` must protect environment files and other sensitive local configuration.

## 7. Database Management

PostgreSQL will be managed through Docker Compose.

The local database must use a persistent Docker volume so that container recreation does not unintentionally delete development data.

Prisma will manage:

- Database connectivity.
- Database schema definitions.
- Schema migrations.
- Database client generation.

Migration files must be committed to Git so that database changes can be reproduced in other environments.

Local migrations must be tested before being applied to DEV or PROD.

Production migrations must follow the project's deployment and backup procedures.

## 8. Local Development Workflow

The standard local development workflow is:

1. Start Docker Desktop.
2. Start the PostgreSQL container using Docker Compose.
3. Start NestJS in development mode.
4. Run the Flutter application on the Android Emulator or an authorised physical device.
5. Develop and debug using Visual Studio Code.
6. Run relevant tests.
7. Commit changes to a feature branch.
8. Submit a pull request to `development`.

The API and database must be available before running mobile features that depend on backend services.

## 9. Security Principles

The local development environment must follow these principles:

- PostgreSQL must not be publicly or remotely accessible.
- API access from physical devices must use the private Tailscale network.
- Windows Firewall must restrict access to the API port.
- Secrets must never be committed to Git.
- LOCAL, DEV and PROD credentials must remain separate.
- Production data must not be copied into LOCAL without an explicitly approved, sanitised-data process.
- Development configuration must not be reused for production deployments.
- Production API communication must use HTTPS.

## 10. Future Containerisation

The initial development environment deliberately runs NestJS directly on Windows.

Containerising the API may be introduced later when needed for CI, deployment consistency or other operational requirements.

This does not change the intended deployment architecture: Tasforge will host the DEV and PROD application services and databases using Docker-based infrastructure.

## 11. Related Documentation

- [Architecture Overview](../architecture/overview.md)
- [Windows Development Setup](windows-setup.md)
- [Contributing Guidelines](../../CONTRIBUTING.md)
- [Security Policy](../../SECURITY.md)
- [Repository README](../../README.md)
