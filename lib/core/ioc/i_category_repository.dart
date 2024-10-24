import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
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

  Future<String> _signUrl(String url) async {
    var res = url;
    try {
      final assets = supabase.storage.from('assets');
      res = await assets.createSignedUrl(url.split('assets/')[1], 3600);
    } catch (e, s) {
      Logger.error('Cannot sign image', e, s);
    }

    return res;
  }

  @override
  Future<List<CategoryAbstractModel>> getCategories() async {
    return Future.wait(
      artCategories.map((c) async {
        return c.copyWith(imageUrl: await _signUrl(c.imageUrl));
      }).toList(),
    );
  }

  @override
  Future<CategoryAbstractModel> getCategoryById(String id) async {
    final c = artCategories.firstWhere((ac) => ac.id == id);
    return c.copyWith(imageUrl: await _signUrl(c.imageUrl));
  }

  late List<CategoryAbstractModel> artCategories = [
    const CategoryAbstractModel(
      id: '1',
      title: 'Drag',
      description:
          'A performance art that involves exaggerated gender expression, often combining fashion, dance, and theatrical elements.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/drag.png',
      tags: ['performance', 'fashion', 'theater'],
    ),
    const CategoryAbstractModel(
      id: '2',
      title: 'Cinema',
      description:
          'The art of filmmaking, including directing, cinematography, editing, and acting.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/cinema.png',
      tags: ['film', 'visual', 'storytelling'],
    ),
    const CategoryAbstractModel(
      id: '3',
      title: 'Painting',
      description: 'Includes mediums like oil, acrylic, and watercolor.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/painting.jpeg',
      tags: ['visual', 'canvas', 'color'],
    ),
    const CategoryAbstractModel(
      id: '4',
      title: 'Sculpture',
      description:
          'Art in three dimensions, often made from materials like stone, metal, or clay.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/sculpture.png',
      tags: ['3D', 'stone', 'metal', 'clay'],
    ),
    const CategoryAbstractModel(
      id: '5',
      title: 'Photography',
      description: 'Capturing images using a camera, either digital or film.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/photography.png',
      tags: ['visual', 'camera', 'digital', 'film'],
    ),
    const CategoryAbstractModel(
      id: '6',
      title: 'Drawing',
      description: 'Using pencil, charcoal, ink, or other tools to create images.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/drawing.jpeg',
      tags: ['pencil', 'charcoal', 'ink', 'sketch'],
    ),
    const CategoryAbstractModel(
      id: '7',
      title: 'Digital Art',
      description:
          'Art created using digital technology, including computer-generated imagery.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/photography.png',
      tags: ['digital', 'CGI', 'technology'],
    ),
    const CategoryAbstractModel(
      id: '8',
      title: 'Printmaking',
      description: 'The process of creating artworks by printing, typically on paper.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/drawing.jpeg',
      tags: ['printing', 'paper', 'ink'],
    ),
    const CategoryAbstractModel(
      id: '9',
      title: 'Ceramics',
      description: 'Art made from clay and other ceramic materials.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/ceramics.jpeg',
      tags: ['clay', 'sculpture', 'pottery'],
    ),
    const CategoryAbstractModel(
      id: '10',
      title: 'Textile Art',
      description: 'Art that uses fibers, fabrics, and other textile materials.',
      imageUrl:
          'https://lnjwywjzvylrggiporqm.supabase.co/storage/v1/object/sign/assets/public/photography.png',
      tags: ['fiber', 'fabric', 'weaving'],
    ),
  ];
}
