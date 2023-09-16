import 'package:recive/features/categories_page/models/category.dart';

abstract class ICategoryRepo {
  Future<List<Category>> getCategories();
}
