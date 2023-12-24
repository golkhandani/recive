import 'package:flutter/material.dart';

import 'package:recive/modules/near_me_page/cubits/near_by_cubit.dart';
import 'package:recive/modules/near_me_page/near_me_screen.dart';
import 'package:recive/modules/search_page/widgets/tag_chip_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class NearMeFilterBar extends StatelessWidget {
  const NearMeFilterBar({
    super.key,
    required this.showFilters,
    required this.queryFilter,
    required this.artTypeFilters,
    required this.bloc,
    required this.textEditingController,
    required this.onFilterSelected,
  });

  final bool showFilters;
  final List<ArtTypeFilter> artTypeFilters;
  final String? queryFilter;
  final NearbyCubit bloc;
  final TextEditingController textEditingController;
  final void Function(ArtTypeFilter filter) onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 400),
        child: showFilters
            ? Container(
                padding: kTinyPadding,
                decoration: BoxDecoration(
                  color: context.colorTheme.navBackground,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(0.2, 0),
                      blurRadius: 4,
                      color: context.colorTheme.primary.darken(0.2),
                    )
                  ],
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: kTinyPadding,
                      child: Text(
                        'Popular Categories:',
                        style: context.textTheme.bodyMedium.style,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (artTypeFilters.isEmpty)
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(height: 300),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else
                      RepaintBoundary(
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          clipBehavior: Clip.hardEdge,
                          spacing: 4,
                          runSpacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: List.generate(
                            artTypeFilters.length,
                            (index) => SizedBox(
                              width: (MediaQuery.sizeOf(context).width - 32) / 3,
                              height: 48,
                              child: FilterTagChipContainer(
                                backgroundColor: artTypeFilters[index].category?.title == queryFilter
                                    ? context.colorTheme.chipBackground
                                    : context.colorTheme.chipDisabledBackground,
                                color: artTypeFilters[index].category?.title == queryFilter
                                    ? context.colorTheme.onChipBackground
                                    : context.colorTheme.onChipDisabledBackground,
                                tag: artTypeFilters[index].title,
                                onTap: () => onFilterSelected(artTypeFilters[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
