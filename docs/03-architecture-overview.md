# Architecture Overview

The application follows a Clean Architecture approach.

## Layers

- Presentation
  - Flutter UI
  - ViewModels / Controllers
- Domain
  - Entities
  - Use cases
  - Business rules
- Data
  - Repositories
  - API clients
  - Local persistence

The mobile application acts as a client that communicates with a backend
API responsible for authentication, persistence and validation.
