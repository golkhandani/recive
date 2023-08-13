import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/async_search_bar.dart';
import 'package:recive/features/notification/notification_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';

import 'bloc/quick_search_header_bloc.dart';

class QuickSearchHeader extends HookWidget {
  final void Function(String)? onSelect;
  final void Function(String)? onTextChanged;
  final TextEditingController? textController;
  const QuickSearchHeader({
    super.key,
    required this.onSelect,
    required this.onTextChanged,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
    Timer? debounce;
    final bloc = useBloc<QuickSearchHeaderBloc>();
    final state = useBlocBuilder(bloc);
    final textEditingController = textController ?? useTextEditingController();

    textEditingController.addListener(() {
      print("hiiiii");
    });

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
          onSelect?.call(value);
          // navigationService.navigateTo(NotificationScreen.name);
        } else {
          bloc.add(QuickSearchHeaderEvent.search(query: value));
          onTextChanged?.call(value);
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

class PinnedSearchHeader extends StatefulHookWidget {
  final void Function(String)? onSelect;
  final void Function(String)? onTextChanged;
  final TextEditingController? textController;
  final double height;
  final EdgeInsets padding;

  const PinnedSearchHeader({
    super.key,
    required this.onSelect,
    required this.onTextChanged,
    required this.textController,
    required this.height,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<PinnedSearchHeader> createState() => _PinnedSearchHeaderState();
}

class _PinnedSearchHeaderState extends State<PinnedSearchHeader> {
  @override
  Widget build(BuildContext context) {
    final textStyle =
        context.textTheme.bodyMedium!.copyWith(color: Colors.white);
    Timer? debounce;
    final bloc = useBloc<QuickSearchHeaderBloc>();
    final state = useBlocBuilder(bloc);
    final textEditingController =
        widget.textController ?? useTextEditingController();

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
          widget.onSelect?.call(value);
        } else {
          bloc.add(QuickSearchHeaderEvent.search(query: value));
          widget.onTextChanged?.call(value);
        }
      });
    }

    return Container(
      color: context.theme.primaryColor,
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AsyncSearchBar(
            constraints: BoxConstraints(minHeight: widget.height),
            controller: textEditingController,
            backgroundColor: context.schema.primaryContainer,
            hintText: "Search what you looking for!",
            hintStyle: textStyle.copyWith(
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
