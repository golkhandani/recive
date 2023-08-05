import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/async_search_bar.dart';
import 'package:recive/features/featured_page/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/features/notification/notification_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';

class QuickSearchHeader extends HookWidget {
  const QuickSearchHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
    final navigationService = locator.get<NavigationService>();
    Timer? debounce;
    final bloc = useBloc<QuickSearchHeaderBloc>();
    final state = useBlocBuilder(bloc);
    final textEditingController = useTextEditingController();

    useEffect(() {
      textEditingController.text = state.query;
      return () {
        debounce?.cancel();
      };
    }, []);

    Future<void> onChangeList(String value, {bool selected = false}) async {
      if (debounce?.isActive ?? false) debounce?.cancel();

      debounce = Timer(const Duration(milliseconds: 500), () async {
        if (selected) {
          textEditingController.text = value;
          bloc.add(QuickSearchHeaderEvent.select(selected: value));
          navigationService.navigateTo(NotificationScreen.name);
        } else {
          bloc.add(QuickSearchHeaderEvent.search(query: value));
        }
      });
    }

    return Container(
      color: context.theme.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search what you looking for!",
            style: context.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          AsyncSearchBar(
            controller: textEditingController,
            backgroundColor: context.schema.primaryContainer,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: context.schema.onPrimaryContainer.withOpacity(0.7),
                ),
            textStyle: textStyle,
            itemBuilder: (_, item, index) => Container(
              height: 48,
              // color: Colors.green[((index % 10) + 1) * 100],
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item,
                    style: textStyle,
                  )),
            ),
            onTextChanged: onChangeList,
            suggestions: state.suggestions,
            isLoading: state.isLoading,
            isSelected: state.isSelected,
            suffix: Material(
              borderRadius: BorderRadius.zero,
              color: context.schema.primaryContainer,
              child: InkWell(
                onTap: () {},
                splashColor: context.schema.secondary,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: Icon(
                    Icons.search,
                    size: 32,
                    color: context.schema.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
