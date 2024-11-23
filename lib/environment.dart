class Environment {
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseKey = String.fromEnvironment('SUPABASE_KEY');
  static const String sentryHost = String.fromEnvironment('SENTRY_HOST');
  static const String sentryKey = String.fromEnvironment('SENTRY_KEY');
  static const String appUrl = String.fromEnvironment('APP_URL');
  static const String appName = String.fromEnvironment('APP_NAME');
  static const String persistSessionKey = 'PERSIST_SESSION_KEY';
  static const String isIntroCheckedKey = 'IS_INTRO_CHECKED_KEY';
  static const String selectedGroupKey = 'SELECTED_GROUP_KEY';

  static const String iosGoogleClientId = String.fromEnvironment('IOS_GOOGLE_CLIENTID');
  static const String webGoogleClientId = String.fromEnvironment('WEB_GOOGLE_CLIENTID');
  static const String androidGoogleClientId =
      String.fromEnvironment('ANDROID_GOOGLE_CLIENTID');
}
