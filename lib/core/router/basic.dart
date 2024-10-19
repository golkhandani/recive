import 'package:art_for_all/core/router/extra_data.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  static String name = 'MyWidget';
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class OnboardingScreen extends StatefulWidget {
  static String name = 'OnboardingScreen';
  final int initialPage;
  const OnboardingScreen({super.key, this.initialPage = 0});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PackagesScreen extends StatefulWidget {
  static String name = 'PackagesScreen';
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CategoriesScreen extends StatefulWidget {
  static String name = 'CategoriesScreen';
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class NewsScreen extends StatefulWidget {
  static String name = 'NewsScreen';
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class FeaturedScreen extends StatefulWidget {
  static String name = 'FeaturedScreen';
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SearchScreen extends StatefulWidget {
  static String name = 'SearchScreen';
  static const keywordQueryKey = 'keyword';

  final String? keyword;
  const SearchScreen({
    super.key,
    this.keyword,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("SearchScreen"),
    );
  }
}

class BookmarksScreen extends StatefulWidget {
  static String name = 'BookmarksScreen';
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CategoryDetailScreen extends StatefulWidget {
  static String name = 'CategoryDetailScreen';
  static String pathParamId = 'id';

  final String id;
  final ExtraData<CategoryCardContainerData>? extra;

  const CategoryDetailScreen({super.key, required this.id, this.extra});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PackageDetailScreen extends StatefulWidget {
  static String name = 'PackageDetailScreen';
  static String pathParamId = 'id';

  final String id;
  final ExtraData<PackageSummaryData>? extra;

  const PackageDetailScreen({super.key, required this.id, this.extra});

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class NewsDetailScreen extends StatefulWidget {
  static String name = 'NewsDetailScreen';
  static String pathParamId = 'id';

  final String id;
  final ExtraData<NewsSummaryData>? extra;

  const NewsDetailScreen({super.key, required this.id, this.extra});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
