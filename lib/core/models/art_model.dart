import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'art_model.freezed.dart';
part 'art_model.g.dart';

@freezed
class ArtModel with _$ArtModel {
  const factory ArtModel({
    required String id,
    required String title,
    required String description,
    required String artType,
    required List<LinkModel> links,
    required List<MediaModel> media,
    required List<String> tags,
    required String location,
    required LatLng geoLocation,
    required List<ArtistAbstractModel> artists,
    required List<CommunityAbstractModel> communities,
  }) = _ArtModel;

  factory ArtModel.fromJson(Map<String, dynamic> json) => _$ArtModelFromJson(json);
}
