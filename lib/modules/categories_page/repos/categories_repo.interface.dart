import 'package:recive/modules/categories_page/models/category.dart';

abstract class ICategoryRepo {
  Future<List<Category>> getCategories();
}
