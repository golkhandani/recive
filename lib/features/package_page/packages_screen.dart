import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/package_page/cubits/packages_cubit.dart';
import 'package:recive/features/package_page/widgets/package_card_container.dart';
import 'package:recive/features/package_page/widgets/package_expanded_card_container.dart';

import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PackagesScreen extends HookWidget {
  static const name = 'packages';
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<PackagesCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadPackages();
      return;
    }, []);

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          const ScreenSafeAreaHeader(
            title: 'Packages',
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
                          itemCount: state.packages.length,
                          itemBuilder: (context, index) {
                            final data = PackageCardContainerData.fromPackage(
                              state.packages[index],
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: PackageExpandedCardContainer(
                                data: data,
                              ),
                            );
                          }),
                    ],
                  );
            }),
          ),
        ],
      ),
    );
  }
}
