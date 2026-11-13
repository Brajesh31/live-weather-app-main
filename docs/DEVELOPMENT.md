# Development guide

## Supported toolchain

The checked-in pubspec currently constrains Dart to the 2.x range and pins older Flutter package versions. The CI workflow currently uses Flutter 2.10.5. Use that toolchain when reproducing the current baseline. A newer Flutter SDK may expose compatibility issues because the Android runner and dependencies are old.

Before upgrading Flutter or Dart, create a dedicated branch and record the current successful baseline. Upgrade the SDK, packages, Android Gradle plugin, Gradle wrapper and Android embedding as a coordinated migration. Do not change all of them in an unrelated documentation pull request.

## Clone and bootstrap

    git clone https://github.com/Brajesh31/live-weather-app-main.git
    cd live-weather-app-main
    flutter --version
    flutter doctor -v
    flutter pub get

Use flutter doctor to identify missing Android SDK, Xcode, CocoaPods or device configuration. Do not copy another developer's local.properties file. Android Studio or Flutter tooling should generate local SDK paths on each machine.

## Run the application

    flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

A valid provider key is required for both city and coordinate requests. Without it, WeatherModel raises a StateError before making a request.

For a physical Android device, enable developer options and USB debugging, connect the device and confirm it appears in:

    flutter devices

For an emulator, start an Android virtual device before running the app. Ensure the emulator has network connectivity and location services configured.

## Code map

Start at lib/main.dart. Follow the screen navigation through loading_screen.dart and location_screen.dart. WeatherModel in services/weather.dart owns the endpoint and condition mappings. NetworkHelper in services/networking.dart owns the HTTP call and JSON decoding. Location in services/location.dart owns the device position lookup.

Keep provider-specific parsing out of widget build methods. If response handling is improved, use a typed model and explicit error states rather than spreading dynamic map access across screens.

## Configuration and credentials

Use the Dart define shown above. Never commit a real key, private signing file, generated local SDK path or personal device configuration. A Dart define is a build-time injection mechanism, not a secure secret store. A production app should use a restricted client key or a backend proxy according to provider policy.

## Quality checks

Run:

    flutter pub get
    flutter analyze
    flutter test

The analyzer checks Dart source. The test suite covers pure mapping behavior. Neither command proves that location permissions, provider connectivity, Android packaging or iOS signing work on a real device.

## Change discipline

- Keep changes small and explain the reason.
- Preserve the current screen/service separation unless a refactor is justified.
- Add tests for deterministic logic and parsing.
- Avoid logging keys, coordinates or personal data.
- Test both city search and device-location paths.
- Record SDK and device details when reporting platform-specific failures.
