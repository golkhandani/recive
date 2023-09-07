import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';

class FeaturedEventCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;

  FeaturedEventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
  });

  static FeaturedEventCardContainerData fromFeaturedEvent(FeaturedEvent e) {
    return FeaturedEventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      startDate: e.startDate,
      endDate: e.endDate,
      location: e.location,
      organizers: e.organizers,
      participants: e.participants,
      imageUrl: e.imageUrl,
    );
  }

  static FeaturedEventCardContainerData fromEventComplete(EventComplete e) {
    return FeaturedEventCardContainerData(
      id: e.id!,
      title: e.title!,
      description: e.description!,
      startDate: e.startDate!,
      endDate: e.endDate!,
      location: e.venue?.address?.localizedAddressDisplay ?? '',
      organizers: [e.organizer?.title ?? ''],
      participants: [],
      imageUrl: e.imageUrl!,
    );
  }
}
