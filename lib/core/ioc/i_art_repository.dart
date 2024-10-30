import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/art_model.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IArtRepository {
  Future<List<ArtAbstractModel>> getArtsByCategoryId(String categoryId);

  Future<List<ArtAbstractModel>> getFeaturedArts(LatLng? center);
  Future<List<ArtAbstractModel>> getNearbyArts(LatLng? center);
  Future<ArtAbstractModel> getDayArt(LatLng? center);

  Future<ArtModel> getDetailArt(String id);
}

class MockArtRepository extends IArtRepository {
  final SupabaseClient supabase;
  final faker = Faker();

  MockArtRepository({
    required this.supabase,
  });

  @override
  Future<List<ArtAbstractModel>> getArtsByCategoryId(String categoryId) async {
    await Future.delayed(kDebounceDuration);

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
        thumbnail: MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: 'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
          copyright: 'copyright',
          tags: [],
        ),
        tags: faker.lorem.words(3),
        artType: faker.address.city(),
      );
    });
  }

  @override
  Future<List<ArtAbstractModel>> getFeaturedArts(LatLng? center) async {
    final count = await supabase.from('art').count();
    final rand = faker.randomGenerator.integer(count - 10);
    final res = await supabase.from('art').select('''
            id,
            title,
            description,
            type,
            material,
            ownership,
            location(id, title, coordinates, lat, lng),
            art_links(link_id, link(id, url, title)),
            art_media!inner(media_id, media(id, url, copyright, type, title)),
            art_tags(tag_id, tag(name))
    ''').range(rand, rand + 10).limit(10) as ArrayRes;

    return res?.map((r) => ArtAbstractModel.fromPostgres(r)).toList() ?? [];
  }

  @override
  Future<List<ArtAbstractModel>> getNearbyArts(LatLng? center) async {
    await Future.delayed(kDebounceDuration);

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
        thumbnail: MediaModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: 'image',
          type: MediaType.image,
          url: 'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
          copyright: 'copyright',
          tags: [],
        ),
        tags: faker.lorem.words(3),
        artType: faker.address.city(),
      );
    });
  }

  @override
  Future<ArtModel> getDetailArt(String id) async {
    final res = await supabase.from('art').select('''
            id,
            title,
            description,
            type,
            material,
            ownership,
            location(id, title, coordinates, lat, lng),
            art_artists!inner (artist_id, artist(
                id, 
                name,
                description,
                artist_media (
                  media_id, 
                  media (
                    id, 
                    url, 
                    copyright, 
                    type, 
                    title
                  )
                )
            )),
            art_links(link_id, link(id, url, title)),
            art_media(media_id, media(id, url, copyright, type, title)),
            art_tags(tag_id, tag(name))
    ''').eq('id', id).limit(1).single();

    final artArtists = (res['art_artists'] as ArrayRes) ?? [];
    final artists = artArtists
        .map(
          (aa) => ArtistAbstractModel.fromPostgres(aa['artist']),
        )
        .toList();

    final artMedia = res['art_media'] as ArrayRes ?? [];
    List<MediaModel> media = [];
    if (artMedia.isEmpty) {
      media.add(MediaModel.artistPlaceholder);
    } else {
      media = artMedia.map((am) => MediaModel.fromPostgres(am['media'])).toList();
    }

    return ArtModel(
      id: res['id'],
      title: res['title'],
      description: res['description'],
      artType: res['type'],
      media: media,
      location: res['location']['title'],
      geoLocation: LatLng(res['location']['lat'] ?? 0, res['location']['lng'] ?? 0),
      tags: (res['art_tags'] as List<dynamic>? ?? []).map((at) {
        return at['tag']['name'] as String;
      }).toList(),
      links: (res['art_links'] as List<dynamic>? ?? []).map((al) {
        final l = al['link'];
        return LinkModel(
          id: l['id'],
          title: l['title'],
          url: l['url'],
        );
      }).toList(),
      artists: artists,
      communities: [
        CommunityAbstractModel(
          id: faker.randomGenerator.integer(200).toString(),
          title: faker.conference.name(),
          description:
              'A performance art that involves exaggerated gender expression, often combining fashion, dance, and theatrical elements.',
          imageUrl:
              'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
          tags: ['performance', 'fashion', 'theater'],
        )
      ],
    );
  }

  @override
  Future<ArtAbstractModel> getDayArt(LatLng? center) async {
    final count = await supabase.from('art').count();
    final rand = faker.randomGenerator.integer(count - 1);
    final res = await supabase.from('art').select('''
            id,
            title,
            description,
            type,
            material,
            ownership,
            location(id, title, coordinates, lat, lng),
            art_links(link_id, link(id, url, title)),
            art_media(media_id, media(id, url, copyright, type, title)),
            art_tags(tag_id, tag(name))
    ''').range(rand, rand + 1).limit(1).single();

    return ArtAbstractModel.fromPostgres(res);
  }
}
