# Contributing to MyFM

## Development workflow

1. Start from the latest `develop` branch.
2. Create a feature branch for each change.
3. Make focused commits with clear messages.
4. Push the feature branch to GitHub.
5. Open a pull request targeting `develop`.
6. Ensure all required GitHub Actions checks pass before merging.

Use branch names such as:

- `feature/user-profile`
- `fix/authentication-error`
- `docs/update-contributing-guide`

## Backend checks

The Backend CI workflow runs automatically on pushes and pull requests. It checks:

- Linting
- Unit tests
- End-to-end tests
- NestJS compilation
- Docker image build

Run these checks locally before opening a pull request when possible.

## Releases

Changes are promoted from `develop` to `main` through a pull request. The `main` branch represents production-ready code.

Do not commit secrets, passwords, JWT keys, or environment files containing credentials. Keep environment-specific configuration outside version control.

## Pull request expectations

- Explain what changed and why.
- Keep changes focused and easy to review.
- Include relevant test results.
- Address failing required CI checks before merging.
