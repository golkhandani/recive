import 'package:art_for_all/core/enums/data_tables.dart';
import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:faker/faker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IEventRepository {
  Future<List<EventAbstractModel>> getEvents();
  Future<List<EventAbstractModel>> getEventsByArt(List<String> tags);
  Future<EventModel> getEventById(String id);
}

class MockEventRepository extends IEventRepository {
  final faker = Faker();

  final SupabaseClient supabase;

  MockEventRepository({
    required this.supabase,
  });

  @override
  Future<List<EventAbstractModel>> getEvents() async {
    final res = await supabase
            .from(DataTables.event.tableName)
            .select('''
              id,
              title,
              type,
              event_links(link_id, links(id, url, title)),
              event_media(media_id, media(id, url, copyright, type, title)),
              event_tags(tag_id, tags(name)),
              ${DataTables.userInteraction.tableName}(id, *)
            ''')
            .eq(
              '${DataTables.userInteraction.tableName}.user_id',
              supabase.auth.currentUser?.id ?? '',
            )
            .eq('publish_status', 'published')
            .filter('end_date', 'gte', DateTime.now())
            .order('start_date', ascending: true)
            .limit(10) as ArrayRes ??
        [];

    final events = res.map((rs) => EventAbstractModel.fromPostgres(rs)).toList();
    return events;
  }

  @override
  Future<List<EventAbstractModel>> getEventsByArt(List<String> tags) async {
    final res = await supabase
            .from(DataTables.event.tableName)
            .select('''
              id,
              title,
              type,
              event_links(link_id, links(id, url, title)),
              event_media(media_id, media(id, url, copyright, type, title)),
              event_tags!inner(tag_id, tags!inner(id, name))
            ''')
            .ilikeAnyOf('event_tags.tags.name', tags.map((t) => '%$t%').toList())
            .order('start_date', ascending: true)
            .limit(10) as ArrayRes ??
        [];

    final events = res.map((rs) => EventAbstractModel.fromPostgres(rs)).toList();
    return events;
  }

  @override
  Future<EventModel> getEventById(String id) async {
    final res = await supabase
        .from(DataTables.event.tableName)
        .select('''
          id,
          title,
          description,
          type,
          start_date,
          end_date,
          ticket_start_date,
          min_ticket_price,
          max_ticket_price,
          accessibility_features,
          registration_required,
          organizer,
          highlights,
          ${DataTables.location.tableName}(id, title, coordinates, lat, lng),
          event_links(link_id, links(id, url, title)),
          event_media(media_id, media(id, url, copyright, type, title)),
          event_tags(tag_id, tags(name)),
          ${DataTables.userInteraction.tableName}(id, *)
          ''')
        .eq(
          '${DataTables.userInteraction.tableName}.user_id',
          supabase.auth.currentUser?.id ?? '',
        )
        .eq('id', id)
        .single();
    final event = EventModel.fromPostgres(res);
    return event;
  }
}
