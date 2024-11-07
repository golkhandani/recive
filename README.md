

## how to run
flutter run --dart-define-from-file=.flutter.env.local.json

## android build
flutter build apk --dart-define-from-file=.flutter.env.local.json

## app setup
1. application id = mrzg.vancouverartcompass.app
2. get sha1 for google console = 
- apk => keytool -printcert -jarfile ./build/app/outputs/flutter-apk/app-release.apk
- debug => keytool -list -v -keystore ~/.android/debug.keystore
- default pass for keytool => android

## config flutter fire
1. flutterfire configure --project=[ID]

## change package name
- dart run change_app_package_name:main mrzg.vancouverartcompass.app

## dump db
```sh
PGHOST=[HOST] \
PGPORT=[PORT] \
PGUSER=[USER]\
PGPASSWORD="[PASS]" \
pg_dumpall -v --clean --column-inserts --if-exists --on-conflict-do-nothing > all_databases_backup.sql
```
## env sample
.flutter.env.local.json

```json

{
  "SUPABASE_URL": ,
  "SUPABASE_KEY": ,
  "SENTRY_HOST": ,
  "SENTRY_KEY": ,
  "IOS_GOOGLE_CLIENTID": ,
  "WEB_GOOGLE_CLIENTID": ,
  "ANDROID_GOOGLE_CLIENTID": 
}

```

