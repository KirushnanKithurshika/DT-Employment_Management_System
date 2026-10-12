# Mobile — Flutter

Mobile app for **employees**.

## Why this is separate from `web/`

The web portal targets HR, company and admin staff working at a desk in a
browser. Employees need something that works on a phone, so this is a
separate Flutter application talking to the same backend API.

## Stack

- Flutter 3.47.7 (Dart 3.13) — pinned to match CI and the Dockerfile
- `http` for API calls

## Run locally

```bash
flutter pub get
flutter run
```

Requires the Flutter SDK and a target device or emulator.

## Tests

```bash
flutter analyze
flutter test
```

## API base URL

Passed at build/run time via `--dart-define`:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080/api
```

The default is `http://10.0.2.2:8080/api`. `10.0.2.2` is how the Android
emulator reaches the host machine's `localhost` — using `localhost` here will
fail on an emulator. Physical devices need your machine's LAN IP instead.

## Docker

`Dockerfile` provides reproducible targets:

```bash
docker build -t ems-mobile ./mobile --target artifact   # build release APK
docker build -t ems-mobile ./mobile --target verify     # analyze + test
```

The APK is written to `/app-release.apk` in the `artifact` target.

Native platform folders (`android/`, `ios/`) are not committed yet — generate
them once with `flutter create .` during the mobile phase. Until then the
release build above will not succeed, which is expected.