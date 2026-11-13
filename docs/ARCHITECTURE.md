# Architecture and implementation map

## 1. System boundary

Clima is a client-only Flutter application. It has no application server, authentication layer, database or persistent weather cache. The mobile client calls OpenWeatherMap directly over HTTPS. Device location is obtained through the Geolocator plugin.

The principal runtime boundary is therefore:

- Flutter presentation and navigation.
- Local device location services mediated by Geolocator.
- HTTP transport and JSON decoding.
- OpenWeatherMap's current-weather service.

The provider API key is supplied as a Dart compile-time define. This avoids a literal secret in the source tree, but it does not make the key secret after the app is compiled. Mobile application packages can be inspected.

## 2. Directory responsibilities

| Path | Responsibility |
|---|---|
| lib/main.dart | Flutter entry point and root MaterialApp |
| lib/screens/loading_screen.dart | Initial location-weather loading |
| lib/screens/location_screen.dart | Current weather display and navigation actions |
| lib/screens/city_screen.dart | City-name input and return navigation |
| lib/services/location.dart | Device latitude and longitude lookup |
| lib/services/networking.dart | HTTP GET and JSON decoding |
| lib/services/weather.dart | Provider URL construction and weather presentation mappings |
| lib/utilities/constants.dart | Shared text styles and input decoration |
| images/ | Screen background images |
| fonts/ | Bundled Spartan MB font |
| android/ | Android application wrapper and manifest |
| ios/ | iOS application wrapper, permissions and Xcode project |
| docs/ | Project and operational documentation |

## 3. Startup and location request

The main function starts MyApp. MyApp creates a MaterialApp whose home route is LoadingScreen. LoadingScreen calls getLocationData from initState. That method awaits WeatherModel.getLocationWeather and then pushes LocationScreen with the returned JSON object.

This is a simple prototype flow, but it has an important lifecycle limitation: the asynchronous operation can finish after the loading screen has been disposed. The current implementation does not check whether the widget remains mounted before using its BuildContext. A future behavior change should add lifecycle-safe navigation and a visible error/retry state.

## 4. Weather request path

WeatherModel owns the provider-specific behavior. It reads OPENWEATHER_API_KEY through String.fromEnvironment and uses the OpenWeatherMap current-weather endpoint.

For city search, the city name is URL-encoded and sent as the q query parameter. For device location, latitude and longitude are sent as lat and lon. Both requests ask the provider for metric units.

NetworkHelper performs the GET request. When the HTTP status is 200, it decodes the response body as JSON. For other status codes it prints the status and returns no structured error. Transport exceptions and malformed JSON can propagate to the caller.

## 5. Presentation mapping

LocationScreen reads the main temperature, first weather condition identifier and city name from the provider response. It truncates the temperature to an integer, maps the condition identifier to an emoji, and maps temperature to a short suggestion.

The mapping functions are deterministic and isolated in WeatherModel. They are suitable for unit tests without requiring a device, location permission or network connection.

## 6. Navigation

The city screen is opened through Navigator.push. When the user submits the form, the city name is returned with Navigator.pop. The location screen then requests city weather and updates its displayed values.

The current form does not validate empty or whitespace-only city names. It also does not expose a loading state while the city request is running. These are known UX limitations, not hidden assumptions.

## 7. Data and privacy

The application does not persist weather results or user profiles. Location coordinates are used to construct a weather request. The provider receives those coordinates as part of the request. Users should be told why location is requested and should be able to use manual city search if they decline location access.

Do not log precise coordinates, API keys or complete request URLs in production diagnostics.

## 8. Architectural constraints and future direction

For a production-oriented version, consider introducing:

- A typed weather response model instead of dynamic JSON indexing.
- A repository or data-source abstraction around the provider.
- Explicit success, loading, permission-denied and failure states.
- Request timeouts and controlled retry behavior.
- A backend proxy if the provider key must not be distributed in a client binary.
- Unit tests for response parsing and service behavior.
- Widget tests for loading, city search and error states.

These are recommendations. They are not represented as existing functionality.
