import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/home_page/sections/featured_event_section.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/enums/loading_state.dart';

part 'featured_events_cubit.freezed.dart';
part 'featured_events_cubit.g.dart';

@freezed
class FeatureEventsState with _$FeatureEventsState {
  const factory FeatureEventsState({
    required FeaturedEvent? featuredEventSummary,
    required FeaturedEvent? featuredEvent,
    required List<FeaturedEvent> featuredEvents,
    required List<FeaturedEvent> featuredEventsSpotlight,
    required LoadingState loadingState,
  }) = _FeatureEventsState;

  factory FeatureEventsState.initialize() => const FeatureEventsState(
        featuredEvents: [],
        featuredEventsSpotlight: [],
        loadingState: LoadingState.none,
        featuredEventSummary: null,
        featuredEvent: null,
      );

  factory FeatureEventsState.fromJson(Map<String, Object?> json) =>
      _$FeatureEventsStateFromJson(json);
}

class FeatureEventsCubit extends MaybeEmitHydratedCubit<FeatureEventsState> {
  final IEventRepo repo;
  FeatureEventsCubit({
    required this.repo,
  }) : super(FeatureEventsState.initialize());

  Future<void> loadFeaturedEvents() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final data = await repo.events(
      limit: 10,
      sortBy: EventSortByInput.startDateAsc,
    );

    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;
    maybeEmit(state.copyWith(
      featuredEvents: data,
      featuredEventsSpotlight: data.take(3).toList(),
      loadingState: LoadingState.done,
    ));
  }

  Future<void> loadFeaturedEvent({
    required String id,
    FeaturedEventCardContainerData? summary,
  }) async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
      featuredEventSummary: summary == null
          ? null
          : FeaturedEvent(
              id: summary.id,
              title: summary.title,
              description: summary.description,
              startDate: summary.startDate,
              endDate: summary.endDate,
              location: summary.location,
              organizers: summary.organizers,
              participants: summary.participants,
              imageUrl: summary.imageUrl,
            ),
      featuredEvent: null,
    ));

    final data = await repo.event(id: id);

    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;
    maybeEmit(state.copyWith(
      featuredEvent: data,
      loadingState: LoadingState.done,
    ));
  }

  Future<void> emptyFeaturedEvent() async {
    maybeEmit(state.copyWith(
      featuredEventSummary: null,
      featuredEvent: null,
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
