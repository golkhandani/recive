import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/core/components/suggestion_form_field.dart';
import 'package:recive/shared/constants/ui_constants.dart';

class AsyncSearchBar extends HookWidget {
  const AsyncSearchBar({
    super.key,
    this.constraints = const BoxConstraints(
      maxHeight: 48,
      minHeight: 48,
      maxWidth: 600,
      minWidth: 400,
    ),
    this.hintText = 'Quick Search',
    this.controller,
    this.radius = kRadius,
    this.backgroundColor = Colors.white,
    this.hightlightColor = Colors.transparent,
    this.boxBorder,
    this.suffix,
    this.onTextChanged,
    required this.itemBuilder,
    this.textStyle,
    this.hintStyle,
    this.suggestions = const [],
    this.isLoading = false,
    this.isSelected = false,
  });
  final BoxConstraints constraints;
  final String hintText;
  final TextEditingController? controller;
  final double radius;
  final Color backgroundColor;
  final Color hightlightColor;
  final BoxBorder? boxBorder;
  final Widget? suffix;
  final void Function(String, {bool selected})? onTextChanged;
  final Widget Function(BuildContext, String, int)? itemBuilder;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  final List<String> suggestions;
  final bool isLoading;
  final bool isSelected;

  BoxBorder get _boxBorder => boxBorder ?? kBoxBorder;

  @override
  Widget build(BuildContext context) {
    print("EQWEQWEQW -> ${backgroundColor} - ${textStyle?.color}");
    final textEditingController = controller ?? useTextEditingController();
    Timer? debounce;
    Future<void> onChanged(String value, {bool selected = false}) async {
      if (debounce?.isActive ?? false) debounce?.cancel();

      debounce = Timer(const Duration(milliseconds: 500), () async {
        onTextChanged?.call(value, selected: selected);
      });
    }

    final isVisible = (suggestions.isNotEmpty || isLoading) && !isSelected;

    return SuggestionFormField<String>(
      inputBackgroundColor: backgroundColor,
      controller: textEditingController,
      width: double.infinity,
      hint: hintText,
      margin: EdgeInsets.zero,
      height: constraints.minHeight,
      borderRadius: BorderRadius.circular(radius),
      textStyle: textStyle,
      hintStyle: hintStyle,
      border: _boxBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      dropDownItems: suggestions,
      dropDownBackgroundColor: backgroundColor,
      isVisible: isVisible,
      dropDownHeight: suggestions.isNotEmpty
          ? min(200, suggestions.length * 48 + 24)
          : 48 + 24,
      dropDownItemsBuilder: (context, dropdown, items) {
        if (items == null) {
          return const SizedBox();
        }
        final child = ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final wid = Material(
              color: Colors.transparent,
              child: InkWell(
                hoverColor: hightlightColor,
                splashColor: hightlightColor,
                highlightColor: hightlightColor,
                enableFeedback: true,
                onTap: () {
                  textEditingController.text = item;
                  textEditingController.selection =
                      TextSelection.collapsed(offset: item.length);
                  onChanged(item, selected: true);
                },
                child: itemBuilder?.call(context, item, index),
              ),
            );
            return wid;
          },
        );

        return Container(
          alignment: Alignment.topCenter,
          color: Colors.transparent,
          child: child,
        );
      },
      isLoading: isLoading, // isLoading.value,
      dropDownLoadingBuilder: (context) {
        return kSimpleLoading;
      },
      isDropDownLoading: isLoading, // isLoading.value,
      onChanged: onChanged,
      suffix: suffix,
    );
  }
}
