import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';

abstract class ICommunityRepository {
  Future<List<CommunityAbstractModel>> getCommunities();
  Future<CommunityModel> getCommunityById(String id);
}

class MockCommunityRepository extends ICommunityRepository {
  final faker = Faker();

  late final List<CommunityAbstractModel> communities = List.generate(12, (i) {
    return CommunityAbstractModel(
      id: i.toString(),
      title: faker.conference.name(),
      description:
          'A performance art that involves exaggerated gender expression, often combining fashion, dance, and theatrical elements.',
      imageUrl:
          'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200) + i}',
      tags: ['performance', 'fashion', 'theater'],
    );
  });

  @override
  Future<List<CommunityAbstractModel>> getCommunities() async {
    await Future.delayed(kLoadingDuration);

    return communities;
  }

  @override
  Future<CommunityModel> getCommunityById(String id) async {
    await Future.delayed(kLoadingDuration);

    final abstract = communities.firstWhere((e) => e.id == id);
    return CommunityModel(
      id: abstract.id,
      title: abstract.title,
      description: abstract.description + faker.lorem.sentences(20).join(' '),
      media: [
        MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: abstract.imageUrl,
          copyright: 'copyright',
          tags: [],
        ),
        MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
          copyright: 'copyright',
          tags: [],
        ),
        MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
          copyright: 'copyright',
          tags: [],
        ),
        MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
          copyright: 'copyright',
          tags: [],
        )
      ],
      tags: faker.lorem.words(14),
      communityType: 'CinemaPlex',
      dateTime: DateTime.now(),
      links: List.generate(4, (li) {
        return LinkModel(
          id: li.toString(),
          title: faker.company.name(),
          url: faker.internet.httpsUrl(),
        );
      }),
      highlights: faker.lorem.sentences(4),
    );
  }
}
