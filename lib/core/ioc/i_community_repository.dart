import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:faker/faker.dart';

abstract class ICommunityRepository {
  Future<List<CommunityAbstractModel>> getCommunities();
}

class MockCommunityRepository extends ICommunityRepository {
  @override
  Future<List<CommunityAbstractModel>> getCommunities() async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();

    final List<CommunityAbstractModel> events = List.generate(12, (i) {
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
    return events;
  }
}
