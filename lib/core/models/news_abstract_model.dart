import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_abstract_model.freezed.dart';
part 'news_abstract_model.g.dart';

@freezed
class NewsAbstractModel with _$NewsAbstractModel {
  const factory NewsAbstractModel({
    required String id,
    required String title,
    required String description,
    required String location,
    required String imageUrl,
  }) = _NewsAbstractModel;

  factory NewsAbstractModel.fromJson(Map<String, Object?> json) =>
      _$NewsAbstractModelFromJson(json);
}

@freezed
class NewsModel with _$NewsModel {
  const factory NewsModel({
    required String id,
    required String title,
    required String description,
    required String location,
    required String newsType,
    required DateTime dateTime,
    required List<LinkModel> links,
    required List<String> highlights,
    required List<MediaModel> media,
    required List<String> tags,
    ArtAbstractModel? art,
    EventAbstractModel? event,
    ArtistAbstractModel? artist,
    CommunityAbstractModel? community,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, Object?> json) => _$NewsModelFromJson(json);
}
