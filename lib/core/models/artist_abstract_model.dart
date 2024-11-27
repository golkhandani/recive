import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/environment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'artist_abstract_model.freezed.dart';
part 'artist_abstract_model.g.dart';

@freezed
class UserInteractionModel with _$UserInteractionModel {
  const factory UserInteractionModel({
    required bool isLiked,
    required bool isSaved,
    String? reportMessage,
    int? shareCount,
  }) = _UserInteractionModel;

  factory UserInteractionModel.fromJson(Map<String, Object?> json) =>
      _$UserInteractionModelFromJson(json);

  static UserInteractionModel fromPostgres(List<dynamic>? res) {
    final data = res == null || res.isEmpty ? null : res.firstOrNull;
    return UserInteractionModel(
      reportMessage: data?['report_message'],
      shareCount: data?['share_count'] ?? 0,
      isLiked: data?['is_liked'] ?? false,
      isSaved: data?['is_saved'] ?? false,
    );
  }
}

@freezed
class ArtistAbstractModel with _$ArtistAbstractModel {
  const factory ArtistAbstractModel({
    required String id,
    required String name,
    required String description,
    required MediaModel thumbnail,
    required List<String> tags,
    required UserInteractionModel userInteraction,
  }) = _ArtistAbstractModel;

  factory ArtistAbstractModel.fromJson(Map<String, Object?> json) =>
      _$ArtistAbstractModelFromJson(json);

  static ArtistAbstractModel fromPostgres(PostgrestMap res) {
    var media = (res['artist_media'] as List<dynamic>? ?? []);
    MediaModel? th;
    if (media.isEmpty) {
      th = MediaModel.artistPlaceholder;
    } else {
      final m = media.first['media'];
      th = MediaModel(
        id: m['id'],
        title: m['title'],
        type: MediaType.image,
        url: m['url'],
        copyright: m['copyright'],
        tags: [],
      );
    }

    return ArtistAbstractModel(
      id: res['id'],
      description: res['description'] ?? '',
      name: res['name'] ?? '',
      userInteraction: UserInteractionModel(isLiked: false, isSaved: false),
      thumbnail: th,
      tags: (res['artist_tags'] as List<dynamic>? ?? []).map((at) {
        return at['tags']['name'] as String;
      }).toList(),
    );
  }
}

@freezed
class ArtistModel with _$ArtistModel {
  const ArtistModel._();
  const factory ArtistModel({
    required String id,
    required String name,
    required String description,
    required List<MediaModel> media,
    required List<LinkModel> links,
    required List<String> tags,
    required UserInteractionModel userInteraction,
  }) = _ArtistModel;

  String get shareUrl => '${Environment.appUrl}/dashboard/home/artist-detail-screen/$id';
  factory ArtistModel.fromJson(Map<String, dynamic> json) => _$ArtistModelFromJson(json);

  static ArtistModel fromPostgres(PostgrestMap res) {
    var media = (res['artist_media'] as List<dynamic>? ?? []);
    MediaModel? th;
    if (media.isEmpty) {
      th = MediaModel.artistPlaceholder;
    }

    return ArtistModel(
      id: res['id'],
      description: res['description'] ?? '',
      name: res['name'] ?? '',
      userInteraction: UserInteractionModel(isLiked: false, isSaved: false),
      media: media.isEmpty
          ? [th!]
          : media.map((am) => MediaModel.fromPostgres(am['media'])).toList(),
      tags: (res['artist_tags'] as List<dynamic>? ?? []).map((at) {
        return at['tags']['name'] as String;
      }).toList(),
      links: (res['artist_links'] as List<dynamic>? ?? []).map((al) {
        final l = al['links'];
        return LinkModel(
          id: l['id'],
          title: l['title'],
          url: l['url'],
        );
      }).toList(),
    );
  }
}
