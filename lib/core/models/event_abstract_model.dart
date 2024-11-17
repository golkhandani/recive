import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/environment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'event_abstract_model.freezed.dart';
part 'event_abstract_model.g.dart';

@freezed
class EventAbstractModel with _$EventAbstractModel {
  const factory EventAbstractModel({
    required String id,
    required String title,
    required String eventType,
    required MediaModel thumbnail,
    required List<String> tags,
  }) = _EventAbstractModel;

  factory EventAbstractModel.fromJson(Map<String, Object?> json) =>
      _$EventAbstractModelFromJson(json);

  static EventAbstractModel fromPostgres(PostgrestMap res) {
    final eventMedia = res['event_media'] as ArrayRes;
    MediaModel th;
    if (eventMedia?.isEmpty ?? true) {
      th = MediaModel.artistPlaceholder;
    } else {
      th = MediaModel.fromPostgres(eventMedia!.first['media']);
    }
    return EventAbstractModel(
      id: res['id'],
      title: res['title'],
      eventType: res['type'],
      thumbnail: th,
      tags: [],
    );
  }
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
      media.copyWith(url: media.url);

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
    required DateTime startDate,
    required DateTime endDate,
    required String status, // archive, blocked, removed, ...
    DateTime? ticketStartDate,
    double? minTicketPrice,
    double? maxTicketPrice,
    List<String>? accessibilityFeatures,
    bool? registrationRequired,
    required String organizer,
    List<String>? highlights,
    required String location,
    required LatLng geoLocation,
    required List<MediaModel> media,
    required List<LinkModel> links,
    required List<String> tags,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, Object?> json) => _$EventModelFromJson(json);

  static EventModel fromPostgres(PostgrestMap res) {
    var media = (res['event_media'] as List<dynamic>? ?? []);
    MediaModel? th;
    if (media.isEmpty) {
      th = MediaModel.artistPlaceholder;
    }

    return EventModel(
      id: res['id'],
      description: res['description'] ?? '',
      eventType: res['type'],
      title: res['title'] ?? '',
      location: res['locations']['title'],
      geoLocation: LatLng(
        // just to make sure it is double
        (res['locations']['lat'] ?? 0) + .0,
        (res['locations']['lng'] ?? 0) + .0,
      ),
      organizer: res['organizer'] ?? '',
      status: res['status'] ?? '',
      startDate: DateTime.parse(res['start_date']),
      endDate: DateTime.parse(res['end_date']),
      ticketStartDate: res['ticket_start_date'] != null
          ? DateTime.tryParse(res['ticket_start_date'])
          : null,
      highlights: (res['highlights'] as List).map((e) => e.toString()).toList(),
      accessibilityFeatures:
          (res['accessibility_features'] as List).map((e) => e.toString()).toList(),
      minTicketPrice: double.tryParse(res['min_ticket_price'].toString()),
      maxTicketPrice: double.tryParse(res['max_ticket_price'].toString()),
      registrationRequired: res['registration_required'],
      media: media.isEmpty
          ? [th!]
          : media.map((am) => MediaModel.fromPostgres(am['media'])).toList(),
      tags: (res['event_tags'] as List<dynamic>? ?? []).map((at) {
        return at['tags']['name'] as String;
      }).toList(),
      links: (res['event_links'] as List<dynamic>? ?? []).map((al) {
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
