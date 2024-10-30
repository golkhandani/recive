import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef ArrayRes = List<dynamic>?;

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
      thumbnail: MediaModel(
        id: 'image_${faker.randomGenerator.integer(100)}',
        title: 'Artist Image',
        type: MediaType.image,
        url:
            'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(100 + i)}',
        copyright: 'copyright',
        tags: [],
      ),
      tags: ['performance', 'fashion', 'theater'],
    );
  });

  final SupabaseClient supabase;

  MockArtistRepository({
    required this.supabase,
  });

  @override
  Future<List<ArtistAbstractModel>> getArtists() async {
    final count = await supabase.from('artist').count();
    const limit = 20;
    final from = faker.randomGenerator.integer(count - limit);
    final res = await supabase.from('artist').select('''
          id,
          name,
          description,
          artist_links(link_id, link(id, url, title)),
          artist_media(media_id, media(id, url, copyright, type, title)),
          artist_tags(tag_id, tag(name))
        ''').range(from, count).limit(limit) as ArrayRes ?? [];
    final artists = res.map((rs) => ArtistAbstractModel.fromPostgres(rs)).toList();

    return artists;
  }

  @override
  Future<ArtistModel> getArtistById(String id) async {
    final res = await supabase.from('artist').select('''
          id,
          name,
          description,
          artist_links(link_id, link(id, url, title)),
          artist_media(media_id, media(id, url, copyright, type, title)),
          artist_tags(tag_id, tag(name))
        ''').eq('id', id).single();

    final artist = ArtistModel.fromPostgres(res);
    return artist;
  }
}
