# Build and deployment guide

## Deployment model

Clima is a mobile client. There is no backend server or web deployment target in the current repository. Deployment means producing and distributing Android or iOS application builds.

## Pre-release checks

Before preparing a release:

1. Confirm the provider key is valid and restricted appropriately.
2. Rotate any key that has ever been committed or exposed.
3. Run flutter pub get, flutter analyze and flutter test.
4. Test city search and location weather on physical devices.
5. Test denied permission, disabled location services and offline behavior.
6. Review Android target SDK, compile SDK, Gradle and Android embedding compatibility.
7. Review iOS deployment target, Xcode version and CocoaPods compatibility.
8. Configure release signing outside the repository.
9. Confirm the privacy disclosure accurately describes location and provider data handling.
10. Build and install the release artifact on a clean device.

The current Android configuration uses old SDK and Gradle plugin values and the deprecated Flutter embedding. A successful Dart analysis run does not establish that a modern Android store release can be built or accepted.

## Android development build

    flutter build apk --debug --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

## Android release APK

    flutter build apk --release --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

## Android app bundle

    flutter build appbundle --release --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

The current Gradle configuration signs release builds with debug signing configuration. This is not suitable for production distribution. Configure a private release keystore and signing properties through a secure CI secret mechanism. Never commit the keystore or its passwords.

## iOS build

On macOS with Xcode and CocoaPods installed:

    flutter pub get
    cd ios
    pod install
    cd ..
    flutter build ios --release --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

App Store distribution additionally requires a valid Apple developer account, bundle identifier, signing certificate, provisioning profile, privacy disclosures and a tested archive. These are not configured by this repository documentation.

## Build artifacts

Flutter build outputs are generated under the build directory. Do not commit generated APKs, app bundles, iOS build products, local SDK paths or signing materials unless a deliberate release process requires a published artifact.

## CI scope

The existing GitHub Actions workflow installs Flutter 2.10.5 dependencies and runs flutter analyze. It does not currently build Android or iOS artifacts. The workflow is a Dart static-analysis gate, not a complete mobile release pipeline.

## Production readiness assessment

Do not describe this repository as production-ready until the legacy Android embedding and toolchain are migrated, release signing is configured, location and network failures are handled, the API-key distribution model is reviewed, and platform builds are validated on supported SDKs.
