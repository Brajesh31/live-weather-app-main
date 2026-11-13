# Security Policy

## Project scope

This is a client-side learning application that requests current weather from OpenWeatherMap. It does not operate a backend account system or store user profiles. Location coordinates may be sent to the weather provider when the location-weather feature is used.

## Reporting a vulnerability

Do not publish API keys, credentials, personal data or exploit details in a public issue. Use GitHub private vulnerability reporting for this repository if enabled. Otherwise, contact the repository owner privately through the GitHub profile and provide concise reproduction steps and impact.

## Credential handling

- Supply the provider key through OPENWEATHER_API_KEY at run or build time.
- Rotate any key that has been committed, posted publicly or embedded in a public artifact.
- A Dart compile-time define does not protect a key inside a distributed mobile binary.
- Restrict and monitor the key at the provider where possible.
- Consider a backend proxy if the provider key must remain confidential.
- Never commit Android signing keys, passwords, provisioning profiles or private environment files.

## Location and privacy

Request location only for the location-weather feature. Do not add background location collection without a clear product requirement and appropriate disclosure. Avoid logging precise coordinates or complete API URLs. Use manual city search as an alternative when location permission is declined.

## Dependency and platform maintenance

The project uses legacy Flutter dependencies and Android embedding configuration. Review package advisories and platform compatibility before release. Keep the Flutter SDK, dependencies, Gradle configuration and native platform projects on a supported combination.

## Supported branch

Security fixes are accepted against the default branch. This learning project does not publish a formal long-term support matrix.
