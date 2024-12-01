import 'package:art_for_all/core/enums/data_tables.dart';
import 'package:art_for_all/core/ioc/i_art_repository.dart';
import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IUserInteractionRepository {
  Future<UserInteractionModel?> interact(
    String id,
    EntityType refType,
    UserInteractionModel interaction,
  );

  Future<List<InteratedEntityAbstractModel>> getSavedItems({
    required int page,
    required int limit,
  });
}

class SupabaseUserInteractionRepository extends IUserInteractionRepository {
  final SupabaseClient supabase;

  SupabaseUserInteractionRepository({
    required this.supabase,
  });

  final faker = Faker();

  @override
  Future<UserInteractionModel?> interact(
    String id,
    EntityType refType,
    UserInteractionModel interaction,
  ) async {
    if (supabase.auth.currentUser == null) {
      // need login
      return null;
    }

    final ref = switch (refType) {
      EntityType.art => 'art_id',
      EntityType.artist => 'artist_id',
      EntityType.event => 'event_id',
      _ => '',
    };
    final exists = await supabase
        .from(DataTables.userInteraction.tableName)
        .select('*')
        .eq(ref, id)
        .eq('user_id', supabase.auth.currentUser!.id)
        .limit(1)
        .maybeSingle();

    final existsInteraction =
        exists == null ? null : UserInteractionModel.fromPostgres([exists]);

    if (interaction == existsInteraction) {
      // already reported
      return null;
    }

    final interact = await supabase
        .from(DataTables.userInteraction.tableName)
        .upsert(
          {
            'artist_id': null,
            'event_id': null,
            'art_id': null,
            // actuall ref
            ref: id,
            'user_id': supabase.auth.currentUser!.id,
            'is_liked': interaction.isLiked,
            'is_saved': interaction.isSaved,
            'report_message': interaction.isSaved,
            'share_count': interaction.shareCount
          },
          onConflict: 'user_id, art_id, artist_id, event_id ',
        )
        .select('*')
        .limit(1)
        .single();

    return UserInteractionModel.fromPostgres([interact]);
  }

  @override
  Future<List<InteratedEntityAbstractModel>> getSavedItems({
    required int page,
    required int limit,
  }) async {
    final res = await supabase
        .from(DataTables.userInteraction.tableName)
        .select(
          '''
          id,
          ${DataTables.art.tableName}(
            id,
            title,
            art_media(media_id, media(id, url, copyright, type, title)),
            art_tags(tag_id, tags(name))
          ),
          ${DataTables.artist.tableName}(
            id,
            name,
            artist_media(media_id, media(id, url, copyright, type, title)),
            artist_tags(tag_id, tags(name))
          ),
          ${DataTables.event.tableName}(
            id,
            title,
            event_media(media_id, media(id, url, copyright, type, title)),
            event_tags(tag_id, tags(name))
          )
          ''',
        )
        .eq('is_saved', true)
        .eq('user_id', supabase.auth.currentUser!.id);

    List<InteratedEntityAbstractModel> items = [];
    for (var item in res) {
      final data = item['arts'] ?? item['artists'] ?? item['events'];
      final dataMedia =
          (data['art_media'] ?? data['artist_media'] ?? data['event_media']) as ArrayRes;

      final dataTags =
          (data['art_tags'] ?? data['artist_tags'] ?? data['event_tags']) as ArrayRes;
      MediaModel th;
      if (dataMedia?.isEmpty ?? true) {
        th = MediaModel.artistPlaceholder;
      } else {
        th = MediaModel.fromPostgres(dataMedia!.first['media']);
      }

      final tags = (dataTags ?? []).map((at) {
        return at['tags']['name'] as String;
      }).toList();
      items.add(
        InteratedEntityAbstractModel(
          id: data['id'],
          title: data['title'] ?? data['name'],
          entityType: item['arts'] != null
              ? EntityType.art
              : item['events'] != null
                  ? EntityType.event
                  : EntityType.artist,
          imageUrl: th.url,
          tags: tags,
        ),
      );
    }

    return items;
  }
}
