import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/dropdown/raw_custom_dropdown.dart';
import 'package:flutter/material.dart';

class SyncDropdownMenu<T> extends StatelessWidget {
  final String labelText;
  final List<DropdownMenuEntry<T>> items;
  final T? selectedItem;
  final void Function(T) onSelected;
  final bool isEnabled;
  const SyncDropdownMenu({
    super.key,
    required this.labelText,
    required this.selectedItem,
    required this.items,
    required this.onSelected,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return RawDropdownMenu<T>(
      requestFocusOnTap: false,
      enableFilter: false,
      enableSearch: false,
      enabled: isEnabled,
      expandedInsets: EdgeInsets.zero,
      minCharCount: -1,
      initialSelection: selectedItem,
      onSelected: (value) => {
        if (value != null) {onSelected.call(value)}
      },
      label: Text(labelText),
      textStyle: isEnabled
          ? null
          : context.typographyTheme.hint
              .copyWith(
                fontSize: context.typographyTheme.bodyLarge.textStyle.fontSize,
              )
              .textStyle,
      inputDecorationTheme: context.mrzgTheme.data.inputDecorationTheme,
      menuStyle: MenuStyle(
        maximumSize: const WidgetStatePropertyAll(
          Size(double.infinity, 240),
        ),
        surfaceTintColor: const WidgetStatePropertyAll(
          Colors.transparent,
        ),
        backgroundColor: WidgetStatePropertyAll(
          context.colorTheme.navBackground,
        ),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      dropdownMenuEntries: items,
    );
  }
}
