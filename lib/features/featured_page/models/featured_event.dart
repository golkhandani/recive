import 'package:freezed_annotation/freezed_annotation.dart';

part 'featured_event.freezed.dart';
part 'featured_event.g.dart';

@freezed
class FeaturedEvent with _$FeaturedEvent {
  const factory FeaturedEvent({
    required String id,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required String location,
    required List<String> organizers,
    required List<String> participants,
    required String imageUrl,
  }) = _FeaturedEvent;

  factory FeaturedEvent.fromJson(Map<String, Object?> json) =>
      _$FeaturedEventFromJson(json);
}