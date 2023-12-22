import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/modules/featured_page/cubits/featured_cubit.dart';
import 'package:recive/modules/near_me_page/widgets/art_card_container_data.dart';
import 'package:recive/modules/near_me_page/widgets/art_expanded_card_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class FeaturedScreen extends HookWidget {
  static const name = 'featured';
  const FeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<FeaturedCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadFeatured();
      return;
    }, []);

    return ColoredBox(
      color: context.colorTheme.background,
      child: CustomScrollView(
        slivers: [
          const ScreenSafeAreaHeader(
            title: 'Featured Arts',
          ),
          SliverPadding(
            padding: kMediumPadding.copyWith(
              bottom: context.footerHeight + 16,
            ),
            sliver: Builder(
              builder: (context) {
                return context.checkLoadingState(state.loadingState) ??
                    MultiSliver(
                      children: [
                        SliverList.builder(
                          addAutomaticKeepAlives: true,
                          itemCount: state.artAbstractItems.length,
                          itemBuilder: (context, index) {
                            final data = ArtCardContainerData.fromAbstractArt(
                              state.artAbstractItems[index],
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ArtExpandedCardContainer(
                                data: data,
                              ),
                            );
                          },
                        ),
                      ],
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
