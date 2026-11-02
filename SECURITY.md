# Security Policy

## Scope

This policy applies to the MyFM source code and its associated configuration.

## Reporting a Vulnerability

Please do not report security vulnerabilities through public GitHub issues.

Use GitHub's private vulnerability reporting feature if it is available for this repository.

If private vulnerability reporting is unavailable, contact the repository maintainer privately through GitHub.

Please include:

- A description of the vulnerability.
- Steps to reproduce it, where possible.
- Potential impact.
- Any suggested mitigation.

## Secrets and Sensitive Information

Never commit:

- Passwords.
- API keys or access tokens.
- Database credentials.
- Private SSH keys.
- Certificates or signing keys.
- Production environment files.
- Personal or production data.

Use environment variables and environment-specific secret storage.

Example environment files must contain placeholders only, never real credentials.

## Deployment Security

- Development and production environments must remain isolated.
- Development APIs must not be exposed publicly.
- Remote development access should use Tailscale.
- Production credentials must be separate from development credentials.
- Database backups and migrations must be handled carefully.
