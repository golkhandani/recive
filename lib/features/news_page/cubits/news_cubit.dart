import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/news_page/models/news_model.dart';
import 'package:recive/layout/context_ui_extension.dart';

part 'news_cubit.freezed.dart';
part 'news_cubit.g.dart';

const dex = '''
Alright, here's a 100-line description of the enchanting beauty of a serene forest:

In the heart of nature's embrace lies a place of wonder and tranquility—a serene forest that captivates the soul with its timeless beauty. This enchanting woodland, untouched by the hurried hands of man, stretches as far as the eye can see, a living testament to the magnificence of the natural world.

Towering ancient trees, their gnarled branches reaching for the heavens, stand sentinel.
A lush carpet of emerald-green moss blankets the forest floor, a testament to the perpetually moist air.
Sunlight filters through the canopy above, casting a dappled mosaic of light and shadow.
Birds of myriad colors and melodies grace the air with their joyful songs.
The air is alive with the hum of insects and the occasional rustle of small creatures.
A babbling brook winds its way through the heart of the forest, its crystal-clear waters glistening in the sunlight.
Ferns and wildflowers thrive in the shade, painting the forest with bursts of vibrant color.
The scent of pine and earth is carried on a gentle breeze, soothing the senses.
Majestic deer graze quietly in the meadows, their graceful movements a sight to behold.
Squirrels playfully dart among the branches, their fluffy tails trailing behind them.
The forest seems to whisper secrets to those who listen, its ancient wisdom a source of solace.
A symphony of rustling leaves, chirping crickets, and distant calls of unseen creatures serenades all who venture here.
Time stands still in this sanctuary, where the modern world's chaos is but a distant memory.
Each step is a connection to the Earth's heartbeat, grounding and rejuvenating.
Shafts of golden sunlight pierce the forest canopy, creating an ethereal, almost mystical atmosphere.
Wild mushrooms, their shapes and colors an artistry of nature, dot the forest floor.
Moss-covered boulders and fallen logs provide cozy resting spots for weary travelers.
A sense of wonder and awe fills the heart as one explores this living masterpiece.
The forest, like an ancient library, holds stories untold in the rings of its towering trees.
In the stillness of dawn, the forest awakens with a chorus of birds greeting the day.
At twilight, fireflies illuminate the darkness, creating a mesmerizing dance of light.
The forest's colors shift with the seasons, from the emerald greens of spring to the fiery hues of autumn.
Even in winter's embrace, a serene beauty remains, with snow-laden branches creating a pristine landscape.
The night sky above the forest is a canvas of stars, each one a distant promise of adventure and discovery.
For generations, this forest has been a sanctuary for both wildlife and those seeking solace.
The ancient trees, with their gnarled bark, seem to hold the memories of centuries past.
Here, time moves at its own pace, unhurried by the demands of the outside world.
A sense of peace envelops all who enter, as if the forest itself is a guardian of serenity.
The forest floor, scattered with fallen leaves and twigs, crunches softly underfoot.
It is a place where one can truly reconnect with the natural rhythms of life.
The sound of a distant waterfall trickles through the air, a reminder of the forest's hidden treasures.
Vibrant fungi, like living jewels, cling to decaying logs, adding to the forest's rich tapestry.
Butterflies flutter by, their delicate wings carrying them on a whimsical journey.
As the seasons change, the forest transforms, each stage of life a testament to its resilience.
A sense of reverence for the Earth's beauty and mystery washes over those who wander here.
The forest's ageless wisdom imparts a sense of humility, reminding us of our place in the grand tapestry of life.
It is a place of solitude, where one can escape the noise and distractions of modern existence.
The forest seems to breathe, its rhythms synchronized with the pulse of the planet.
A fleeting glimpse of a fox or a rabbit adds an element of enchantment to the journey.
In the heart of the forest, a hidden glade reveals itself, a sanctuary within a sanctuary.
Wild berries tempt with their sweet and tangy allure, a gift from the forest's bounty.
The rustling leaves create a soothing lullaby, inviting peaceful contemplation.
Mighty oaks, with their sprawling canopies, create natural cathedrals of shade

''';

