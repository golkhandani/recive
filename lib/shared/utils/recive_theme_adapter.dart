import 'package:hive_flutter/hive_flutter.dart';

import 'package:recive/shared/extensions/color_themes_extentions.dart';

class AppPaletteTypeAdapter implements TypeAdapter<AppPaletteType> {
  @override
  AppPaletteType read(BinaryReader reader) {
    return AppPaletteType.values[(reader.readInt())];
  }

  @override
  int get typeId => 0102;

  @override
  void write(BinaryWriter writer, AppPaletteType obj) {
    writer.writeInt(obj.index);
  }
}
