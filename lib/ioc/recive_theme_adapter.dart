import 'package:hive_flutter/hive_flutter.dart';

import 'package:recive/utils/theme_cubit.dart';

class ReciveThemeAdapter implements TypeAdapter<ReciveTheme> {
  @override
  ReciveTheme read(BinaryReader reader) {
    return ReciveTheme.values[(reader.readInt())];
  }

  @override
  int get typeId => 0102;

  @override
  void write(BinaryWriter writer, ReciveTheme obj) {
    writer.writeInt(obj.index);
  }
}
