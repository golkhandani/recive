#!/bin/bash

# Remove all folders starting with "releases-" in the root directory
rm -rf ./releases-*

# Create a new "releases" folder with a timestamp
timestamp=$(date +"%Y%m%d%H%M%S")
releases_folder="releases-$timestamp"
mkdir "$releases_folder"

# Build and copy the Flutter web release, then zip and remove the folder
rm -rf ./build/web
flutter build web --dart-define-from-file=.flutter.env.local.json --release
cp -r ./build/web/ "$releases_folder/web"
cd "$releases_folder/web"
zip -r "../web.zip" ./*
cd - > /dev/null
rm -rf "$releases_folder/web"

# Build and copy the Flutter iOS IPA release
flutter build ipa --dart-define-from-file=.flutter.env.local.json --release
cp ./build/ios/ipa/VancouverArtCompass.ipa "$releases_folder/VancouverArtCompass.ipa"

# Build and copy the Flutter Android APK release
flutter build apk --dart-define-from-file=.flutter.env.local.json --release
cp ./build/app/outputs/flutter-apk/app-release.apk "$releases_folder/VancouverArtCompass.apk"

echo "Builds and artifacts copied to $releases_folder"
