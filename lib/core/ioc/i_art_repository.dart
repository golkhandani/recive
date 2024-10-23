import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/art_model.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:latlong2/latlong.dart';

abstract class IArtRepository {
  Future<List<ArtAbstractModel>> getArtsByCategoryId(String categoryId);

  Future<List<ArtAbstractModel>> getFeaturedArts(LatLng? center);
  Future<List<ArtAbstractModel>> getNearbyArts(LatLng? center);
  Future<ArtAbstractModel> getDayArt(LatLng? center);

  Future<ArtModel> getDetailArt(String id);
}

class MockArtRepository extends IArtRepository {
  @override
  Future<List<ArtAbstractModel>> getArtsByCategoryId(String categoryId) async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();
    const double baseLatitude = 51.52;
    const double baseLongitude = -0.09;

    return List.generate(36, (index) {
      final double latVariation = faker.randomGenerator.decimal(min: -0.01, scale: 0.01);
      final double lngVariation = faker.randomGenerator.decimal(min: -0.01, scale: 0.01);

      return ArtAbstractModel(
        id: faker.guid.guid(),
        title: faker.lorem.words(3).join(' '),
        description: faker.lorem.sentence(),
        location: faker.address.streetAddress(),
        geoLocation: LatLng(
          baseLatitude + latVariation, // Latitude close to base
          baseLongitude + lngVariation, // Longitude close to base
        ),
        imageUrl:
            'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
        tags: faker.lorem.words(3),
        artType: faker.address.city(),
      );
    });
  }

  @override
  Future<List<ArtAbstractModel>> getFeaturedArts(LatLng? center) async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();
    final double baseLatitude = center?.latitude ?? 51.52;
    final double baseLongitude = center?.longitude ?? -0.09;

    return List.generate(6, (index) {
      final double latVariation = faker.randomGenerator.decimal(min: -0.01, scale: 0.01);
      final double lngVariation = faker.randomGenerator.decimal(min: -0.01, scale: 0.01);

      return ArtAbstractModel(
        id: faker.guid.guid(),
        title: faker.lorem.words(3).join(' '),
        description: faker.lorem.sentence(),
        location: faker.address.streetAddress(),
        geoLocation: LatLng(
          baseLatitude + latVariation, // Latitude close to base
          baseLongitude + lngVariation, // Longitude close to base
        ),
        imageUrl:
            'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
        tags: faker.lorem.words(3),
        artType: faker.address.city(),
      );
    });
  }

  @override
  Future<List<ArtAbstractModel>> getNearbyArts(LatLng? center) async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();
    final double baseLatitude = center?.latitude ?? 51.52;
    final double baseLongitude = center?.longitude ?? -0.09;

    return List.generate(20, (index) {
      final double latVariation = faker.randomGenerator.decimal(min: -0.01, scale: 0.01);
      final double lngVariation = faker.randomGenerator.decimal(min: -0.01, scale: 0.01);

      return ArtAbstractModel(
        id: faker.guid.guid(),
        title: faker.lorem.words(3).join(' '),
        description: faker.lorem.sentence(),
        location: faker.address.streetAddress(),
        geoLocation: LatLng(
          baseLatitude + latVariation, // Latitude close to base
          baseLongitude + lngVariation, // Longitude close to base
        ),
        imageUrl:
            'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
        tags: faker.lorem.words(3),
        artType: faker.address.city(),
      );
    });
  }

  @override
  Future<ArtModel> getDetailArt(String id) async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();

    return ArtModel(
      id: faker.guid.guid(),
      artType: faker.lorem.word(),
      artists: List.generate(12, (i) {
        return ArtistAbstractModel(
          id: faker.guid.guid(),
          imageUrl:
              'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(100 + i)}',
          name: faker.person.name(),
          description: '',
          tags: [],
        );
      }),
      description: faker.lorem.sentences(23).join(' '),
      media: List.generate(
        10,
        (i) => MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
          copyright: 'copyright',
          tags: [],
        ),
      ),
      location: LocationModel(
        geolocation: GeolocationModel(
          typename: 'Geolocation',
          coordinates: [faker.randomGenerator.decimal(), faker.randomGenerator.decimal()],
          type: 'Point',
        ),
        venue: VenueModel(
          typename: 'Venue',
          id: faker.guid.guid(),
          address: AddressModel(
            area: faker.address.streetName(),
            city: faker.address.city(),
            country: faker.address.country(),
            latitude: faker.randomGenerator.decimal(),
            localizedAddressDisplay: faker.address.streetAddress(),
            longitude: faker.randomGenerator.decimal(),
            postalCode: faker.address.zipCode(),
            region: faker.address.state(),
          ),
          geolocation: GeolocationModel(
            typename: 'Geolocation',
            coordinates: [faker.randomGenerator.decimal(), faker.randomGenerator.decimal()],
            type: 'Point',
          ),
          osmId: faker.randomGenerator.integer(100000),
          osmLicense: 'ODbL',
          osmVenueId: faker.randomGenerator.integer(100000),
          title: faker.company.name(),
        ),
        latLng: LatLng(faker.randomGenerator.decimal(), faker.randomGenerator.decimal()),
      ),
      tags: List.generate(30, (i) => faker.lorem.word()),
      title: faker.lorem.sentence(),
      links: List.generate(4, (li) {
        return LinkModel(
          id: li.toString(),
          title: faker.company.name(),
          url: faker.internet.httpsUrl(),
        );
      }),
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
  }

  @override
  Future<ArtAbstractModel> getDayArt(LatLng? center) async {
    await Future.delayed(kLoadingDuration);

    final faker = Faker();
    final double baseLatitude = center?.latitude ?? 51.52;
    final double baseLongitude = center?.longitude ?? -0.09;

    final double latVariation = faker.randomGenerator.decimal(min: -0.01, scale: 0.01);
    final double lngVariation = faker.randomGenerator.decimal(min: -0.01, scale: 0.01);

    return ArtAbstractModel(
      id: faker.guid.guid(),
      title: faker.lorem.words(3).join(' '),
      description: faker.lorem.sentence(),
      location: faker.address.streetAddress(),
      geoLocation: LatLng(
        baseLatitude + latVariation, // Latitude close to base
        baseLongitude + lngVariation, // Longitude close to base
      ),
      imageUrl: 'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(200)}',
      tags: faker.lorem.words(3),
      artType: faker.address.city(),
    );
  }
}
