import 'package:hydrated_bloc/hydrated_bloc.dart';

class StateWithIsLoading {
  final bool isLoading;

  StateWithIsLoading(this.isLoading);
}

extension ValidCachedState on HydratedBloc {
  bool get isCached =>
      HydratedBloc.storage.read(storageToken) != null &&
      (state is StateWithIsLoading) &&
      !(state as StateWithIsLoading).isLoading;
}
