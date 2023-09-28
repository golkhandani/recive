import 'package:hive/hive.dart';

part 'bookmark_hive_object.g.dart';

@HiveType(typeId: 0104)
class BookmarkHiveObject extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime dateTime;

  BookmarkHiveObject({
    required this.id,
    required this.dateTime,
  });
}
