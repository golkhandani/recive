import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/near_me_page/sections/list_section.dart';
import 'package:recive/features/near_me_page/sections/map_section.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:toggle_switch/toggle_switch.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

final List<String> images = [
  'https://source.unsplash.com/random/?nature,mountain',
  'https://source.unsplash.com/random/?architecture,skyscraper',
  'https://source.unsplash.com/random/?travel,beach',
  'https://source.unsplash.com/random/?food,pizza',
  'https://source.unsplash.com/random/?fashion,style',
  'https://source.unsplash.com/random/?art,sculpture',
  'https://source.unsplash.com/random/?sports,athlete',
  'https://source.unsplash.com/random/?music,concert',
  'https://source.unsplash.com/random/?animal,wildlife',
  'https://source.unsplash.com/random/?vehicle,car',
  // Add more image URLs here...
];

List<EventCardContainerData> mockEventsData = [
  EventCardContainerData(
    id: '1c6e877a-ec87-425c-88c2-6711e1b8c010',
    title: 'Tech Conference',
    description: 'An event showcasing the latest technology trends.',
    startDate: DateTime(2023, 9, 15, 9, 0),
    endDate: DateTime(2023, 9, 17, 18, 0),
    location: 'City Convention Center',
    latLng: const LatLng(37.725834, -122.416417),
    organizers: ['John Doe', 'Jane Smith'],
    participants: ['Alice Johnson', 'Bob Williams', 'Charlie Brown'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  EventCardContainerData(
    id: '7e8b9e0d-7b2c-4d55-aa7c-1f8c9e2b3d4e',
    title: 'Art Exhibition',
    description: 'A gallery showcasing various forms of art.',
    startDate: DateTime(2023, 10, 5, 10, 0),
    endDate: DateTime(2023, 10, 8, 20, 0),
    location: 'Modern Art Gallery',
    latLng: const LatLng(37.785834, -122.416417),
    organizers: ['Emily Davis', 'Michael Lee'],
    participants: ['Grace Turner', 'David Miller', 'Ella White'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  EventCardContainerData(
    id: 'a2b1c0d9-e8f7-6a5b-4c3d-2e1f0a9b8c7d',
    title: 'Food Festival',
    description: 'A celebration of diverse culinary delights.',
    startDate: DateTime(2023, 11, 20, 12, 0),
    endDate: DateTime(2023, 11, 22, 22, 0),
    location: 'Central Park',
    latLng: const LatLng(37.785834, -122.426417),
    organizers: ['Sarah Johnson', 'Robert Wilson'],
    participants: ['Olivia Harris', 'James Anderson', 'Sophia Martinez'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  EventCardContainerData(
    id: 'd1e2f3a4-b5c6-7d8e-9f0a-1b2c3d4e5f6a',
    title: 'Workshop: Photography Basics',
    description: 'Learn the fundamentals of photography.',
    startDate: DateTime(2023, 9, 8, 14, 0),
    endDate: DateTime(2023, 9, 8, 18, 0),
    location: 'Community Center',
    latLng: const LatLng(37.755834, -122.406417),
    organizers: ['Alice Brown'],
    participants: ['William Turner', 'Lily Adams'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  EventCardContainerData(
    id: '7d8e9f0a-1b2c-3d4e-5f6a-7b8c9d0e1f2a',
    title: 'Charity Run',
    description: 'Run for a cause to support local charities.',
    startDate: DateTime(2023, 10, 12, 8, 0),
    endDate: DateTime(2023, 10, 12, 11, 0),
    location: 'City Park',
    latLng: const LatLng(37.715834, -122.416417),
    organizers: ['Ryan Carter', 'Ava Robinson'],
    participants: ['Noah King', 'Sofia Johnson'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  // Add more events here...
  // Repeat the process for more events...
];

class NearMeScreen extends StatefulHookWidget {
  static const name = 'near_me';
  const NearMeScreen({super.key});

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final switchIndex = useState(0);
    final pageController = usePageController(initialPage: switchIndex.value);
    final switchItems = ['Map', 'List'];
    const switchDuration = Duration(milliseconds: 300);
    final mapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );

    useEffect(() {
      locationService.requestService(onGrantedPermission: () {});
      return;
    }, []);

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight = box.maxHeight - context.invisibleHeight - 24 - 32;
        final mapSectionHeight = (contentHeight * 0.8) - 24 - 12;
        final listSectionHeight = (contentHeight * 0.2) - 24 - 12;
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            ScreenSafeAreaHeader(
              color: context.theme.primaryColor,
              title: 'Near me!',
            ),
            const SliverGap(height: 12),
            SliverToBoxAdapter(
              child: LayoutBuilder(builder: (context, box) {
                return Center(
                  child: ToggleSwitch(
                    minWidth: box.maxWidth / 4,
                    minHeight: 42.0,
                    fontSize: 16.0,
                    initialLabelIndex: switchIndex.value,
                    activeBgColor: [context.theme.colorScheme.primaryContainer],
                    activeFgColor: context.theme.colorScheme.onPrimaryContainer,
                    inactiveBgColor: context.theme.colorScheme.tertiary,
                    inactiveFgColor: context.theme.colorScheme.onTertiary,
                    totalSwitches: 2,
                    labels: switchItems,
                    animate: true,
                    animationDuration: switchDuration.inMilliseconds,
                    onToggle: (index) {
                      final val = index ?? 0;
                      switchIndex.value = val;
                      pageController.animateToPage(
                        val,
                        duration: switchDuration,
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                );
              }),
            ),
            const SliverGap(height: 12),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.transparent,
                height: contentHeight + 100,
                width: box.maxWidth,
                child: PageView(
                  allowImplicitScrolling: false,
                  controller: pageController,
                  onPageChanged: (value) => switchIndex.value = value,
                  children: [
                    CustomScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      slivers: [
                        NearMeScreenMapViewContent(
                          switchIndex: switchIndex,
                          switchItems: switchItems,
                          mapSectionHeight: mapSectionHeight,
                          listSectionHeight: listSectionHeight,
                          mapController: mapController,
                          items: mockEventsData,
                          location: locationService.location,
                        ),
                      ],
                    ),
                    CustomScrollView(
                      slivers: [
                        NearMeScreenListViewContent(
                          items: mockEventsData,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
