import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/news_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:latlong2/latlong.dart';

abstract class INewsRepository {
  Future<List<NewsAbstractModel>> getFeaturedNews(LatLng? center);

  Future<NewsAbstractModel> getDetailNews(String id);
}

class MockNewsRepository extends INewsRepository {
  @override
  Future<List<NewsAbstractModel>> getFeaturedNews(LatLng? center) async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();

    return List.generate(16, (index) {
      return NewsAbstractModel(
        id: faker.guid.guid(),
        title: faker.lorem.words(3).join(' '),
        description: faker.lorem.sentence(),
        location: faker.address.streetAddress(),
        link: faker.internet.httpsUrl(),
        imageUrl:
            'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
        tags: faker.lorem.words(3),
      );
    });
  }

  @override
  Future<NewsAbstractModel> getDetailNews(String id) async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();

    return NewsAbstractModel(
      id: faker.guid.guid(),
      title: faker.lorem.words(3).join(' '),
      description: faker.lorem.sentence(),
      location: faker.address.streetAddress(),
      link: faker.internet.httpsUrl(),
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: faker.lorem.words(3),
    );
  }
}
