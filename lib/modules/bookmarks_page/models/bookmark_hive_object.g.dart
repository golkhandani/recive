// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkHiveObjectAdapter extends TypeAdapter<BookmarkHiveObject> {
  @override
  final int typeId = 104;

  @override
  BookmarkHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkHiveObject(
      id: fields[0] as String,
      dateTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkHiveObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
