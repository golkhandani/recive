#!/bin/bash

# Remove all folders starting with "releases-" in the root directory
rm -rf ./releases-*

# Create a new "releases" folder with a timestamp
timestamp=$(date +"%Y%m%d%H%M%S")
releases_folder="releases-$timestamp"
mkdir "$releases_folder"
touch "$releases_folder/report.txt"
# Build and copy the Flutter web release, then zip and remove the folder
rm -rf ./build/web
flutter build web --dart-define-from-file=.flutter.env.local.json --release
cp -r ./build/web/ "$releases_folder/web"
cd "$releases_folder/web"
zip -r "../web.zip" ./* > /dev/null
cd - > /dev/null
rm -rf "$releases_folder/web"
# firebase deploy --project vancouverartcompass-c73df --only hosting:vancouver-art-compass
echo "Done Web"

# Build and copy the Flutter iOS IPA release
rm -rf ./build/ios
flutter build ipa --dart-define-from-file=.flutter.env.local.json --release >> "$releases_folder/report.txt"
cp ./build/ios/ipa/VancouverArtCompass.ipa "$releases_folder/VancouverArtCompass.ipa"
echo "Done iOS"
# Build and copy the Flutter Android APK release
rm -rf ./build/ios
flutter build apk --dart-define-from-file=.flutter.env.local.json --release >> "$releases_folder/report.txt"
cp ./build/app/outputs/flutter-apk/app-release.apk "$releases_folder/VancouverArtCompass.apk" 
cd ./android
./gradlew signingreport | awk '/> Task :app:signingReport/,/> Task/ {if ($0 !~ /> Task :app:signingReport/ && $0 !~ /> Task/) print}'
cd - > /dev/null

echo "Done APK"
echo "Builds and artifacts copied to $releases_folder"
