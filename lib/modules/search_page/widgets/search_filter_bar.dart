import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:recive/core/components/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/core/components/quick_search_header/quick_search_header_component.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({
    super.key,
    required this.quickSearchBloc,
    required this.textEditingController,
    required this.onFilterClicked,
    required this.onSearchItemSelected,
    required this.onSearchTextChanged,
  });

  final QuickSearchHeaderBloc quickSearchBloc;
  final TextEditingController textEditingController;
  final VoidCallback onFilterClicked;
  final void Function(String text) onSearchItemSelected;
  final void Function(String text) onSearchTextChanged;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorTheme.navBackground,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0.1, 0.1),
            blurRadius: 0.5,
            color: context.colorTheme.shadow,
          )
        ],
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PinnedSearchHeader(
              backgroundColor: context.colorTheme.navBackground,
              padding: const EdgeInsets.only(bottom: 12, left: 12),
              height: 54,
              bloc: quickSearchBloc,
              onSelect: onSearchItemSelected,
              onTextChanged: onSearchTextChanged,
              textController: textEditingController,
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: onFilterClicked,
            child: Container(
              height: 56,
              margin: const EdgeInsets.only(bottom: 12, right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                FluentIcons.filter_12_filled,
                color: context.colorTheme.onTertiaryContainer,
                size: 36,
              ),
            ),
          )
        ],
      ),
    );
  }
}
