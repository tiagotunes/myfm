# Windows Development Environment Setup

This guide documents the Windows development environment used for MyFM.

It is intended to make the workstation reproducible and provide a reference for future maintenance or onboarding.

## 1. Development Environment Overview

MyFM development takes place on a Windows 11 PC.

The development workstation is responsible for:

- Flutter mobile application development.
- NestJS backend development.
- Local PostgreSQL development.
- Docker-based local services.
- Git operations and GitHub collaboration.
- Android emulator and physical-device testing.

The Tasforge Ubuntu Server is reserved for DEV and PROD deployments, not day-to-day development.

## 2. Verified Software Baseline

The following versions were verified during the initial workstation setup.

| Software             | Verified version |
| -------------------- | ---------------- |
| Windows              | Windows 11 25H2  |
| Git                  | 2.52.0.windows.1 |
| Visual Studio Code   | 1.144.0          |
| Flutter              | 3.38.9 (stable)  |
| Dart                 | 3.10.8           |
| Node.js              | 24.11.0          |
| npm                  | 11.6.1           |
| Docker Desktop       | 29.7.2           |
| Docker Compose       | 5.4.0            |
| Android SDK          | 36.1.0           |
| Android Build Tools  | 36.1.0           |
| Android Debug Bridge | 36.0.2           |
| Java JDK             | 21.0.8           |

These are recorded baseline versions, not a requirement to remain on these versions indefinitely. Upgrades should be deliberate and tested.

## 3. Repository Location

The local repository is stored at:

```text
D:\projetos\myfm
```

The equivalent Git Bash path is:

```bash
/d/projetos/myfm
```

Open the repository in VS Code:

```bash
cd /d/projetos/myfm
code .
```

## 4. Terminal and Shell

Git Bash is the preferred terminal for routine development and Git operations.

Use Git Bash for:

- Git commands.
- Flutter commands.
- Docker commands.
- Node.js commands.
- Project scripts.

Some Windows-specific Android SDK operations may require Windows executables such as `.bat` files. These can be invoked from Git Bash when necessary.

PowerShell is also available for Windows-specific troubleshooting.

## 5. Git Configuration

Configure Git to normalise line endings when committing:

```bash
git config --global core.autocrlf input
```

Verify:

```bash
git config --global --get core.autocrlf
```

Expected result:

```text
input
```

Check the installed Git version:

```bash
git --version
```

## 6. Flutter and Dart

Flutter is installed at:

```text
C:\flutter
```

Verify the installation:

```bash
flutter --version
dart --version
flutter doctor -v
```

The initial setup completed successfully with no reported issues.

### Android development support

Flutter uses the Android SDK installed by Android Studio.

The Android SDK location is normally:

```text
%LOCALAPPDATA%\Android\Sdk
```

The installed Android components include:

- Android SDK Platform 36.
- Android SDK Build Tools 36.1.0.
- Android SDK Command-line Tools 22.0.
- Android Platform Tools.

Check the SDK configuration:

```bash
flutter doctor -v
```

### Android licences

Android SDK licence acceptance was completed during the initial workstation setup.

If licences need to be checked or accepted again, use PowerShell:

```powershell
$Sdk = "$env:LOCALAPPDATA\Android\Sdk"
& "$Sdk\cmdline-tools\22.0\bin\sdkmanager.bat" --licenses
```

Accept the required licences when prompted.

## 7. Java Development Kit

Android Studio includes a bundled Java Development Kit.

The verified JDK location is:

```text
C:\Program Files\Android\Android Studio\jbr
```

Flutter detects the Android Studio JDK automatically.

If a temporary Java configuration is needed in PowerShell:

```powershell
$env:JAVA_HOME = "C:\Program Files\Android\Android Studio\jbr"
$env:Path = "$env:JAVA_HOME\bin;$env:Path"
```

This configuration applies only to the current PowerShell session.

Verify Java when needed:

```bash
java -version
```

## 8. Android Emulator and Physical Devices

An Android emulator is configured and available through Android Studio.

To inspect ADB-connected devices, use PowerShell:

```powershell
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" devices
```

You can also check Flutter's device detection from Git Bash:

```bash
flutter devices
```

The initial setup successfully detected an Android emulator.

### Physical Android devices

A physical Android phone can also be used for testing.

USB debugging and Android Debug Bridge (ADB) can be used for local USB testing.

For MyFM's remote DEV environment, the Android phone is also connected to Tailscale. This allows it to reach private DEV services without exposing the development API publicly.

Tailscale connectivity and ADB connectivity are separate:

- Tailscale provides private network connectivity.
- ADB provides Android debugging and installation capabilities.

A device being connected to Tailscale does not automatically make it visible to ADB.

## 9. Node.js and npm

Node.js and npm are installed on Windows.

Verify the versions:

```bash
node --version
npm --version
```

The initial setup uses:

- Node.js 24.11.0.
- npm 11.6.1.

### Windows PowerShell execution policy

On this workstation, PowerShell blocked the `npm.ps1` script because of the current execution policy.

There is no need to weaken the Windows execution policy for this project.

When using PowerShell, invoke the Windows command wrapper instead:

```powershell
npm.cmd --version
```

In Git Bash, use the normal command:

```bash
npm --version
```

## 10. Docker Desktop and WSL2

Docker Desktop is installed and configured to use the WSL2-based Linux engine.

Verify Docker:

```bash
docker --version
docker compose version
docker info
```

The initial verification confirmed that the Docker client and server were operational.

Docker is used for local infrastructure services, including PostgreSQL, and for reproducing deployment environments.

Do not install a separate Docker Engine inside WSL2 unless the project architecture explicitly requires it. Docker Desktop already provides the required Linux container engine.

## 11. Visual Studio Code

Visual Studio Code is the preferred editor.

Recommended extensions for MyFM development:

| Extension                 | Purpose                           |
| ------------------------- | --------------------------------- |
| Flutter                   | Flutter development support       |
| Dart                      | Dart language support             |
| Docker                    | Docker and Compose support        |
| ESLint                    | TypeScript and JavaScript linting |
| Prettier - Code formatter | Consistent formatting             |
| Prisma                    | Prisma schema support             |
| GitLens                   | Git history and code insights     |

These are recommended extensions; their installation should be verified separately.

Keep the repository as the VS Code workspace root.

## 12. Standard Workstation Verification

Run these commands from Git Bash when checking the development environment:

```bash
git --version
code --version
flutter --version
dart --version
flutter doctor -v
node --version
npm --version
docker --version
docker compose version
docker info
```

Check Android device availability:

```bash
flutter devices
```

To inspect ADB-connected devices, use PowerShell:

```powershell
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" devices
```

The ADB executable is not currently on the workstation's PATH, so use its full path unless that configuration changes.

A successful setup should report:

- Git available.
- VS Code available.
- Flutter and Dart available.
- Flutter Doctor without unresolved issues.
- Node.js and npm available.
- Docker client and server operational.
- Android emulator or physical device available when required.

## 13. Maintenance Principles

- Keep the development workstation software reasonably up to date.
- Upgrade major tool versions deliberately rather than automatically.
- Verify Flutter and Android compatibility after SDK or JDK upgrades.
- Keep project dependencies version-controlled.
- Never commit passwords, tokens, signing keys or environment-specific secrets.
- Prefer documented setup steps over undocumented manual changes.
- Update this guide whenever the development environment changes significantly.

## 14. Related Documentation

- [Architecture Overview](../architecture/overview.md)
- [Contributing Guide](../../CONTRIBUTING.md)
- [Security Policy](../../SECURITY.md)
