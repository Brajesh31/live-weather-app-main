# Testing strategy

## Current automated coverage

The repository includes a small unit-test suite for deterministic WeatherModel presentation mappings. These tests do not require a device, network connection, location permission or API key.

Run all tests with:

    flutter test

Run static analysis with:

    flutter analyze

## Unit-test scope

Weather condition identifiers are mapped to emoji categories. Temperature values are mapped to short suggestion messages. These methods are pure functions and should remain straightforward to test.

The tests intentionally do not assert live OpenWeatherMap responses. Network tests should use a mocked HTTP client or an injected transport rather than depend on the public provider or a real API key.

## Manual test matrix

| Scenario | Expected observation |
|---|---|
| Valid city name | Current weather for that city is displayed |
| City name with spaces | Query is URL encoded and request is made |
| Empty city input | Current implementation has no client-side validation; provider error is possible |
| Valid device location | Coordinates are obtained and current weather is displayed |
| Permission denied | Current implementation has limited recovery behavior |
| Location services disabled | Current implementation may fail before weather data is shown |
| Invalid API key | Provider rejects the request |
| No internet | Transport failure is not currently represented with a dedicated UI state |
| Unknown condition code | Fallback emoji is returned |
| Temperature boundary values | Correct message branch is selected |

## Recommended next tests

- Weather response parsing with complete and incomplete JSON.
- URL construction for city and coordinate requests.
- HTTP 200, 4xx, 429 and 5xx handling using a fake client.
- Transport timeout and malformed JSON behavior.
- Location permission denied and permanently denied states.
- Widget tests for loading, weather display, city input and error states.
- Navigation lifecycle behavior when an asynchronous request completes after a screen is disposed.

## Test quality rules

Tests should be deterministic, isolated and free of real credentials. Do not call the live weather provider from unit tests. Keep test fixtures synthetic and do not commit real coordinates associated with a person.
