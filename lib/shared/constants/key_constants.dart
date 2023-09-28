import 'package:latlong2/latlong.dart';

class StoreBoxConstant {
  static const themeStoreKey = 'themeStoreKey';
  static const hiveStoreFolderName = 'hive_data';
  static const hiveStoreGqlBoxName = 'graphql';
  static const hiveStoreThemeBoxName = 'theme_box';
  static const hiveStoreIntroductionBoxName = 'intro_box';
  static const hiveStoreBookmarksBoxName = 'bookmarks_box';
}

class GoogleConstant {
  static const gSignInScopes = ['profile', 'email'];
  static const gSignInServerCid =
      '337988051792-khuhmiv6pjgv50dd2ap94puaj2fp7lls.apps.googleusercontent.com';
}

class ApiConstant {
  static const realmAppId = 'recive-kpkwr';
  static const realmKey =
      'BeFfO1hsTWg596PDZyOZrD4nIS2ChhN1H4phWhqEf0kZxP4TviBs9SWdo8DOQgEP';
  static const realmBaseUrl = 'https://us-east-1.aws.realm.mongodb.com';
  static const realmGqlBaseUrl =
      'https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/recive-kpkwr/graphql';
  static const realmVersion = '2.0';
  static const realmTimeout = 120;
  static const openWeatherKey = '8af110219c55ac7762ec012dfc20f17a';

  static const openAiSk = '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';
}

class DefaultConstant {
  static const defaultPosition = LatLng(51.509364, -0.128928);
}
