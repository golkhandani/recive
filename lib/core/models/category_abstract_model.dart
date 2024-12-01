import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'category_abstract_model.freezed.dart';
part 'category_abstract_model.g.dart';

@freezed
class CategoryAbstractModel with _$CategoryAbstractModel {
  const CategoryAbstractModel._();
  const factory CategoryAbstractModel({
    required String id,
    required String title,
    required EntityType type,
    required String description,
    required String imageUrl,
    required List<String> tags,
  }) = _CategoryAbstractModel;

  factory CategoryAbstractModel.fromJson(Map<String, Object?> json) =>
      _$CategoryAbstractModelFromJson(json);

  static CategoryAbstractModel fromPostgres(PostgrestMap c) {
    final description = c['description'] ?? '';
    final image = (c['image_url'] as String);
    final tags = (c['category_tags'] as List<dynamic>)
        .map((t) => t['tag_id']['name'].toString())
        .toList();

    return CategoryAbstractModel(
      id: c['id'],
      title: c['title'],
      type: switch (c['type']) {
        'art' => EntityType.art,
        'artist' => EntityType.artist,
        'event' => EntityType.event,
        _ => EntityType.unknown
      },
      description: description,
      imageUrl: image,
      tags: tags,
    );
  }

  String get heroTag => '${runtimeType}_$id';
}
