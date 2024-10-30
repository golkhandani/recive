import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'art_abstract_model.freezed.dart';
part 'art_abstract_model.g.dart';

@freezed
class ArtAbstractModel with _$ArtAbstractModel {
  const factory ArtAbstractModel({
    required String id,
    required String title,
    required String description,
    required String artType,
    required String location,
    required LatLng geoLocation,
    required MediaModel thumbnail,
    required List<String> tags,
  }) = _ArtAbstractModel;

  factory ArtAbstractModel.fromJson(Map<String, Object?> json) =>
      _$ArtAbstractModelFromJson(json);

  static ArtAbstractModel fromPostgres(PostgrestMap res) {
    final artMedia = res['art_media'] as ArrayRes;
    MediaModel th;
    if (artMedia?.isEmpty ?? true) {
      th = MediaModel.artistPlaceholder;
    } else {
      th = MediaModel.fromPostgres(artMedia!.first['media']);
    }
    return ArtAbstractModel(
      id: res['id'],
      title: res['title'],
      description: res['description'],
      artType: res['type'],
      location: res['location']['title'],
      geoLocation: LatLng(res['location']['lat'] ?? 0, res['location']['lng'] ?? 0),
      thumbnail: th,
      tags: [],
    );
  }
}
