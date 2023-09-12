import 'package:hive/hive.dart';

part 'favourite_storage.g.dart';

@HiveType(typeId: 0103)
class BookmarkStore extends HiveObject {
  static const keyName = 'BookmarkStoreKeyName';

  @HiveField(0)
  final List<String> ids;
  @HiveField(1)
  final int count;

  BookmarkStore({
    required this.ids,
    required this.count,
  });
}
