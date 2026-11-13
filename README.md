# Clima Weather

Clima is a Flutter mobile application for viewing current weather conditions. It can request weather for the device's approximate location or for a city entered by the user. The app uses the OpenWeatherMap Current Weather API and presents the temperature in Celsius, a condition emoji, the city name and a temperature-based suggestion.

This repository is a learning project built around a simple Flutter screen/service separation. It is not a production weather platform and does not provide forecasts, accounts, saved locations, offline caching or a backend.

## Capabilities

- Retrieve current weather using the device's location.
- Search for current weather by city name.
- Display temperature in Celsius.
- Convert OpenWeatherMap condition identifiers into emoji.
- Show a short clothing or activity suggestion based on temperature.
- Use distinct loading, location-weather and city-search screens.
- Support Android and iOS project scaffolding.

The app currently requests current conditions only. Hourly forecasts, daily forecasts, weather alerts, historical weather and background updates are not implemented.

## Technology and dependencies

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform application UI and runtime |
| Dart | Application language |
| geolocator 3.0.1 | Device location lookup |
| http 0.12.0+2 | HTTP requests to the weather provider |
| flutter_spinkit 3.1.0 | Loading animation |
| OpenWeatherMap Current Weather API | Weather data source |

The dependency versions are intentionally documented as they exist in the current project manifest. They are old and should be upgraded as a separate compatibility task, not blindly replaced during a documentation change.

## Requirements

- Flutter SDK with Dart 2.x compatible with the SDK constraint in pubspec.yaml.
- Android Studio and Android SDK for Android builds.
- Xcode and CocoaPods for iOS builds on macOS.
- An OpenWeatherMap API key.
- A physical device or emulator for location-permission testing.

## Quick start

Clone the repository and enter its directory:

    git clone https://github.com/Brajesh31/live-weather-app-main.git
    cd live-weather-app-main

Install the Dart and Flutter packages:

    flutter pub get

Provide the OpenWeatherMap key at run time:

    flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

For an Android APK:

    flutter build apk --release --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

For an Android app bundle:

    flutter build appbundle --release --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

For iOS, run the build on macOS with Xcode configured:

    flutter build ios --release --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

Do not paste a real key into Dart source, commit it in a configuration file, or place it in a public issue. A key supplied with a Dart compile-time define is still embedded in the client binary and can be extracted. Restrict the key at the provider, monitor usage and rotate any key that was previously exposed. A backend proxy is the stronger option when provider policy and app distribution require secret protection.

## Configuration

The application reads the key through the OPENWEATHER_API_KEY compile-time environment value. If it is absent, the weather service throws a StateError explaining how to provide it.

The app does not currently have a separate dotenv loader, remote configuration service or server-side credential store. Do not create a committed .env file as a substitute for the documented Dart define.

## Application flow

1. The app starts in the loading screen.
2. The loading screen asks the location service for the current device position.
3. The weather service builds a current-weather request using latitude and longitude.
4. The networking helper sends the HTTP GET request and decodes a successful JSON response.
5. The location screen maps the response into temperature, condition icon, city and message.
6. The user can refresh location weather or open the city search screen.
7. A submitted city name is URL-encoded and sent to the same current-weather endpoint.

See the architecture, API and location-permissions documents in the docs directory for implementation details and limitations.

## Repository layout

    lib/
      main.dart
      screens/
        loading_screen.dart
        location_screen.dart
        city_screen.dart
      services/
        location.dart
        networking.dart
        weather.dart
      utilities/
        constants.dart
    docs/
    images/
    fonts/
    android/
    ios/
    test/

The Android and iOS directories contain native runner projects. The images and fonts directories contain local presentation assets. Generated build output and machine-specific SDK paths do not belong in source control.

## Validation

Install dependencies and run static analysis:

    flutter pub get
    flutter analyze

Run the automated test suite:

    flutter test

The automated tests cover the deterministic weather-condition and temperature-message mappings. They do not test live API calls, device location providers, permission prompts or native platform builds. Those require manual or platform-specific integration testing.

## Known limitations and technical debt

- Only current weather is displayed.
- Location failures are not yet represented by a dedicated recoverable UI state.
- Network failures and non-200 API responses are not handled through a typed result model.
- The current weather service and networking helper do not implement request timeouts or retry policy.
- The app uses legacy Flutter and Dart dependencies.
- The Android project uses the deprecated Android embedding and old Gradle/Android plugin configuration.
- Android target SDK and compile SDK values are old and require a planned platform migration.
- The app has no offline cache, saved cities, forecast view or automated integration tests.
- The compile-time API key is extractable from a distributed mobile binary.

These limitations are recorded rather than hidden. See docs/TROUBLESHOOTING.md and docs/DEPLOYMENT.md before attempting a production release.

## Contributing

Read CONTRIBUTING.md before submitting a change. Keep pull requests focused, describe visible behavior changes and include the validation commands you ran.

## Security

Read SECURITY.md. Never commit API keys, signing credentials, private user data or machine-specific local configuration.

## License

Distributed under the MIT License. See LICENSE.
