import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:latlong2/latlong.dart';

abstract class IEventRepository {
  Future<List<EventAbstractModel>> getEvents();
  Future<EventModel> getEventById(String id);
}

class MockEventRepository extends IEventRepository {
  final faker = Faker();

  late final List<EventAbstractModel> events = List.generate(12, (i) {
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

  @override
  Future<List<EventAbstractModel>> getEvents() async {
    await Future.delayed(kLoadingDuration);

    return events;
  }

  @override
  Future<EventModel> getEventById(String id) async {
    await Future.delayed(kLoadingDuration);
    final abstract = events.firstWhere((e) => e.id == id);

    final event = EventModel(
      id: abstract.id,
      title: abstract.title,
      description: abstract.description,
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
      tags: ['performance', 'fashion', 'theater'],
      eventType: 'Screening',
      dateTime: DateTime.now(),
      link: [],
      highlights: [],
      art: ArtAbstractModel(
        id: faker.guid.guid(),
        title: faker.lorem.words(3).join(' '),
        description: faker.lorem.sentence(),
        location: faker.address.streetAddress(),
        geoLocation: const LatLng(0, 0),
        imageUrl:
            'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
        tags: faker.lorem.words(3),
      ),
      community: CommunityAbstractModel(
        id: faker.randomGenerator.integer(200).toString(),
        title: faker.conference.name(),
        description:
            'A performance art that involves exaggerated gender expression, often combining fashion, dance, and theatrical elements.',
        imageUrl:
            'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
        tags: ['performance', 'fashion', 'theater'],
      ),
    );
    return event;
  }
}
