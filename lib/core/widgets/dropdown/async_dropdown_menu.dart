import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/dropdown/raw_custom_dropdown.dart';
import 'package:flutter/material.dart';

class AsyncDropdownMenu<T> extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final List<DropdownMenuEntry<T>> items;
  final void Function(String) onChanged;
  final void Function(T) onSelected;
  final TextEditingController controller;
  final bool isLoading;
  final bool isEnabled;
  const AsyncDropdownMenu({
    super.key,
    this.labelText,
    this.hintText,
    required this.items,
    required this.onChanged,
    required this.controller,
    required this.isLoading,
    required this.onSelected,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return RawDropdownMenu<T>(
      requestFocusOnTap: true,
      enabled: isEnabled,
      hintText: hintText,
      isLoadingEntries: isLoading,
      minCharCount: 0,
      onChanged: onChanged,
      onSelected: (value) => {
        if (value != null) {onSelected.call(value)}
      },
      expandedInsets: EdgeInsets.zero,
      controller: controller,
      label: labelText != null ? Text(labelText!) : null,
      textStyle: isEnabled
          ? context.typographyTheme.bodyMedium.onSurface.textStyle
          : context.typographyTheme.bodyMedium.onSurface.textStyle,
      trailingIcon: null,
      inputDecorationTheme: context.themeData.inputDecorationTheme.copyWith(
        hintStyle: context.typographyTheme.bodyMedium.onSurface.textStyle,
      ),
      menuStyle: MenuStyle(
        maximumSize: const WidgetStatePropertyAll(
          Size(double.infinity, 240),
        ),
        surfaceTintColor: const WidgetStatePropertyAll(
          Colors.transparent,
        ),
        backgroundColor: WidgetStatePropertyAll(
          context.colorTheme.primaryContainer,
        ),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      dropdownMenuEntries: items,
    );
  }
}
