import 'package:art_for_all/core/enums/data_tables.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef ArrayRes = List<dynamic>?;

abstract class IArtistRepository {
  Future<List<ArtistAbstractModel>> getArtists();

  Future<ArtistModel> getArtistById(String id);
  Future<List<ArtistAbstractModel>> getArtistsByEventId(String eventId);
}

class MockArtistRepository extends IArtistRepository {
  final faker = Faker();

  final SupabaseClient supabase;

  MockArtistRepository({
    required this.supabase,
  });

  @override
  Future<List<ArtistAbstractModel>> getArtists() async {
    final count = (await supabase
            .from(DataTables.artist.tableName)
            .select('artist_media!inner(media_id)')
            .count(CountOption.exact))
        .count;
    const limit = 20;
    final from = faker.randomGenerator.integer(count - limit);
    final res = await supabase.from(DataTables.artist.tableName).select('''
          id,
          name,
          description,
          artist_links(link_id, links(id, url, title)),
          artist_media!inner(media_id, media(id, url, copyright, type, title)),
          artist_tags(tag_id, tags(name))
        ''').range(from, count).limit(limit) as ArrayRes ?? [];
    final artists = res.map((rs) => ArtistAbstractModel.fromPostgres(rs)).toList();

    return artists;
  }

  @override
  Future<List<ArtistAbstractModel>> getArtistsByEventId(String eventId) async {
    final res = await supabase.from('event_artists').select('''
            event_id,
            artist_id,
            artists (
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
            )
    ''').eq('event_id', eventId).limit(100) as ArrayRes ?? [];

    final artists = res.map((rs) => ArtistAbstractModel.fromPostgres(rs['artists'])).toList();
    return artists;
  }

  @override
  Future<ArtistModel> getArtistById(String id) async {
    final res = await supabase.from(DataTables.artist.tableName).select('''
          id,
          name,
          description,
          artist_links(link_id, links(id, url, title)),
          artist_media(media_id, media(id, url, copyright, type, title)),
          artist_tags(tag_id, tags(name))
        ''').eq('id', id).single();

    final artist = ArtistModel.fromPostgres(res);
    return artist;
  }
}
