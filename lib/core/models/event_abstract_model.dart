import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/environment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'event_abstract_model.freezed.dart';
part 'event_abstract_model.g.dart';

@freezed
class EventAbstractModel with _$EventAbstractModel {
  const factory EventAbstractModel({
    required String id,
    required String title,
    required String description,
    required String eventType,
    required String imageUrl,
    required List<String> tags,
  }) = _EventAbstractModel;

  factory EventAbstractModel.fromJson(Map<String, Object?> json) =>
      _$EventAbstractModelFromJson(json);
}

enum MediaType { image }

@freezed
class MediaModel with _$MediaModel {
  const factory MediaModel({
    required String id,
    required String title,
    required MediaType type,
    required String url,
    required String copyright,
    required List<String> tags,
  }) = _MediaModel;

  factory MediaModel.fromJson(Map<String, Object?> json) => _$MediaModelFromJson(json);

  static MediaModel fromPostgres(PostgrestMap m) => MediaModel(
        id: m['id'],
        title: m['title'],
        type: MediaType.image,
        url: m['url'],
        copyright: m['copyright'],
        tags: [],
      );

  static Future<MediaModel> fromSignedUrl(MediaModel media, StorageFileApi storage) async =>
      media.copyWith(
        url: await storage.createSignedUrl(media.url.split(storage.bucketId ?? '')[1], 3600),
      );

  static MediaModel get artistPlaceholder {
    const ph =
        '${Environment.supabaseUrl}/storage/v1/object/public/placeholders/artist_placeholder.jpeg?=';
    return const MediaModel(
      id: 'No Id',
      title: 'No title',
      type: MediaType.image,
      url: ph,
      copyright: 'No copyright',
      tags: [],
    );
  }
}

@freezed
class LinkModel with _$LinkModel {
  const factory LinkModel({
    required String id,
    required String title,
    required String url,
  }) = _LinkModel;

  factory LinkModel.fromJson(Map<String, Object?> json) => _$LinkModelFromJson(json);
}

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String id,
    required String title,
    required String description,
    required String eventType,
    required DateTime dateTime,
    required List<LinkModel> links,
    required List<String> highlights,
    required List<MediaModel> media,
    required List<String> tags,
    required ArtAbstractModel art,
    required CommunityAbstractModel community,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, Object?> json) => _$EventModelFromJson(json);
}
