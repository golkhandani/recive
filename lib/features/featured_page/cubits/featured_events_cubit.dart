import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/layout/context_ui_extension.dart';

part 'featured_events_cubit.freezed.dart';
part 'featured_events_cubit.g.dart';

final List<String> images = [
  'https://source.unsplash.com/random/?nature,mountain',
  'https://source.unsplash.com/random/?architecture,skyscraper',
  'https://source.unsplash.com/random/?travel,beach',
  'https://source.unsplash.com/random/?food,pizza',
  'https://source.unsplash.com/random/?fashion,style',
  'https://source.unsplash.com/random/?art,sculpture',
  'https://source.unsplash.com/random/?sports,athlete',
  'https://source.unsplash.com/random/?music,concert',
  'https://source.unsplash.com/random/?animal,wildlife',
  'https://source.unsplash.com/random/?vehicle,car',
  // Add more image URLs here...
];
List<FeaturedEvent> mockFeaturedEventsData = [
  FeaturedEvent(
    id: 'c7e4db9e-9377-4e52-9b26-3b03d2fb4d81',
    title: 'Tech Conference',
    description: 'An event showcasing the latest technology trends.',
    startDate: DateTime(2023, 9, 15, 9, 0),
    endDate: DateTime(2023, 9, 17, 18, 0),
    location: 'City Convention Center',
    organizers: ['John Doe', 'Jane Smith'],
    participants: ['Alice Johnson', 'Bob Williams', 'Charlie Brown'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  FeaturedEvent(
    id: '0d6d8c3e-6f61-4c9a-9a79-1d7eb77aa2ec',
    title: 'Art Exhibition',
    description: 'A gallery showcasing various forms of art.',
    startDate: DateTime(2023, 10, 5, 10, 0),
    endDate: DateTime(2023, 10, 8, 20, 0),
    location: 'Modern Art Gallery',
    organizers: ['Emily Davis', 'Michael Lee'],
    participants: ['Grace Turner', 'David Miller', 'Ella White'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  FeaturedEvent(
    id: 'b72e0c4b-82d2-4e90-9e68-2656cc7b1c1c',
    title: 'Food Festival',
    description: 'A celebration of diverse culinary delights.',
    startDate: DateTime(2023, 11, 20, 12, 0),
    endDate: DateTime(2023, 11, 22, 22, 0),
    location: 'Central Park',
    organizers: ['Sarah Johnson', 'Robert Wilson'],
    participants: ['Olivia Harris', 'James Anderson', 'Sophia Martinez'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  FeaturedEvent(
    id: 'f7a15f98-8904-42fc-82b2-76a6b53ec9f1',
    title: 'Workshop: Photography Basics',
    description: 'Learn the fundamentals of photography.',
    startDate: DateTime(2023, 9, 8, 14, 0),
    endDate: DateTime(2023, 9, 8, 18, 0),
    location: 'Community Center',
    organizers: ['Alice Brown'],
    participants: ['William Turner', 'Lily Adams'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  FeaturedEvent(
    id: 'de7549b6-6c91-4b0b-b81c-60b7e43a31d8',
    title: 'Charity Run',
    description: 'Run for a cause to support local charities.',
    startDate: DateTime(2023, 10, 12, 8, 0),
    endDate: DateTime(2023, 10, 12, 11, 0),
    location: 'City Park',
    organizers: ['Ryan Carter', 'Ava Robinson'],
    participants: ['Noah King', 'Sofia Johnson'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
];

@freezed
class FeatureEventsState with _$FeatureEventsState {
  const factory FeatureEventsState({
    required List<FeaturedEvent> featuredEvents,
    required List<FeaturedEvent> featuredEventsSpotlight,
    required LoadingState loadingState,
  }) = _FeatureEventsState;

  factory FeatureEventsState.initialize() => const FeatureEventsState(
        featuredEvents: [],
        featuredEventsSpotlight: [],
        loadingState: LoadingState.none,
      );

  factory FeatureEventsState.fromJson(Map<String, Object?> json) =>
      _$FeatureEventsStateFromJson(json);
}

class FeatureEventsCubit extends MaybeEmitHydratedCubit<FeatureEventsState> {
  FeatureEventsCubit() : super(FeatureEventsState.initialize());

  Future<void> loadFeaturedEvents() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;
    maybeEmit(state.copyWith(
      featuredEvents: mockFeaturedEventsData,
      featuredEventsSpotlight: mockFeaturedEventsData.take(3).toList(),
      loadingState: LoadingState.done,
    ));
  }

  @override
  FeatureEventsState? fromJson(Map<String, dynamic> json) {
    return FeatureEventsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FeatureEventsState state) {
    return state.toJson();
  }
}
