import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_abstract_model.freezed.dart';
part 'category_abstract_model.g.dart';

@freezed
class CategoryAbstractModel with _$CategoryAbstractModel {
  const CategoryAbstractModel._();
  const factory CategoryAbstractModel({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required List<String> tags,
  }) = _CategoryAbstractModel;

  factory CategoryAbstractModel.fromJson(Map<String, Object?> json) =>
      _$CategoryAbstractModelFromJson(json);

  String get heroTag => '${runtimeType}_$id';
}
