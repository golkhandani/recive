import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recive/archived/models/fasting.model.dart';
import 'package:recive/archived/repositories/fasting.repository.interface.dart';

import 'package:recive/utils/valid_bloc_cache.dart';

part 'fasting_bloc.freezed.dart';
part 'fasting_bloc.g.dart';

@freezed
class FastingEvent with _$FastingEvent {
  const factory FastingEvent.load() = _FastingEventLoad;
}

@freezed
class FastingState extends HydratedState with _$FastingState {
  const factory FastingState({
    @Default(null) DateTime? $cachedAt,
    @Default(false) bool isLoading,
    @Default([]) List<Fasting> fastings,
    @Default(null) Fasting? selectedFastings,
  }) = _FastingState;

  factory FastingState.fromJson(Map<String, dynamic> json) =>
      _$FastingStateFromJson(json);

  const FastingState._();

  @override
  bool get isValidState => !isLoading && fastings.isNotEmpty;
}

class FastingBloc extends HydratedBloc<FastingEvent, FastingState> {
  final IFastingRepository _fastingRepository;
  FastingBloc({
    required IFastingRepository fastingRepository,
  })  : _fastingRepository = fastingRepository,
        super(const FastingState()) {
    on<FastingEvent>((event, emit) async {
      await event.when(load: () => _load(emit));
    });
  }

  @override
  FastingState? fromJson(Map<String, dynamic> json) =>
      FastingState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(FastingState state) => state.$updated.toJson();

  Future<void> _load(Emitter<FastingState> emit) async {
    final fasting = await _fastingRepository.getInfo();
    emit(state.copyWith(fastings: [fasting], selectedFastings: fasting));
    return;
  }
}
