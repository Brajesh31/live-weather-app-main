# Contributing

Thanks for considering a contribution.

## Before opening a change

1. Check existing issues to avoid duplicating work.
2. Keep changes focused and explain the user-facing impact.
3. Do not commit API keys, credentials, signing files, or generated build output.

## Local setup

```bash
flutter pub get
flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY
```

## Validation

Run the app on an emulator or device and verify the affected screen and location/city flow. The repository currently has no automated widget or unit test suite. Add tests for new behavior where practical.

## Pull requests

- Use a descriptive title.
- Explain the problem and the implementation.
- Include screenshots for visible UI changes.
- List the checks you ran and any known limitations.
