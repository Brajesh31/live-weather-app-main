# Weather API integration

## Provider and endpoint

The application uses the OpenWeatherMap Current Weather API endpoint:

    https://api.openweathermap.org/data/2.5/weather

The implementation is in lib/services/weather.dart. The application currently uses HTTPS and requests metric units.

## Authentication and configuration

The provider key is read from the OPENWEATHER_API_KEY Dart compile-time define. Example:

    flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY

Do not include the key in source files, documentation examples with a real value, screenshots, issue reports or committed build configuration. A key compiled into a mobile app can be extracted. Restrict the key with provider-side controls where available and monitor usage.

## City request

The city request uses the q parameter. The city name is encoded with Uri.encodeQueryComponent before it is appended to the URL.

Conceptually:

    GET /data/2.5/weather?q=London&appid=API_KEY&units=metric

An empty city string is not rejected by the current screen. The provider will likely return a client error for an invalid or missing city.

## Coordinate request

The location request uses lat and lon:

    GET /data/2.5/weather?lat=51.5072&lon=-0.1276&appid=API_KEY&units=metric

The example coordinates are illustrative only. The app requests the device's actual coordinates through Geolocator.

## Response fields consumed by the app

The UI currently expects these JSON fields:

| JSON path | Use |
|---|---|
| name | City name |
| main.temp | Temperature in metric units |
| weather[0].id | Numeric weather condition identifier |

The UI assumes weather contains at least one item and main.temp is numeric. Unexpected or incomplete payloads can throw during dynamic map access. A typed parser and validation layer are recommended before production use.

## HTTP behavior

NetworkHelper sends a GET request and decodes JSON only when status code is 200. For other status codes it prints the status code and returns null. It does not currently expose a structured error, parse provider error messages, set a request timeout, retry transient failures or distinguish offline state from provider rejection.

## Provider error cases to handle in a future implementation

- 400: invalid or missing request parameters.
- 401: invalid, missing or inactive API key.
- 404: city not found.
- 429: provider rate limit or quota restriction.
- 5xx: provider-side service failure.
- Socket or TLS errors: connectivity or transport failure.
- JSON parsing errors: unexpected response body.

The exact provider response and account limits should be checked against the provider's current documentation. This file describes the parameters and response fields used by this repository, not a guarantee of provider availability.
