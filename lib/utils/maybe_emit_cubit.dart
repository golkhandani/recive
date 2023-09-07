import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class MaybeEmitHydratedCubit<State> extends HydratedCubit<State> {
  MaybeEmitHydratedCubit(super.state);

  @override
  State? fromJson(Map<String, dynamic> json);

  @override
  Map<String, dynamic>? toJson(State state);

  maybeEmit(State state) {
    if (isClosed) return;
    emit(state);
  }
}

abstract class MaybeEmitCubit<State> extends Cubit<State> {
  MaybeEmitCubit(super.state);

  maybeEmit(State state) {
    if (isClosed) return;
    emit(state);
  }
}
