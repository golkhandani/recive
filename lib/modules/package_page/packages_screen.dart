import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/package_page/cubits/packages_cubit.dart';
import 'package:recive/modules/package_page/widgets/art_route_card_container_data.dart';
import 'package:recive/modules/package_page/widgets/art_route_expanded_card_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';

class PackagesScreen extends StatefulHookWidget {
  static const name = 'packages';
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  initState() {
    super.initState();
  }

  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  int lastIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<PackagesCubit>();
    final state = useBlocBuilder(bloc);
    final scrollController = useScrollController();

    useBlocComparativeListener<PackagesCubit, PackagesState>(
      bloc,
      (bloc, current, context) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          for (var item in current.packages) {
            final index = current.packages.indexOf(item);
            _listKey.currentState!.insertItem(
              index,
              duration: const Duration(milliseconds: 200),
            );
          }
        });
      },
      listenWhen: (o, n) => o.packages.length != n.packages.length,
    );

    useEffect(() {
      bloc.loadPackages();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        scrollController.addListener(() {
          if (state.loadingMoreState == LoadingState.loading) {
            return;
          }
          if (scrollController.offset + 10 >
              scrollController.position.maxScrollExtent) {
            bloc.loadMorePackages();
          }
        });
      });
      return;
    }, []);

    return ColoredBox(
      color: context.colorScheme.background,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          const ScreenSafeAreaHeader(
            title: 'Packages',
          ),
          SliverPadding(
            padding: kMediumPadding.copyWith(
              bottom: state.loadingMoreState == LoadingState.loading
                  ? 16
                  : context.footerHeight + 16,
            ),
            sliver: context.checkLoadingState(state.loadingState) ??
                MultiSliver(
                  children: [
                    SliverAnimatedList(
                      key: _listKey,
                      itemBuilder: (context, index, animation) {
                        // Note: handle pre-view scroll items
                        if (index > state.packages.length - 1) {
                          return const SizedBox();
                        }
                        final data = ArtRouteContainerData.fromAbstract(
                          state.packages[index],
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ArtRouteExpandedCardContainer(
                            data: data,
                          ),
                        );
                      },
                    ),
                  ],
                ),
          ),
          if (state.loadingMoreState == LoadingState.loading)
            SliverPadding(
              padding: EdgeInsets.only(bottom: context.footerHeight + 16),
              sliver: kSliverBoxAnimatedLoading,
            ),
        ],
      ),
    );
  }
}
