# Troubleshooting

## Flutter command not found

Install Flutter and add its bin directory to PATH. Run flutter doctor -v and resolve the missing SDK or platform components before building.

## Dependency resolution fails

Run:

    flutter clean
    flutter pub get

The project uses old package versions and a Dart 2.x constraint. If dependency resolution fails with a newer SDK, reproduce with the Flutter version used by CI before attempting a package migration. Do not solve a version conflict by randomly upgrading every dependency.

## Missing OpenWeatherMap key

Run with:

    flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

The key name is case-sensitive. The value must be supplied to each run or build command. If a key was previously exposed in a commit or binary, rotate it at the provider.

## HTTP 401 or 403

Check that the key is active, copied correctly and enabled for the Current Weather API. Confirm provider account restrictions and quota. Do not publish the key in an issue or screenshot.

## City not found

Check spelling and whether the provider recognizes the submitted city. The current form does not trim or validate the city field before submission. The service URL-encodes the entered string.

## Location lookup fails

Confirm that device location services are enabled and that the app has location permission. Test manual city search as a fallback. The current location service catches and prints exceptions but does not return a typed error state, so the screen may not explain the failure clearly.

## Weather screen remains on loading

The initial loading screen waits for location and weather calls before navigating. A failed or stalled request can leave the user without a useful recovery path. Check device network access, location permissions and provider key validity. The current implementation has no explicit timeout or retry UI.

## Android build reports embedding deprecation

The Android manifest still names the legacy FlutterApplication class. Flutter tooling warns that the project uses Android embedding v1. The long-term fix is a deliberate migration to embedding v2, followed by validation of plugin registration and Android builds. Do not silence the warning as a substitute for migration.

## Android SDK path points to another computer

Do not copy android/local.properties from another developer. Remove the local file if it contains an invalid SDK path, open the project with Flutter tooling or Android Studio, and allow the local SDK paths to be regenerated. The file is machine-specific and should not be committed.

## iOS CocoaPods issues

Run flutter pub get, then from the ios directory run pod install. Confirm that Xcode command-line tools and CocoaPods are installed. Old plugins may not support current Xcode versions; resolve compatibility as part of a planned dependency migration.

## Analyzer or tests fail

Run flutter analyze and flutter test locally using the same Flutter version as CI. Read the first actionable error rather than relying only on the final exit code. Keep fixes separate from broad SDK upgrades where possible.
