import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';

abstract class IArtistRepository {
  Future<List<ArtistAbstractModel>> getArtists();

  Future<ArtistModel> getArtistById(String id);
}

class MockArtistRepository extends IArtistRepository {
  final faker = Faker();

  late final List<ArtistAbstractModel> artists = List.generate(12, (i) {
    return ArtistAbstractModel(
      id: i.toString(),
      name: faker.person.name(),
      description:
          'A performance art that involves exaggerated gender expression, often combining fashion, dance, and theatrical elements.',
      imageUrl:
          'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200) + i}',
      tags: ['performance', 'fashion', 'theater'],
    );
  });

  @override
  Future<List<ArtistAbstractModel>> getArtists() async {
    await Future.delayed(kDebounceDuration);

    return artists;
  }

  @override
  Future<ArtistModel> getArtistById(String id) async {
    await Future.delayed(kDebounceDuration);
    final abstractArtists = artists.firstWhere(
      (a) => a.id == id,
      orElse: () => artists.first,
    );
    return ArtistModel(
      id: abstractArtists.id,
      description: abstractArtists.description,
      name: abstractArtists.name,
      media: [
        MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: abstractArtists.imageUrl,
          copyright: 'copyright',
          tags: [],
        ),
        MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: 'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
          copyright: 'copyright',
          tags: [],
        ),
        MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: 'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
          copyright: 'copyright',
          tags: [],
        ),
        MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: 'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
          copyright: 'copyright',
          tags: [],
        )
      ],
      tags: faker.lorem.words(14),
      links: List.generate(4, (li) {
        return LinkModel(
          id: li.toString(),
          title: faker.company.name(),
          url: faker.internet.httpsUrl(),
        );
      }),
    );
  }
}
