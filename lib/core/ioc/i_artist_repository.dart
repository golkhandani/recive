import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:faker/faker.dart';

abstract class IArtistRepository {
  Future<List<ArtistAbstractModel>> getArtists();
}

class MockArtistRepository extends IArtistRepository {
  @override
  Future<List<ArtistAbstractModel>> getArtists() async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();

    final List<ArtistAbstractModel> artCategories = List.generate(12, (i) {
      return ArtistAbstractModel(
        id: i.toString(),
        name: faker.person.name(),
        description:
            'A performance art that involves exaggerated gender expression, often combining fashion, dance, and theatrical elements.',
        imageUrl:
            'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200) + i}',
        tags: ['performance', 'fashion', 'theater'],
      );
    });
    return artCategories;
  }
}
