import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ICategoryRepository {
  Future<List<CategoryAbstractModel>> getCategories();
  Future<CategoryAbstractModel> getCategoryById(String id);
}

class MockCategoryRepository extends ICategoryRepository {
  final SupabaseClient supabase;

  MockCategoryRepository({
    required this.supabase,
  });

  final faker = Faker();

  @override
  Future<List<CategoryAbstractModel>> getCategories() async {
    final response = await supabase
        .from('categories')
        .select('id, title, description, image_url, category_tags(tag_id (name))')
        .order('title', ascending: true);

    final assets = supabase.storage.from('assets');
    var categories = await Future.wait(response.map((c) async {
      final cat = CategoryAbstractModel.fromPostgres(c);
      final image = await MediaModel.fromSignedUrl(
        // replace it in db with media record
        MediaModel(
          id: 'id',
          title: 'title',
          type: MediaType.image,
          url: cat.imageUrl,
          copyright: 'copyright',
          tags: [],
        ),
        assets,
      );
      return cat.copyWith(imageUrl: image.url);
    }));

    _artCategories = categories.toList();
    return _artCategories;
  }

  @override
  Future<CategoryAbstractModel> getCategoryById(String id) async {
    final c = _artCategories.firstWhere((ac) => ac.id == id);
    return c;
  }

  List<CategoryAbstractModel> _artCategories = [];
}
