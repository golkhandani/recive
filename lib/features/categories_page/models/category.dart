import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

enum LoadingState {
  none,
  loading,
  updating,
  done,
  error,
}

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

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String title,
    required String subtitle,
    required String description,
    required String imageUrl,
  }) = _Category;

  factory Category.fromJson(Map<String, Object?> json) =>
      _$CategoryFromJson(json);
}
