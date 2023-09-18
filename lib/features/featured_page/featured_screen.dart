import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/features/featured_page/cubits/featured_events_cubit.dart';
import 'package:recive/features/featured_page/widgets/featured_event_card_container_data.dart';
import 'package:recive/features/featured_page/widgets/featured_event_expanded_card_container.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';

class FeaturedScreen extends HookWidget {
  static const name = 'featured';
  const FeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<FeatureEventsCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadFeaturedEvents();
      return;
    }, []);

    return ColoredBox(
      color: context.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          const ScreenSafeAreaHeader(
            title: 'Featured Arts',
          ),
          SliverPadding(
            padding: kMediumPadding.copyWith(
              bottom: context.footerHeight + 16,
            ),
            sliver: Builder(builder: (context) {
              return context.checkLoadingState(state.loadingState) ??
                  MultiSliver(
                    children: [
                      SliverList.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: state.artAbstractItems.length,
                        itemBuilder: (context, index) {
                          final data =
                              FeaturedArtCardContainerData.fromFeaturedEvent(
                            state.artAbstractItems[index],
                          );
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: FeaturedEventExpandedCardContainer(
                              data: data,
                            ),
                          );
                        },
                      ),
                    ],
                  );
            }),
          ),
        ],
      ),
    );
  }
}
