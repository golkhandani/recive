import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginate_state.freezed.dart';
part 'paginate_state.g.dart';

@freezed
class PaginationState with _$PaginationState {
  const factory PaginationState({
    required int page,
    required int itemPerPage,
    required int total,
  }) = _PaginationState;

  factory PaginationState.fromJson(Map<String, Object?> json) =>
      _$PaginationStateFromJson(json);
}
