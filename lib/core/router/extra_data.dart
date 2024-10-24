import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/models/news_abstract_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_data.freezed.dart';
part 'extra_data.g.dart';

typedef JsonData = Map<String, dynamic>;

@Freezed(genericArgumentFactories: true)
class ExtraData<T> with _$ExtraData<T> {
  static const summaryKey = 'summary';
  static const heroTagKey = 'heroTag';

  const factory ExtraData({
    required T? summary,
    required String heroTag,
  }) = _ExtraData;

  factory ExtraData.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ExtraDataFromJson(json, fromJsonT);
}

@freezed
class SearchScreenFiltersData with _$SearchScreenFiltersData {
  const SearchScreenFiltersData._();

  const factory SearchScreenFiltersData({
    @Default(true) bool art,
    @Default(true) bool artists,
    @Default(true) bool communities,
    @Default(true) bool events,
    @Default(true) bool news,
    @Default(false) bool autoSearch,
  }) = _SearchScreenFiltersData;

  factory SearchScreenFiltersData.fromJson(Map<String, dynamic> json) =>
      _$SearchScreenFiltersDataFromJson(json);

  factory SearchScreenFiltersData.none() => const SearchScreenFiltersData(
        art: false,
        artists: false,
        communities: false,
        events: false,
        news: false,
        autoSearch: false,
      );
}

@freezed
class CommunityCardContainerData with _$CommunityCardContainerData {
  const CommunityCardContainerData._();

  const factory CommunityCardContainerData({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
  }) = _CommunityCardContainerData;

  factory CommunityCardContainerData.fromJson(Map<String, dynamic> json) =>
      _$CommunityCardContainerDataFromJson(json);

  static CommunityCardContainerData fromAbstractCommunity(CommunityAbstractModel e) {
    return CommunityCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      imageUrl: e.imageUrl,
    );
  }

  JsonData toExtraDataJson() {
    final extraData = ExtraData<CommunityCardContainerData>(
      summary: this,
      heroTag: '${runtimeType}_$id',
    ).toJson((inner) => inner.toJson());

    return extraData;
  }
}

@freezed
class EventCardContainerData with _$EventCardContainerData {
  const EventCardContainerData._();

  const factory EventCardContainerData({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
  }) = _EventCardContainerData;

  factory EventCardContainerData.fromJson(Map<String, dynamic> json) =>
      _$EventCardContainerDataFromJson(json);

  static EventCardContainerData fromAbstractEvent(EventAbstractModel e) {
    return EventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      imageUrl: e.imageUrl,
    );
  }

  JsonData toExtraDataJson() {
    final extraData = ExtraData<EventCardContainerData>(
      summary: this,
      heroTag: '${runtimeType}_$id',
    ).toJson((inner) => inner.toJson());

    return extraData;
  }
}

@freezed
class NewsCardContainerData with _$NewsCardContainerData {
  const NewsCardContainerData._();

  const factory NewsCardContainerData({
    required String id,
    required String title,
    required String description,
    required String location,
    required String imageUrl,
  }) = _NewsCardContainerData;

  factory NewsCardContainerData.fromJson(Map<String, dynamic> json) =>
      _$NewsCardContainerDataFromJson(json);

  static NewsCardContainerData fromAbstractNews(NewsAbstractModel e) {
    return NewsCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location,
      imageUrl: e.imageUrl,
    );
  }

  JsonData toExtraDataJson() {
    final extraData = ExtraData<NewsCardContainerData>(
      summary: this,
      heroTag: '${runtimeType}_$id',
    ).toJson((inner) => inner.toJson());

    return extraData;
  }
}

@freezed
class ArtCardContainerData with _$ArtCardContainerData {
  const ArtCardContainerData._();

  const factory ArtCardContainerData({
    required String id,
    required String title,
    required String description,
    required String location,
    required String imageUrl,
  }) = _ArtCardContainerData;

  factory ArtCardContainerData.fromJson(Map<String, dynamic> json) =>
      _$ArtCardContainerDataFromJson(json);

  static ArtCardContainerData fromAbstractArt(ArtAbstractModel e) {
    return ArtCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      imageUrl: e.imageUrl,
      location: e.location,
    );
  }

  JsonData toExtraDataJson() {
    final extraData = ExtraData<ArtCardContainerData>(
      summary: this,
      heroTag: '${runtimeType}_$id',
    ).toJson((inner) => inner.toJson());

    return extraData;
  }
}

@freezed
class ArtistCardContainerData with _$ArtistCardContainerData {
  const ArtistCardContainerData._();

  const factory ArtistCardContainerData({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
  }) = _ArtistCardContainerData;

  factory ArtistCardContainerData.fromJson(Map<String, dynamic> json) =>
      _$ArtistCardContainerDataFromJson(json);

  static ArtistCardContainerData fromAbstractArtist(ArtistAbstractModel e) {
    return ArtistCardContainerData(
      id: e.id,
      name: e.name,
      description: e.description,
      imageUrl: e.imageUrl,
    );
  }

  JsonData toExtraDataJson() {
    final extraData = ExtraData<ArtistCardContainerData>(
      summary: this,
      heroTag: '${runtimeType}_$id',
    ).toJson((inner) => inner.toJson());

    return extraData;
  }
}

// ----------------------- need refactor -----------------------

@freezed
class ArtDetailSummaryData with _$ArtDetailSummaryData {
  const factory ArtDetailSummaryData({
    required String id,
    required String title,
    required String imageUrl,
  }) = _ArtDetailSummaryData;

  factory ArtDetailSummaryData.fromJson(Map<String, dynamic> json) =>
      _$ArtDetailSummaryDataFromJson(json);
}

@freezed
class PackageSummaryData with _$PackageSummaryData {
  const factory PackageSummaryData({
    required String id,
    required String title,
    required String imageUrl,
  }) = _PackageSummaryData;

  factory PackageSummaryData.fromJson(Map<String, dynamic> json) =>
      _$PackageSummaryDataFromJson(json);
}

@freezed
class NewsSummaryData with _$NewsSummaryData {
  const factory NewsSummaryData({
    required String id,
    required String title,
  }) = _NewsSummaryData;

  factory NewsSummaryData.fromJson(Map<String, dynamic> json) =>
      _$NewsSummaryDataFromJson(json);
}
