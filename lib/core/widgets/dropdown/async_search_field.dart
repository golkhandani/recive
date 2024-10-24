import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AsyncSearchField<T> extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final List<DropdownMenuEntry<T>> items;
  final void Function(String) onChanged;
  final TextEditingController controller;
  final bool isLoading;
  final bool isEnabled;
  const AsyncSearchField({
    super.key,
    this.labelText,
    this.hintText,
    required this.items,
    required this.onChanged,
    required this.controller,
    required this.isLoading,
    required this.isEnabled,
  });

  @override
  State<AsyncSearchField<T>> createState() => _AsyncSearchFieldState<T>();
}

class _AsyncSearchFieldState<T> extends State<AsyncSearchField<T>> {
  bool canCleanup = false;
  String text = '';
  _onChange() {
    final val = widget.controller.text;
    if (text != val) widget.onChanged(val);
    setState(() {
      text = val;
      canCleanup = val.isNotEmpty;
    });
  }

  @override
  void initState() {
    widget.controller.addListener(_onChange);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      // maxHeight: 48,
      child: TextField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        controller: widget.controller,
        enabled: widget.isEnabled,
        style: widget.isEnabled
            ? context.typographyTheme.bodyMedium.onSurface.textStyle
            : context.typographyTheme.bodyMedium.onSurface.textStyle,
        decoration: context.themeData.inputDecoration.copyWith(
          hintStyle: context.typographyTheme.bodyMedium.onSurface.textStyle,
          hintText: widget.hintText,
          border: const OutlineInputBorder(),
          suffixIcon: canCleanup
              ? GestureDetector(
                  onTap: () => widget.controller.clear(),
                  child: const Icon(Icons.close),
                )
              : null,
        ),
      ),
    );
  }
}
