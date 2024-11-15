import 'package:art_for_all/core/constants.dart';
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

  late final List<EventAbstractModel> eventsFake = List.generate(12, (i) {
    return EventAbstractModel(
      id: i.toString(),
      title: faker.conference.name(),
      thumbnail: MediaModel(
        id: 'id',
        title: 'title',
        type: MediaType.image,
        url:
            'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200) + i}',
        copyright: 'copyright',
        tags: [],
      ),
      tags: ['performance', 'fashion', 'theater'],
      eventType: faker.food.cuisine(),
    );
  });

  @override
  Future<List<EventAbstractModel>> getEvents() async {
    final res = await supabase
            .from('event')
            .select('''
              id,
              title,
              type,
              event_links(link_id, link(id, url, title)),
              event_media(media_id, media(id, url, copyright, type, title)),
              event_tags(tag_id, tag(name))
            ''')
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
            .from('event')
            .select('''
              id,
              title,
              type,
              event_links(link_id, link(id, url, title)),
              event_media(media_id, media(id, url, copyright, type, title)),
              event_tags!inner(tag_id, tag!inner(id, name))
            ''')
            .ilikeAnyOf('event_tags.tag.name', tags.map((t) => '%$t%').toList())
            .order('start_date', ascending: true)
            .limit(10) as ArrayRes ??
        [];

    final events = res.map((rs) => EventAbstractModel.fromPostgres(rs)).toList();
    return events;
  }

  @override
  Future<EventModel> getEventById(String id) async {
    final res = await supabase.from('event').select('''
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
          location(id, title, coordinates, lat, lng),
          event_links(link_id, link(id, url, title)),
          event_media(media_id, media(id, url, copyright, type, title)),
          event_tags(tag_id, tag(name))
        ''').eq('id', id).single();
    final event = EventModel.fromPostgres(res);
    return event;
  }
}