List<NewsModel> mockNews = [
  NewsModel(
    id: '1b9466aa-83c3-4f1a-9f2d-44c1260a3f4f',
    title: 'Tech Giant Unveils New Smartphone Model',
    description:
        'The tech company announced its latest smartphone with advanced features. $dex',
    publishDate: DateTime(2023, 8, 19, 10, 0),
    source: 'TechNews',
  ),
  NewsModel(
    id: '1b9466aa-83c3-4f1a-9f2d-44c1220a3f4d',
    title: 'Scientists Discover New Species of Bird',
    description:
        'Researchers identified a previously unknown bird species in a remote forest.$dex',
    publishDate: DateTime(2023, 8, 18, 15, 30),
    source: 'Science Times',
  ),
  NewsModel(
    id: '1b9466aa-83c3-4f1a-9f2d-44c1260a3f4d',
    title: 'Tech Giant Unveils New Smartphone Model',
    description:
        'The tech company announced its latest smartphone with advanced features.$dex',
    publishDate: DateTime(2023, 8, 19, 10, 0),
    source: 'TechNews',
  ),
  NewsModel(
    id: '2e9b61d8-79a1-4f18-950f-bfd10003e7e2',
    title: 'Scientists Discover New Species of Bird',
    description:
        'Researchers identified a previously unknown bird species in a remote forest.$dex',
    publishDate: DateTime(2023, 8, 18, 15, 30),
    source: 'Science Times',
  ),
  NewsModel(
    id: '3c802d10-476b-42c0-8e1a-785f6c8210d4',
    title: 'New Study on Climate Change Impact',
    description:
        'A recent study reveals alarming effects of climate change on ocean temperatures.$dex',
    publishDate: DateTime(2023, 8, 17, 12, 15),
    source: 'Environmental Watch',
  ),
  NewsModel(
    id: '4f671c11-01f2-4b09-9f92-eb27ebe4d65f',
    title: 'Space Exploration Milestone Achieved',
    description:
        'Astronauts successfully completed a record-breaking spacewalk mission.$dex',
    publishDate: DateTime(2023, 8, 16, 9, 45),
    source: 'SpaceNews',
  ),
  NewsModel(
    id: '5a6f20d5-ff77-4e66-aa3c-723a9486c995',
    title: 'Local Community Celebrates Annual Festival',
    description:
        'Residents gather for a festive celebration showcasing cultural heritage.$dex',
    publishDate: DateTime(2023, 8, 15, 17, 0),
    source: 'Community Gazette',
  ),
  // Add more news summaries here...
];

@freezed
class NewsState with _$NewsState {
  const factory NewsState({
    required LoadingState selectedLoadingState,
    required NewsModel? selected,
    required List<NewsModel> news,
    required List<NewsModel> newsSpotlight,
    required LoadingState loadingState,
  }) = _NewsState;

  factory NewsState.initialize() => const NewsState(
        selectedLoadingState: LoadingState.none,
        selected: null,
        //
        news: [],
        newsSpotlight: [],
        loadingState: LoadingState.none,
      );

  factory NewsState.fromJson(Map<String, Object?> json) =>
      _$NewsStateFromJson(json);
}

class NewsCubit extends MaybeEmitHydratedCubit<NewsState> {
  NewsCubit() : super(NewsState.initialize());

  Future<void> loadSelectedNews(String id) async {
    maybeEmit(state.copyWith(
      selectedLoadingState: LoadingState.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));
    maybeEmit(state.copyWith(
      selected: mockNews.firstWhere((element) => element.id == id),
      selectedLoadingState: LoadingState.done,
    ));
  }

  Future<void> emptySelectedNews() async {
    maybeEmit(state.copyWith(
      selected: null,
      selectedLoadingState: LoadingState.none,
    ));
  }

  Future<void> loadNews() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;
    maybeEmit(state.copyWith(
      news: mockNews,
      newsSpotlight: mockNews.take(3).toList(),
      loadingState: LoadingState.done,
    ));
  }

  @override
  NewsState? fromJson(Map<String, dynamic> json) {
    return NewsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NewsState state) {
    return state.toJson();
  }
}
