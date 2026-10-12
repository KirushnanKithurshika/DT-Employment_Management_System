# Flutter version is pinned to match CI. Using a floating `stable` tag here
# means the toolchain can change underneath an unreviewed image rebuild.

FROM ghcr.io/cirruslabs/flutter:3.47.7 AS build

WORKDIR /app
ENV PUB_CACHE=/app/.pub-cache

# Resolve packages first so source edits reuse the cached layer.
COPY pubspec.yaml pubspec.lock* ./
RUN flutter pub get

COPY lib ./lib
COPY test ./test

# Release APK for Android.
RUN flutter build apk --release

# ---- verify ----
FROM build AS verify
RUN flutter analyze && flutter test

FROM scratch AS artifact
COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk /app-release.apk