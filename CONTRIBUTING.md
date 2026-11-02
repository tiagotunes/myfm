# Contributing to MyFM

## Development Principles

- Development takes place on the Windows development PC.
- Tasforge is reserved for DEV and PROD deployments.
- Keep changes focused and reviewable.
- Never commit secrets or local environment files.
- Update documentation when architecture or workflows change.

## Branch Strategy

| Branch        | Purpose                     | Base          |
| ------------- | --------------------------- | ------------- |
| `main`        | Production-approved code    | -             |
| `development` | Integration and DEV testing | `main`        |
| `feature/*`   | New features                | `development` |
| `bugfix/*`    | Development bug fixes       | `development` |
| `hotfix/*`    | Urgent production fixes     | `main`        |

## Development Workflow

1. Update your local `development` branch.
2. Create a feature or bugfix branch from `development`.
3. Implement and test changes locally.
4. Commit changes using the conventions below.
5. Push your branch to GitHub.
6. Open a pull request targeting `development`.
7. Review and merge after checks pass.

Feature branches must not be deployed directly to Tasforge.

Changes targeting `main` must go through a pull request and the production release process.

## Commit Message Convention

Use Conventional Commits:

`type(scope): description`

Examples:

- `feat(mobile): add login screen`
- `feat(api): add authentication endpoint`
- `fix(api): handle expired access tokens`
- `docs(architecture): update system overview`
- `chore: update dependencies`
- `test(api): add authentication tests`

Common types:

- `feat`: new functionality
- `fix`: bug fix
- `docs`: documentation
- `refactor`: code restructuring
- `test`: tests
- `chore`: maintenance and tooling
- `build`: build system or dependencies
- `ci`: continuous integration

## Pull Requests

Pull requests should:

- Have a clear title and description.
- Explain the purpose of the change.
- Include relevant testing information.
- Reference related GitHub issues when applicable.
- Document any configuration or migration requirements.

## Testing

Changes should be tested locally before opening a pull request.

Automated CI checks will be introduced as the project evolves.
