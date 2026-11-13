# Contributing

Contributions should improve the application without hiding its current limitations or introducing unreviewed platform changes.

## Before starting

- Search existing issues and pull requests for related work.
- Open an issue for broad changes such as a Flutter SDK migration, Android embedding migration or dependency upgrade.
- Keep one pull request focused on one problem.
- Do not commit API keys, signing credentials, personal data, generated output or machine-specific SDK paths.

## Local environment

Use a Flutter/Dart toolchain compatible with the checked-in pubspec. The current CI baseline uses Flutter 2.10.5.

    flutter doctor -v
    flutter pub get
    flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

## Engineering expectations

- Keep presentation code in screens and provider/network behavior in services.
- Prefer typed models and explicit error states when changing response handling.
- Add unit tests for deterministic logic.
- Do not make automated tests depend on the live weather provider.
- Treat location coordinates and API keys as sensitive data.
- Preserve Android and iOS behavior when changing shared Dart code.
- Document new configuration and platform permissions.

## Before opening a pull request

Run:

    flutter analyze
    flutter test

Also manually test the affected flow on a supported emulator or device. If platform build tooling is changed, record the Flutter, Dart, Gradle, Android SDK, Xcode and CocoaPods versions used.

## Pull request description

Include the problem, the approach, visible behavior changes, tests performed, screenshots for UI changes and any remaining limitations. Do not claim a platform build passed unless it was actually run.
