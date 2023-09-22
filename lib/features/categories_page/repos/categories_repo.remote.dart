import 'package:recive/domain/graphql/__generated__/get_categories.req.gql.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/categories_page/repos/categories_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';
import 'package:recive/layout/ui_constants.dart';

class GQLCategoryRepo implements ICategoryRepo {
  final RealmGqlClient client;
  GQLCategoryRepo({
    required this.client,
  });

  @override
  Future<List<Category>> getCategories() async {
    final categoryRequest = GGetCategoriesReq();

    final data = await client.request(categoryRequest);
    final convertedData = data.data?.category_items
            .map(
              (e) => Category(
                id: e!.G_id!.value,
                title: e.title ?? '',
                description: e.description ?? '',
                subtitle: e.subtitle ?? '',
                imageUrl: e.imageUrl ?? kImagePlaceholder,
              ),
            )
            .whereType<Category>()
            .toList() ??
        [];

    return convertedData;
  }
}
