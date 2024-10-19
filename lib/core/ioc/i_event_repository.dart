import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';

abstract class IEventRepository {
  Future<List<EventAbstractModel>> getEvents();
}

class MockEventRepository extends IEventRepository {
  @override
  Future<List<EventAbstractModel>> getEvents() async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();

    final List<EventAbstractModel> events = List.generate(12, (i) {
      return EventAbstractModel(
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
