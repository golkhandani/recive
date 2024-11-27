enum DataTables {
  art('arts'),
  event('events'),
  location('locations'),
  artist('artists'),
  userInteraction('user_interactions'),
  ;

  final String tableName;
  const DataTables(this.tableName);
}

enum DataFunctions {
  acNearbySearch('ac_nearby_search'),
  acTextSearch('ac_text_search'),
  ;

  final String fnName;
  const DataFunctions(this.fnName);
}
