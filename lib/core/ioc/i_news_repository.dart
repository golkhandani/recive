import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/models/news_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:latlong2/latlong.dart';

abstract class INewsRepository {
  Future<List<NewsAbstractModel>> getFeaturedNews(LatLng? center);
  Future<List<NewsAbstractModel>> getNewsByArt(String artId);

  Future<NewsModel> getDetailNews(String id);
}

class MockNewsRepository extends INewsRepository {
  final faker = Faker();

  late final List<NewsAbstractModel> news = List.generate(16, (index) {
    return NewsAbstractModel(
      id: faker.guid.guid(),
      title: faker.lorem.words(3).join(' '),
      description: faker.lorem.sentence(),
      location: faker.address.streetAddress(),
      imageUrl: 'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
    );
  });
  @override
  Future<List<NewsAbstractModel>> getFeaturedNews(LatLng? center) async {
    await Future.delayed(kLoadingDuration);
    return news;
  }

  @override
  Future<List<NewsAbstractModel>> getNewsByArt(String artId) async {
    await Future.delayed(kLoadingDuration);

    return news;
  }

  @override
  Future<NewsModel> getDetailNews(String id) async {
    await Future.delayed(kLoadingDuration);

    final newsAbstract = news.firstWhere(
      (n) => n.id == id,
      orElse: () => news.first,
    );

    return NewsModel(
      id: newsAbstract.id,
      title: newsAbstract.title,
      description: faker.lorem.sentence(),
      location: faker.address.streetAddress(),
      newsType: 'City',
      media: [
        MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: newsAbstract.imageUrl,
          copyright: 'copyright',
          tags: [],
        ),
      ],
      tags: faker.lorem.words(14),
      dateTime: DateTime.now(),
      links: List.generate(4, (li) {
        return LinkModel(
          id: li.toString(),
          title: faker.company.name(),
          url: faker.internet.httpsUrl(),
        );
      }),
      highlights: faker.lorem.sentences(4),
      art: ArtAbstractModel(
        id: faker.guid.guid(),
        title: faker.lorem.words(3).join(' '),
        description: faker.lorem.sentence(),
        location: faker.address.streetAddress(),
        geoLocation: const LatLng(0, 0),
        imageUrl:
            'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
        tags: faker.lorem.words(3),
        artType: faker.address.city(),
      ),
      community: CommunityAbstractModel(
        id: faker.randomGenerator.integer(200).toString(),
        title: faker.conference.name(),
        description:
            'A performance art that involves exaggerated gender expression, often combining fashion, dance, and theatrical elements.',
        imageUrl:
            'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
        tags: ['performance', 'fashion', 'theater'],
      ),
    );
  }
}
