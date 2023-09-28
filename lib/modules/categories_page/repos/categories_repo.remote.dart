import 'package:recive/core/domain/client/realm_gql_client.dart';
import 'package:recive/core/domain/fake_data.dart';
import 'package:recive/core/domain/graphql/__generated__/get_categories.req.gql.dart';
import 'package:recive/modules/categories_page/models/category.dart';
import 'package:recive/modules/categories_page/repos/categories_repo.interface.dart';

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
                imageUrl: e.imageUrl ?? fakeImagePlaceholder,
              ),
            )
            .whereType<Category>()
            .toList() ??
        [];

    return convertedData;
  }
}
