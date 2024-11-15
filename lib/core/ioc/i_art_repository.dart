import 'dart:math';
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
  Future<ArtAbstractModel?> getDayArt(LatLng? center);
  Future<ArtModel> getDetailArt(String id);
  Future<List<ArtAbstractModel>> getSimilarArts(String currentId, List<String> tags);
  Future<List<ArtAbstractModel>> getArtsByEventId(String eventId);
}

class MockArtRepository extends IArtRepository {
  final SupabaseClient supabase;
  final faker = Faker();
  int? totalCount;

  MockArtRepository({
    required this.supabase,
  }) {
    _getCount();
  }

  Future<int> _getCount() async {
    totalCount ??= await supabase.from('art').count().eq('publish_status', 'published');
    return totalCount!;
  }

  @override
  Future<List<ArtAbstractModel>> getArtsByCategoryId(String categoryId) async {
    return [];
  }

  @override
  Future<ArtAbstractModel?> getDayArt(LatLng? center) async {
    final count = await _getCount();
    if (count == 0) return null;
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
    ''').eq('publish_status', 'published').range(rand, rand + 1).limit(1).single();

    return ArtAbstractModel.fromPostgres(res);
  }

  @override
  Future<List<ArtAbstractModel>> getFeaturedArts(LatLng? center) async {
    final count = await _getCount();
    if (count == 0) return [];

    final rand = faker.randomGenerator.integer(count - min(10, count));
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
    ''').eq('publish_status', 'published').range(rand, rand + 10).limit(10) as ArrayRes;

    return res?.map((r) => ArtAbstractModel.fromPostgres(r)).toList() ?? [];
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
            location(id, *),
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

    final address =
        "${res['location']['title']} \n${res['location']['area']} - ${res['location']['city']} - ${res['location']['region']} - ${res['location']['region']} \n\n${res['location']['details']}";

    return ArtModel(
      id: res['id'],
      title: res['title'],
      description: res['description'],
      artType: res['type'],
      media: media,
      location: address,
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
  Future<List<ArtAbstractModel>> getArtsByEventId(String eventId) async {
    final res = await supabase.from('event_arts').select('''
            event_id,
            art_id,
            art (
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
            )
    ''').eq('event_id', eventId).limit(100) as ArrayRes ?? [];

    final arts = res.map((rs) => ArtAbstractModel.fromPostgres(rs['art'])).toList();
    return arts;
  }

  @override
  Future<List<ArtAbstractModel>> getSimilarArts(String currentId, List<String> tags) async {
    final res = await supabase
        .from('art')
        .select('''
            id,
            title,
            description,
            type,
            material,
            ownership,
            location(id, title, coordinates, lat, lng),
            art_links(link_id, link(id, url, title)),
            art_media!inner(media_id, media(id, url, copyright, type, title)),
            art_tags!inner(tag_id, tag!inner(id, name))
        ''')
        .ilikeAnyOf('art_tags.tag.name', tags.map((t) => '%$t%').toList())
        .eq('publish_status', 'published')
        .neq('id', currentId)
        .limit(10) as ArrayRes;

    return res?.map((r) => ArtAbstractModel.fromPostgres(r)).toList() ?? [];
  }
}
