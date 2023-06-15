import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/async_search_bar.dart';
import 'package:recive/features/featured/quick_search_header/bloc/quick_search_header_bloc.dart';
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
      print("state.query ${state.query}");
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
      color: Colors.black,
      padding: const EdgeInsets.all(8.0),
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
            backgroundColor: Colors.black,
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white54),
            textStyle: textStyle,
            itemBuilder: (_, item, index) => Container(
              height: 48,
              color: Colors.green[((index % 10) + 1) * 100],
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
              color: Colors.white,
              child: InkWell(
                onTap: () {},
                splashColor: Colors.grey,
                child: const SizedBox(
                  height: 48,
                  width: 48,
                  child: Icon(
                    Icons.search,
                    size: 32,
                    color: Colors.black,
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
