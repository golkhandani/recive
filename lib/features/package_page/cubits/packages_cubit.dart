import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/package_page/models/package.dart';
import 'package:recive/features/package_page/repos/package_event_repo.interface.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'packages_cubit.freezed.dart';
part 'packages_cubit.g.dart';

@freezed
class PackagesState with _$PackagesState {
  const factory PackagesState({
    required LoadingState packageLoadingState,
    required Package? package,
    required List<PackageAbstract> packages,
    required List<PackageAbstract> packagesSpotlight,
    required LoadingState loadingState,
    required LoadingState loadingMoreState,
  }) = _PackagesState;

  factory PackagesState.initialize() => const PackagesState(
        packageLoadingState: LoadingState.none,
        package: null,
        //
        packages: [],
        packagesSpotlight: [],
        loadingState: LoadingState.none,
        loadingMoreState: LoadingState.none,
      );

  factory PackagesState.fromJson(Map<String, Object?> json) =>
      _$PackagesStateFromJson(json);
}

class PackagesCubit extends MaybeEmitHydratedCubit<PackagesState> {
  final IPackageEventRepo repo;
  PackagesCubit({
    required this.repo,
  }) : super(PackagesState.initialize());

  Future<void> loadPackages() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final data = await repo.packages(
      limit: 10,
    );

    maybeEmit(state.copyWith(
      packages: data,
      loadingState: LoadingState.done,
    ));
  }

  Future<void> loadMorePackages() async {
    if (state.loadingMoreState == LoadingState.loading ||
        state.loadingState == LoadingState.loading) {
      return;
    }
    maybeEmit(state.copyWith(
      loadingMoreState: LoadingState.loading,
    ));

    final data = await repo.packages(
      limit: 10,
      lastItem: state.packages.last,
    );

    maybeEmit(state.copyWith(
      packages: [...state.packages, ...data],
      loadingMoreState: LoadingState.done,
    ));
  }

  Future<void> loadPackage(String id) async {
    maybeEmit(state.copyWith(
      packageLoadingState: LoadingState.loading,
    ));

    final data = await repo.packageById(id: id);
    Future.delayed(const Duration(seconds: 1));

    maybeEmit(state.copyWith(
      package: data,
      packageLoadingState: LoadingState.done,
    ));
  }

  Future<void> emptyPackage() async {
    maybeEmit(state.copyWith(
      package: null,
      packageLoadingState: LoadingState.none,
    ));
  }

  @override
  PackagesState? fromJson(Map<String, dynamic> json) {
    return PackagesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PackagesState state) {
    return state.toJson();
  }
}
