// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkStoreAdapter extends TypeAdapter<BookmarkStore> {
  @override
  final int typeId = 103;

  @override
  BookmarkStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkStore(
      ids: (fields[0] as List).cast<String>(),
      count: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkStore obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ids)
      ..writeByte(1)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
