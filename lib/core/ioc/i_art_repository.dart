import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/art_model.dart';
import 'package:faker/faker.dart';
import 'package:latlong2/latlong.dart';

abstract class IArtRepository {
  Future<List<ArtAbstractModel>> getFeaturedArts(LatLng? center);

  Future<ArtModel> getDetailArt(String id);
}

class RemoteArtRepository extends IArtRepository {
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
      artists: [
        ArtistModel(
          typename: 'Artist',
          id: faker.guid.guid(),
          biography: faker.lorem.sentence(),
          country: faker.address.country(),
          images: [
            ImageModel(
              typename: 'Image',
              id: faker.guid.guid(),
              imageCredit: faker.person.name(),
              imageData: faker.lorem.sentence(),
              imageUrl:
                  'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(100)}',
            ),
          ],
          name: faker.person.name(),
          originalId: faker.randomGenerator.integer(10000),
          website: faker.internet.httpsUrl(),
        ),
      ],
      description: faker.lorem.sentences(23).join(' '),
      images: List.generate(
        10,
        (i) => ImageModel(
          typename: 'Image',
          id: faker.guid.guid(),
          imageCredit: faker.person.name(),
          imageData: faker.lorem.sentence(),
          imageUrl:
              'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(100) + i}',
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
      material: [faker.lorem.word(), faker.lorem.word()],
      originalId: faker.randomGenerator.integer(100000),
      originalUrl: faker.internet.httpsUrl(),
      ownership: faker.company.name(),
      source: SourceModel(
        id: faker.guid.guid(),
        copyRight: faker.lorem.sentence(),
        dataUrl: faker.internet.httpsUrl(),
        name: faker.company.name(),
      ),
      statement: faker.lorem.sentences(2).join(' '),
      tags: List.generate(30, (i) => faker.lorem.word()),
      title: faker.lorem.sentence(),
    );
  }
}
