import 'dart:math';
import 'package:art_for_all/core/enums/data_tables.dart';
import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/art_model.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum UserInteracts {
  like,
  save,
  report,
  share,
}

enum Entities {
  art,
  artist,
  event,
}

abstract class IArtRepository {
  Future<List<ArtAbstractModel>> getArtsByCategoryId(String categoryId);
  Future<List<ArtAbstractModel>> getFeaturedArts(LatLng? center);
  Future<ArtAbstractModel?> getDayArt(LatLng? center);
  Future<ArtModel> getDetailArt(String id);
  Future<bool> interact(
    String id,
    Entities refType,
    UserInteracts interactType,
    bool? result,
    String? reason,
  );
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
    totalCount ??= await supabase
        .from(DataTables.art.tableName)
        .count()
        .eq('publish_status', 'published');
    return totalCount!;
  }

  @override
  Future<bool> interact(
    String id,
    Entities refType,
    UserInteracts interactType,
    bool? result,
    String? reason,
  ) async {
    if (supabase.auth.currentUser == null) {
      // need login
      return false;
    }

    final exists = await supabase
        .from(DataTables.userInteraction.tableName)
        .select('*')
        .eq('art_id', id)
        .eq('user_id', supabase.auth.currentUser!.id)
        .limit(1)
        .maybeSingle();

    print(exists);
    if (exists?['report_message'] != null && interactType == UserInteracts.report) {
      // already reported
      return false;
    }

    final a = await supabase.from(DataTables.userInteraction.tableName).upsert(
      {
        'artist_id': null,
        'event_id': null,
        'art_id': id,
        'user_id': supabase.auth.currentUser!.id,
        if (interactType == UserInteracts.like) ...{'is_liked': result ?? false},
        if (interactType == UserInteracts.save) ...{'is_saved': result ?? false},
        if (interactType == UserInteracts.report) ...{'report_message': reason ?? ''},
        if (interactType == UserInteracts.share) ...{
          'share_count': exists?['share_count'] ?? 1
        },
      },
      onConflict: 'user_id, art_id, artist_id, event_id ',
    );

    return true;
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
    final res = await supabase
        .from(DataTables.art.tableName)
        .select('''
            id,
            title,
            description,
            type,
            material,
            ownership,
            ${DataTables.location.tableName}(id, title, coordinates, lat, lng),
            art_links(link_id, links(id, url, title)),
            art_media(media_id, media(id, url, copyright, type, title)),
            art_tags(tag_id, tags(name)),
            ${DataTables.userInteraction.tableName}(id, *)
    ''')
        .eq(
          '${DataTables.userInteraction.tableName}.user_id',
          supabase.auth.currentUser?.id ?? '',
        )
        .eq('publish_status', 'published')
        .range(rand, rand + 1)
        .limit(1)
        .single();

    return ArtAbstractModel.fromPostgres(res);
  }

  @override
  Future<List<ArtAbstractModel>> getFeaturedArts(LatLng? center) async {
    final count = await _getCount();
    if (count == 0) return [];

    final rand = faker.randomGenerator.integer(count - min(10, count));
    final res = await supabase.from(DataTables.art.tableName).select('''
            id,
            title,
            description,
            type,
            material,
            ownership,
            ${DataTables.location.tableName}(id, title, coordinates, lat, lng),
            art_links(link_id, links(id, url, title)),
            art_media!inner(media_id, media(id, url, copyright, type, title)),
            art_tags(tag_id, tags(name))
    ''').eq('publish_status', 'published').range(rand, rand + 10).limit(10) as ArrayRes;

    return res?.map((r) => ArtAbstractModel.fromPostgres(r)).toList() ?? [];
  }

  @override
  Future<ArtModel> getDetailArt(String id) async {
    final res = await supabase
        .from(DataTables.art.tableName)
        .select('''
            id,
            title,
            description,
            type,
            material,
            ownership,
            ${DataTables.location.tableName}(id, *),
            art_artists!inner (artist_id, ${DataTables.artist.tableName}(
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
            art_links(link_id, links(id, url, title)),
            art_media(media_id, media(id, url, copyright, type, title)),
            art_tags(tag_id, tags(name)),
            ${DataTables.userInteraction.tableName}(id, *)
    ''')
        .eq(
          '${DataTables.userInteraction.tableName}.user_id',
          supabase.auth.currentUser?.id ?? '',
        )
        .eq('id', id)
        .limit(1)
        .single();
    print(res['user_interactions']);
    final artArtists = (res['art_artists'] as ArrayRes) ?? [];
    final artists = artArtists
        .map(
          (aa) => ArtistAbstractModel.fromPostgres(aa['artists']),
        )
        .toList();

    final interaction = UserInteractionModel.fromPostgres(res['user_interactions']);

    final artMedia = res['art_media'] as ArrayRes ?? [];
    List<MediaModel> media = [];
    if (artMedia.isEmpty) {
      media.add(MediaModel.artistPlaceholder);
    } else {
      media = artMedia.map((am) => MediaModel.fromPostgres(am['media'])).toList();
    }

    final address =
        "${res['locations']['title']} \n${res['locations']['area']} - ${res['locations']['city']} - ${res['locations']['region']} - ${res['locations']['country']} \n\n${res['locations']['details']}";

    return ArtModel(
      id: res['id'],
      userInteraction: interaction,
      title: res['title'],
      description: res['description'],
      artType: res['type'],
      media: media,
      location: address,
      geoLocation: LatLng(res['locations']['lat'] ?? 0, res['locations']['lng'] ?? 0),
      tags: (res['art_tags'] as List<dynamic>? ?? []).map((at) {
        return at['tags']['name'] as String;
      }).toList(),
      links: (res['art_links'] as List<dynamic>? ?? []).map((al) {
        final l = al['links'];
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
            ${DataTables.art.tableName} (
                id,
                title,
                description,
                type,
                material,
                ownership,
                ${DataTables.location.tableName}(id, title, coordinates, lat, lng),
                art_links(link_id, links(id, url, title)),
                art_media!inner(media_id, media(id, url, copyright, type, title)),
                art_tags(tag_id, tags(name))
            )
    ''').eq('event_id', eventId).limit(100) as ArrayRes ?? [];

    final arts = res
        .map((rs) => ArtAbstractModel.fromPostgres(
              rs[DataTables.art.tableName],
            ))
        .toList();
    return arts;
  }

  @override
  Future<List<ArtAbstractModel>> getSimilarArts(String currentId, List<String> tags) async {
    final res = await supabase
        .from(DataTables.art.tableName)
        .select('''
            id,
            title,
            description,
            type,
            material,
            ownership,
            ${DataTables.location.tableName}(id, title, coordinates, lat, lng),
            art_links(link_id, links(id, url, title)),
            art_media!inner(media_id, media(id, url, copyright, type, title)),
            art_tags!inner(tag_id, tags!inner(id, name))
        ''')
        .ilikeAnyOf('art_tags.tags.name', tags.map((t) => '%$t%').toList())
        .eq('publish_status', 'published')
        .neq('id', currentId)
        .limit(10) as ArrayRes;

    return res?.map((r) => ArtAbstractModel.fromPostgres(r)).toList() ?? [];
  }
}
