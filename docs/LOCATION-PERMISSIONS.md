# Location and platform permissions

## Why location is requested

The app can request current weather for the device's approximate location. It uses Geolocator to obtain latitude and longitude, then sends those coordinates to the weather provider. Manual city search is a separate path and does not require device coordinates.

## Android configuration

The main Android manifest currently declares ACCESS_COARSE_LOCATION. Review the permission requirements of the exact Geolocator version before changing this declaration. The plugin version is old, and current Geolocator setup instructions may not apply to this historical dependency.

The manifest also references the legacy FlutterApplication class. This triggers the deprecated Android embedding warning in the current CI run. Migrating to Android embedding v2 is a platform change that should be planned and tested separately.

## iOS configuration

The iOS Info.plist includes NSLocationWhenInUseUsageDescription with a user-facing explanation. Keep the explanation accurate and specific. Do not request background location because the app currently performs a foreground lookup only.

## Runtime behavior and gaps

Location.getCurrentLocation catches exceptions and prints them. It does not return a typed permission or service error to the caller. If location cannot be read, latitude and longitude can remain unset, and the weather service may still attempt to build a coordinate request.

The current interface does not clearly distinguish:

- Location permission not yet requested.
- Permission denied.
- Permission denied permanently.
- Device location services disabled.
- Position lookup timed out.
- Provider request failed after coordinates were obtained.

A production-ready flow should represent these outcomes separately, explain why permission is needed, offer a manual city-search fallback and avoid sending a request with missing coordinates.

## Manual verification checklist

1. Install the app on a fresh emulator or device.
2. Launch without having previously granted location permission.
3. Confirm the operating system permission prompt is understandable.
4. Deny permission and inspect the app behavior.
5. Grant permission and verify a location request succeeds.
6. Disable device location services and retry.
7. Test a device with no network connection.
8. Use manual city search after denying location.
9. Confirm the app does not request background location.
10. Confirm logs and screenshots do not expose API keys or unnecessary precise location data.

## Privacy considerations

Location coordinates are sensitive contextual data. Request them only when the user invokes the location-weather feature, avoid persistent storage unless a clear feature requires it, and do not include raw coordinates in analytics or public issue reports.
