import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/layout/context_ui_extension.dart';

part 'category_section_cubit.freezed.dart';
part 'category_section_cubit.g.dart';

const article =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

final List<String> images = [
  'https://source.unsplash.com/random/?city,night',
  'https://source.unsplash.com/random/?nature,forest',
  'https://source.unsplash.com/random/?technology,code',
  'https://source.unsplash.com/random/?food,dish',
  'https://source.unsplash.com/random/?architecture,building',
  'https://source.unsplash.com/random/?travel,adventure',
  'https://source.unsplash.com/random/?fashion,clothing',
  'https://source.unsplash.com/random/?art,painting',
  'https://source.unsplash.com/random/?sports,fitness',
  'https://source.unsplash.com/random/?music,instrument',
  // Add more image URLs here...
];

List<Category> mockCategoriesData = [
  Category(
    id: 'c7e4db9e-9377-4e52-9b26-3b03d2fb4d81',
    title: 'Technology',
    subtitle: 'Latest gadgets and innovations',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  Category(
    id: '0d6d8c3e-6f61-4c9a-9a79-1d7eb77aa2ec',
    title: 'Health & Fitness',
    subtitle: 'Tips for a healthier lifestyle',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  Category(
    id: 'b72e0c4b-82d2-4e90-9e68-2656cc7b1c1c',
    title: 'Travel',
    subtitle: 'Exploring the world, one destination at a time',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  Category(
    id: 'f7a15f98-8904-42fc-82b2-76a6b53ec9f1',
    title: 'Food & Cooking',
    subtitle: 'Delicious recipes and culinary adventures',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  Category(
    id: 'de7549b6-6c91-4b0b-b81c-60b7e43a31d8',
    title: 'Fashion',
    subtitle: 'Trends, styles, and outfit inspiration',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  Category(
    id: 'fe9b7644-1706-4cb5-9652-4e4331d81c84',
    title: 'Home Decor',
    subtitle: 'Ideas for decorating and organizing your space',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  Category(
    id: '142e0290-2c52-4a79-9e44-4488953c1557',
    title: 'Finance',
    subtitle: 'Managing money and achieving financial goals',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  Category(
    id: 'a0858c8c-ef9e-4ebc-a762-eb4eb0b1263f',
    title: 'Parenting',
    subtitle: 'Guidance and support for parents',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  Category(
    id: '5788b31a-0a50-4a4f-9d6b-30b0a7ff0d8f',
    title: 'Art & Culture',
    subtitle: 'Exploring creativity in various forms',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  Category(
    id: '48f55a08-8e75-48f7-a8da-39c14732f9e6',
    title: 'Science',
    subtitle: 'Discoveries and advancements in the scientific world',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
];

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    required List<Category> categories,
    required List<Category> categoriesSpotlight,
    required LoadingState loadingState,
  }) = _CategoriesState;

  factory CategoriesState.initialize() => const CategoriesState(
        categories: [],
        categoriesSpotlight: [],
        loadingState: LoadingState.none,
      );

  factory CategoriesState.fromJson(Map<String, Object?> json) =>
      _$CategoriesStateFromJson(json);
}

class CategoriesCubit extends MaybeEmitHydratedCubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesState.initialize());

  Future<void> loadCategories() async {
    maybeEmit(state.copyWith(
      categories: mockCategoriesData,
      loadingState: LoadingState.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;
    maybeEmit(state.copyWith(
      categories: mockCategoriesData,
      categoriesSpotlight: mockCategoriesData.take(3).toList(),
      loadingState: LoadingState.done,
    ));
  }

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) {
    return CategoriesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoriesState state) {
    return state.toJson();
  }
}
