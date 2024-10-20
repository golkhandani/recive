import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:faker/faker.dart';

abstract class ICategoryRepository {
  Future<List<CategoryAbstractModel>> getCategories();
  Future<CategoryAbstractModel> getCategoryById(String id);
}

class MockCategoryRepository extends ICategoryRepository {
  final faker = Faker();
  @override
  Future<List<CategoryAbstractModel>> getCategories() async {
    await Future.delayed(kLoadingDuration);

    return artCategories;
  }

  @override
  Future<CategoryAbstractModel> getCategoryById(String id) async {
    await Future.delayed(kLoadingDuration);
    final category = artCategories.firstWhere((ac) => ac.id == id);

    return category;
  }

  late final List<CategoryAbstractModel> artCategories = [
    CategoryAbstractModel(
      id: '1',
      title: 'Drag',
      description:
          'A performance art that involves exaggerated gender expression, often combining fashion, dance, and theatrical elements.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['performance', 'fashion', 'theater'],
    ),
    CategoryAbstractModel(
      id: '2',
      title: 'Cinema',
      description:
          'The art of filmmaking, including directing, cinematography, editing, and acting.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['film', 'visual', 'storytelling'],
    ),
    CategoryAbstractModel(
      id: '3',
      title: 'Painting',
      description: 'Includes mediums like oil, acrylic, and watercolor.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['visual', 'canvas', 'color'],
    ),
    CategoryAbstractModel(
      id: '4',
      title: 'Sculpture',
      description:
          'Art in three dimensions, often made from materials like stone, metal, or clay.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['3D', 'stone', 'metal', 'clay'],
    ),
    CategoryAbstractModel(
      id: '5',
      title: 'Photography',
      description: 'Capturing images using a camera, either digital or film.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['visual', 'camera', 'digital', 'film'],
    ),
    CategoryAbstractModel(
      id: '6',
      title: 'Drawing',
      description: 'Using pencil, charcoal, ink, or other tools to create images.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['pencil', 'charcoal', 'ink', 'sketch'],
    ),
    CategoryAbstractModel(
      id: '7',
      title: 'Digital Art',
      description:
          'Art created using digital technology, including computer-generated imagery.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['digital', 'CGI', 'technology'],
    ),
    CategoryAbstractModel(
      id: '8',
      title: 'Printmaking',
      description: 'The process of creating artworks by printing, typically on paper.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['printing', 'paper', 'ink'],
    ),
    CategoryAbstractModel(
      id: '9',
      title: 'Ceramics',
      description: 'Art made from clay and other ceramic materials.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['clay', 'sculpture', 'pottery'],
    ),
    CategoryAbstractModel(
      id: '10',
      title: 'Textile Art',
      description: 'Art that uses fibers, fabrics, and other textile materials.',
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: ['fiber', 'fabric', 'weaving'],
    ),
  ];
}
