import 'package:hive/hive.dart';

part 'favourite_storage.g.dart';

@HiveType(typeId: 0103)
class FavouriteStroage extends HiveObject {
  static const favouriteItemsKey = 'favouriteItemsKey';

  @HiveField(0)
  final List<String> ids;
  @HiveField(1)
  final int count;

  FavouriteStroage({
    required this.ids,
    required this.count,
  });
}
