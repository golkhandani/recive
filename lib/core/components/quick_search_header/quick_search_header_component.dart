import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

import 'package:recive/core/components/async_search_bar.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

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
          bloc.select(selected: value);
          onSelect?.call(value);
        } else {
          bloc.search(query: value);
          onTextChanged?.call(value);
        }
      });
    }

    return Container(
      color: context.colorTheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search what you looking for!",
            style: context.textTheme.titleTiny.style,
          ),
          const SizedBox(height: 8),
          AsyncSearchBar(
            controller: textEditingController,
            backgroundColor: context.colorTheme.primaryContainer,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: context.colorTheme.onPrimaryContainer.withOpacity(0.7),
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
              color: context.colorTheme.primaryContainer,
              child: InkWell(
                onTap: () {},
                splashColor: context.colorTheme.secondary,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: Icon(
                    Icons.search,
                    size: 32,
                    color: context.colorTheme.onPrimaryContainer,
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

class PinnedSearchHeader extends HookWidget {
  final void Function(String)? onSelect;
  final void Function(String)? onTextChanged;
  final TextEditingController? textController;
  final QuickSearchHeaderBloc bloc;
  final double height;
  final EdgeInsets padding;
  final Color? backgroundColor;

  const PinnedSearchHeader({
    super.key,
    required this.onSelect,
    required this.onTextChanged,
    required this.textController,
    required this.height,
    required this.bloc,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.bodyMedium.onTextFieldBackground.style;
    Timer? debounce;
    final state = useBlocBuilder(bloc);
    final textEditingController = textController ?? useTextEditingController();

    useEffect(() {
      textEditingController.text = state.query;
      return () {
        debounce?.cancel();
      };
    }, []);

    Future<void> onChangeList(String value, {bool selected = false}) async {
      if (debounce?.isActive ?? false) debounce?.cancel();

      if (selected) {
        onSelect?.call(value);
        textEditingController.text = value;
        bloc.select(selected: value);
      } else {
        debounce = Timer(const Duration(milliseconds: 500), () async {
          onTextChanged?.call(value);
          bloc.search(query: value);
        });
      }
    }

    final bg = backgroundColor ?? context.colorTheme.tertiaryContainer;

    return Container(
      color: bg,
      padding: padding,
      child: AsyncSearchBar(
        constraints: BoxConstraints(minHeight: height),
        controller: textEditingController,
        backgroundColor: context.colorTheme.textFieldBackground,
        boxBorder: Border.all(color: context.colorTheme.textFieldBackground),
        hintText: "Search what you're looking for!",
        hintStyle: textStyle.withColor(textStyle.color!.withOpacity(0.7)),
        textStyle:
            textStyle.withColor(context.colorTheme.onTextFieldBackground),
        itemBuilder: (_, item, index) {
          print("EWWWWWWWWW ->>>>> ${textStyle.color}");
          return Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item,
                  style: textStyle,
                )),
          );
        },
        onTextChanged: onChangeList,
        suggestions: state.suggestions,
        isLoading: state.isLoading,
        isSelected: state.isSelected,
        suffix: Material(
          borderRadius: BorderRadius.zero,
          borderOnForeground: true,
          color: context.colorTheme.textFieldBackground,
          child: Row(
            children: [
              if (textEditingController.text.isNotEmpty) ...[
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    textEditingController.clear();
                    onTextChanged?.call('');
                  },
                  splashColor: context.colorTheme.textFieldBackground,
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: context.colorTheme.onTextFieldBackground
                          .withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
