# Security Policy

## Supported versions

Security fixes are accepted for the current default branch. This is a learning project and does not currently publish a formal support matrix.

## Reporting a vulnerability

Please do not publish API keys, credentials, personal data, or exploit details in a public issue. Use GitHub's private vulnerability reporting feature for this repository if it is enabled. Otherwise, contact the repository owner privately through the GitHub profile and include concise reproduction steps.

## Key handling

- Supply the OpenWeatherMap key through `--dart-define=OPENWEATHER_API_KEY=...`.
- Rotate any key that has been committed or otherwise exposed.
- Treat mobile-app API keys as extractable from the distributed binary. Restrict and monitor keys at the provider.
- Never commit signing credentials or private environment files.
