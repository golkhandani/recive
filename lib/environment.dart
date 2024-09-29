class Environment {
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseKey = String.fromEnvironment('SUPABASE_KEY');
  static const String persistSessionKey = 'PERSIST_SESSION_KEY';
  static const String isIntroCheckedKey = 'IS_INTRO_CHECKED_KEY';
  static const String selectedGroupKey = 'SELECTED_GROUP_KEY';
}
