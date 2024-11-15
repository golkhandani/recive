import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_art_repository.dart';
import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/ioc/i_event_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'event_detail_bloc.freezed.dart';
part 'event_detail_bloc.g.dart';

@freezed
class EventDetailBlocState with _$EventDetailBlocState {
  const factory EventDetailBlocState({
    required LoadingState isLoading,
    EventAbstractModel? eventAbstract,
    EventModel? event,
    @Default([]) List<ArtistAbstractModel> artists,
    @Default([]) List<ArtAbstractModel> arts,
  }) = _EventDetailBlocState;

  factory EventDetailBlocState.initialize() => const EventDetailBlocState(
        isLoading: LoadingState.none,
      );

  factory EventDetailBlocState.fromJson(Map<String, Object?> json) =>
      _$EventDetailBlocStateFromJson(json);
}

class EventDetailBloc extends HydratedCubit<EventDetailBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;

  final IEventRepository eventRepository;
  final IArtistRepository artistRepository;
  final IArtRepository artRepository;

  EventDetailBloc({
    required this.secureStorage,
    required this.sharedStorage,
    required this.eventRepository,
    required this.artistRepository,
    required this.artRepository,
  }) : super(EventDetailBlocState.initialize());

  Future<void> init(String id) async {
    emit(state.copyWith(
      isLoading: LoadingState.loading,
    ));

    final event = await eventRepository.getEventById(id);

    final artists = await artistRepository.getArtistsByEventId(id);

    final arts = await artRepository.getArtsByEventId(id);

    emit(state.copyWith(
      isLoading: LoadingState.done,
      event: event,
      artists: artists,
      arts: arts,
    ));
  }

  @override
  EventDetailBlocState? fromJson(Map<String, dynamic> json) {
    return EventDetailBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(EventDetailBlocState state) {
    return state.toJson();
  }
}
