import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

Map<ShortcutActivator, Intent> _kMenuTraversalShortcuts = <ShortcutActivator, Intent>{
  LogicalKeySet(LogicalKeyboardKey.arrowUp): const _ArrowUpIntent(),
  LogicalKeySet(LogicalKeyboardKey.arrowDown): const _ArrowDownIntent(),
};

const double _kMinimumWidth = 112.0;

const double _kDefaultHorizontalPadding = 12.0;

/// A dropdown menu that can be opened from a [TextField]. The selected
/// menu item is displayed in that field.
///
/// This widget is used to help people make a choice from a menu and put the
/// selected item into the text input field. People can also filter the list based
/// on the text input or search one item in the menu list.
///
/// The menu is composed of a list of [DropdownMenuEntry]s. People can provide information,
/// such as: label, leading icon or trailing icon for each entry. The [TextField]
/// will be updated based on the selection from the menu entries. The text field
/// will stay empty if the selected entry is disabled.
///
/// The dropdown menu can be traversed by pressing the up or down key. During the
/// process, the corresponding item will be highlighted and the text field will be updated.
/// Disabled items will be skipped during traversal.
///
/// The menu can be scrollable if not all items in the list are displayed at once.
///
/// {@tool dartpad}
/// This sample shows how to display outlined [DropdownMenu] and filled [DropdownMenu].
///
/// ** See code in examples/api/lib/material/dropdown_menu/dropdown_menu.0.dart **
/// {@end-tool}
///
/// See also:
///
/// * [MenuAnchor], which is a widget used to mark the "anchor" for a set of submenus.
///   The [DropdownMenu] uses a [TextField] as the "anchor".
/// * [TextField], which is a text input widget that uses an [InputDecoration].
/// * [DropdownMenuEntry], which is used to build the [MenuItemButton] in the [DropdownMenu] list.
class RawDropdownMenu<T> extends StatefulWidget {
  /// Creates a const [DropdownMenu].
  ///
  /// The leading and trailing icons in the text field can be customized by using
  /// [leadingIcon], [trailingIcon] and [selectedTrailingIcon] properties. They are
  /// passed down to the [InputDecoration] properties, and will override values
  /// in the [InputDecoration.prefixIcon] and [InputDecoration.suffixIcon].
  ///
  /// Except leading and trailing icons, the text field can be configured by the
  /// [InputDecorationTheme] property. The menu can be configured by the [menuStyle].
  const RawDropdownMenu({
    super.key,
    this.enabled = true,
    this.isLoadingEntries = false,
    this.minCharCount = 3,
    this.searchDelay = const Duration(milliseconds: 1000),
    this.onChanged,
    this.width,
    this.menuHeight,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.selectedTrailingIcon,
    this.enableFilter = false,
    this.enableSearch = true,
    this.textStyle,
    this.inputDecorationTheme,
    this.menuStyle,
    this.controller,
    this.initialSelection,
    this.onSelected,
    this.requestFocusOnTap,
    this.expandedInsets,
    required this.dropdownMenuEntries,
  });

  /// Determine if the [DropdownMenu] is enabled.
  ///
  /// Defaults to true.
  final bool enabled;

  final bool isLoadingEntries;
  final int minCharCount;
  final void Function(String text)? onChanged;
  final Duration searchDelay;

  /// Determine the width of the [DropdownMenu].
  ///
  /// If this is null, the width of the [DropdownMenu] will be the same as the width of the widest
  /// menu item plus the width of the leading/trailing icon.
  final double? width;

  /// Determine the height of the menu.
  ///
  /// If this is null, the menu will display as many items as possible on the screen.
  final double? menuHeight;

  /// An optional Icon at the front of the text input field.
  ///
  /// Defaults to null. If this is not null, the menu items will have extra paddings to be aligned
  /// with the text in the text field.
  final Widget? leadingIcon;

  /// An optional icon at the end of the text field.
  ///
  /// Defaults to an [Icon] with [Icons.arrow_drop_down].
  final Widget? trailingIcon;

  /// Optional widget that describes the input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text may be entered in the input field). When the input field receives
  /// focus (or if the field is non-empty), the label moves above, either
  /// vertically adjacent to, or to the center of the input field.
  ///
  /// Defaults to null.
  final Widget? label;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// Defaults to null;
  final String? hintText;

  /// Text that provides context about the [DropdownMenu]'s value, such
  /// as how the value will be used.
  ///
  /// If non-null, the text is displayed below the input field, in
  /// the same location as [errorText]. If a non-null [errorText] value is
  /// specified then the helper text is not shown.
  ///
  /// Defaults to null;
  ///
  /// See also:
  ///
  /// * [InputDecoration.helperText], which is the text that provides context about the [InputDecorator.child]'s value.
  final String? helperText;

  /// Text that appears below the input field and the border to show the error message.
  ///
  /// If non-null, the border's color animates to red and the [helperText] is not shown.
  ///
  /// Defaults to null;
  ///
  /// See also:
  ///
  /// * [InputDecoration.errorText], which is the text that appears below the [InputDecorator.child] and the border.
  final String? errorText;

  /// An optional icon at the end of the text field to indicate that the text
  /// field is pressed.
  ///
  /// Defaults to an [Icon] with [Icons.arrow_drop_up].
  final Widget? selectedTrailingIcon;

  /// Determine if the menu list can be filtered by the text input.
  ///
  /// Defaults to false.
  final bool enableFilter;

  /// Determine if the first item that matches the text input can be highlighted.
  ///
  /// Defaults to true as the search function could be commonly used.
  final bool enableSearch;

  /// The text style for the [TextField] of the [DropdownMenu];
  ///
  /// Defaults to the overall theme's [TextTheme.bodyLarge]
  /// if the dropdown menu theme's value is null.
  final TextStyle? textStyle;

  /// Defines the default appearance of [InputDecoration] to show around the text field.
  ///
  /// By default, shows a outlined text field.
  final InputDecorationTheme? inputDecorationTheme;

  /// The [MenuStyle] that defines the visual attributes of the menu.
  ///
  /// The default width of the menu is set to the width of the text field.
  final MenuStyle? menuStyle;

  /// Controls the text being edited or selected in the menu.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The value used to for an initial selection.
  ///
  /// Defaults to null.
  final T? initialSelection;

  /// The callback is called when a selection is made.
  ///
  /// Defaults to null. If null, only the text field is updated.
  final ValueChanged<T?>? onSelected;

  /// Determine if the dropdown button requests focus and the on-screen virtual
  /// keyboard is shown in response to a touch event.
  ///
  /// By default, on mobile platforms, tapping on the text field and opening
  /// the menu will not cause a focus request and the virtual keyboard will not
  /// appear. The default behavior for desktop platforms is for the dropdown to
  /// take the focus.
  ///
  /// Defaults to null. Setting this field to true or false, rather than allowing
  /// the implementation to choose based on the platform, can be useful for
  /// applications that want to override the default behavior.
  final bool? requestFocusOnTap;

  /// Descriptions of the menu items in the [DropdownMenu].
  ///
  /// This is a required parameter. It is recommended that at least one [DropdownMenuEntry]
  /// is provided. If this is an empty list, the menu will be empty and only
  /// contain space for padding.
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  /// Defines the menu text field's width to be equal to its parent's width
  /// plus the horizontal width of the specified insets.
  ///
  /// If this property is null, the width of the text field will be determined
  /// by the width of menu items or [DropdownMenu.width]. If this property is not null,
  /// the text field's width will match the parent's width plus the specified insets.
  /// If the value of this property is [EdgeInsets.zero], the width of the text field will be the same
  /// as its parent's width.
  ///
  /// The [expandedInsets]' top and bottom are ignored, only its left and right
  /// properties are used.
  ///
  /// Defaults to null.
  final EdgeInsets? expandedInsets;

  @override
  State<RawDropdownMenu<T>> createState() => _RawDropdownMenuState<T>();
}

class _RawDropdownMenuState<T> extends State<RawDropdownMenu<T>> {
  final GlobalKey _anchorKey = GlobalKey();
  final GlobalKey _leadingKey = GlobalKey();
  late List<GlobalKey> buttonItemKeys;
  final MenuController _controller = MenuController();
  late final TextEditingController _textEditingController;
  late bool _enableFilter;
  late List<DropdownMenuEntry<T>> filteredEntries;
  List<Widget>? _initialMenu;
  int? currentHighlight;
  double? leadingPadding;
  bool _menuHasEnabledItem = false;
  bool _isLoadingEntries = false;
  List<DropdownMenuEntry<T>> _dropdownMenuEntries = [];

  Timer? debounce;

  DropdownMenuEntry? _selectedEntry;
  String? _lastText;

  Future<void> onChanged() async {
    if (_textEditingController.text.length <= widget.minCharCount) {
      setState(() {
        _dropdownMenuEntries = [];
        filteredEntries = [];
      });
      return;
    }

    if (_selectedEntry != null && _textEditingController.text == _selectedEntry?.label) {
      return;
    }

    if (_lastText != null && _textEditingController.text == _lastText) {
      return;
    }

    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }

    debounce = Timer(widget.searchDelay, () {
      setState(() {
        _isLoadingEntries = true;
        _dropdownMenuEntries = [];
        _lastText = _textEditingController.text;
      });
      widget.onChanged?.call(_textEditingController.text);
      setState(() {
        _isLoadingEntries = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ?? TextEditingController();
    _enableFilter = widget.enableFilter;
    _dropdownMenuEntries = widget.dropdownMenuEntries;
    filteredEntries = _dropdownMenuEntries;
    _isLoadingEntries = widget.isLoadingEntries;
    buttonItemKeys =
        List<GlobalKey>.generate(filteredEntries.length, (int index) => GlobalKey());
    _menuHasEnabledItem = filteredEntries.any((DropdownMenuEntry<T> entry) => entry.enabled);

    final int index = filteredEntries
        .indexWhere((DropdownMenuEntry<T> entry) => entry.value == widget.initialSelection);
    if (index != -1) {
      _textEditingController.text = filteredEntries[index].label;
      _textEditingController.selection =
          TextSelection.collapsed(offset: _textEditingController.text.length);
    }

    _textEditingController.addListener(onChanged);
    refreshLeadingPadding();
  }

  @override
  void didUpdateWidget(RawDropdownMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoadingEntries = widget.isLoadingEntries;
    if (oldWidget.enableSearch != widget.enableSearch) {
      if (!widget.enableSearch) {
        currentHighlight = null;
      }
    }
    if (oldWidget.dropdownMenuEntries != widget.dropdownMenuEntries) {
      currentHighlight = null;
      _dropdownMenuEntries = widget.dropdownMenuEntries;
      filteredEntries = _dropdownMenuEntries;
      buttonItemKeys =
          List<GlobalKey>.generate(filteredEntries.length, (int index) => GlobalKey());
      _menuHasEnabledItem =
          filteredEntries.any((DropdownMenuEntry<T> entry) => entry.enabled);
    }

    if (oldWidget.leadingIcon != widget.leadingIcon) {
      refreshLeadingPadding();
    }
    if (oldWidget.initialSelection != widget.initialSelection) {
      final int index = filteredEntries
          .indexWhere((DropdownMenuEntry<T> entry) => entry.value == widget.initialSelection);
      if (index != -1) {
        _textEditingController.text = filteredEntries[index].label;
        _textEditingController.selection =
            TextSelection.collapsed(offset: _textEditingController.text.length);
      }
    }
  }

  bool canRequestFocus() {
    if (widget.requestFocusOnTap != null) {
      return widget.requestFocusOnTap!;
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return false;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
    }
  }

  void refreshLeadingPadding() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        leadingPadding = getWidth(_leadingKey);
      });
    });
  }

  void scrollToHighlight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext? highlightContext = buttonItemKeys[currentHighlight!].currentContext;
      if (highlightContext != null) {
        Scrollable.ensureVisible(highlightContext);
      }
    });
  }

  double? getWidth(GlobalKey key) {
    final BuildContext? context = key.currentContext;
    if (context != null) {
      final RenderBox box = context.findRenderObject()! as RenderBox;
      return box.hasSize ? box.size.width : null;
    }
    return null;
  }

  List<DropdownMenuEntry<T>> filter(
      List<DropdownMenuEntry<T>> entries, TextEditingController textEditingController) {
    final String filterText = textEditingController.text.toLowerCase();
    return entries
        .where((DropdownMenuEntry<T> entry) => entry.label.toLowerCase().contains(filterText))
        .toList();
  }

  int? search(
      List<DropdownMenuEntry<T>> entries, TextEditingController textEditingController) {
    final String searchText = textEditingController.value.text.toLowerCase();
    if (searchText.isEmpty) {
      return null;
    }
    final int index = entries.indexWhere(
        (DropdownMenuEntry<T> entry) => entry.label.toLowerCase().contains(searchText));

    return index != -1 ? index : null;
  }

  List<Widget> _buildButtons(
    List<DropdownMenuEntry<T>> filteredEntries,
    TextEditingController textEditingController,
    TextDirection textDirection, {
    int? focusedIndex,
    bool enableScrollToHighlight = true,
  }) {
    final List<Widget> result = <Widget>[];

    if (_isLoadingEntries) {
      result.add(Container(
        width: getWidth(_anchorKey),
        padding: const EdgeInsets.all(8.0),
        child: const Center(child: CircularProgressIndicator()),
      ));
      return result;
    }
    for (int i = 0; i < filteredEntries.length; i++) {
      final DropdownMenuEntry<T> entry = filteredEntries[i];

      final double padding = entry.leadingIcon == null ? (leadingPadding ?? 0) : 0;
      final ButtonStyle defaultStyle;
      switch (textDirection) {
        case TextDirection.rtl:
          defaultStyle = MenuItemButton.styleFrom(
            padding: EdgeInsets.only(right: padding),
          );
        case TextDirection.ltr:
          defaultStyle = MenuItemButton.styleFrom(
            padding: EdgeInsets.only(left: padding, right: _kDefaultHorizontalPadding),
          );
      }

      ButtonStyle effectiveStyle = entry.style ?? defaultStyle;
      final Color focusedBackgroundColor =
          effectiveStyle.foregroundColor?.resolve(<WidgetState>{WidgetState.focused}) ??
              Theme.of(context).colorScheme.onSurface;

      // Simulate the focused state because the text field should always be focused
      // during traversal. If the menu item has a custom foreground color, the "focused"
      // color will also change to foregroundColor.withOpacity(0.12).
      effectiveStyle = entry.enabled && i == focusedIndex
          ? effectiveStyle.copyWith(
              backgroundColor:
                  WidgetStatePropertyAll<Color>(focusedBackgroundColor.withOpacity(0.12)))
          : effectiveStyle;

      final Widget menuItemButton = SizedBox(
        width: getWidth(_anchorKey),
        child: MenuItemButton(
          key: enableScrollToHighlight ? buttonItemKeys[i] : null,
          style: effectiveStyle,
          leadingIcon: entry.leadingIcon,
          trailingIcon: entry.trailingIcon,
          onPressed: entry.enabled
              ? () {
                  _selectedEntry = entry;
                  textEditingController.text = entry.label;
                  textEditingController.selection = TextSelection.collapsed(
                    offset: textEditingController.text.length,
                  );
                  currentHighlight = widget.enableSearch ? i : null;
                  _dropdownMenuEntries = [];
                  widget.onSelected?.call(entry.value);
                }
              : null,
          requestFocusOnHover: false,
          child: entry.labelWidget ??
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  entry.label,
                  style: widget.textStyle,
                ),
              ),
        ),
      );
      result.add(menuItemButton);
    }

    return result;
  }

  void handleUpKeyInvoke(_) => setState(() {
        if (!_menuHasEnabledItem || !_controller.isOpen) {
          return;
        }
        _enableFilter = false;
        currentHighlight ??= 0;
        currentHighlight = (currentHighlight! - 1) % filteredEntries.length;
        while (!filteredEntries[currentHighlight!].enabled) {
          currentHighlight = (currentHighlight! - 1) % filteredEntries.length;
        }
        final String currentLabel = filteredEntries[currentHighlight!].label;
        _textEditingController.text = currentLabel;
        _textEditingController.selection =
            TextSelection.collapsed(offset: _textEditingController.text.length);
      });

  void handleDownKeyInvoke(_) => setState(() {
        if (!_menuHasEnabledItem || !_controller.isOpen) {
          return;
        }
        _enableFilter = false;
        currentHighlight ??= -1;
        currentHighlight = (currentHighlight! + 1) % filteredEntries.length;
        while (!filteredEntries[currentHighlight!].enabled) {
          currentHighlight = (currentHighlight! + 1) % filteredEntries.length;
        }
        final String currentLabel = filteredEntries[currentHighlight!].label;
        _textEditingController.text = currentLabel;
        _textEditingController.selection =
            TextSelection.collapsed(offset: _textEditingController.text.length);
      });

  void openController(MenuController controller, {bool force = false}) {
    if (_isLoadingEntries) {
      controller.open();
      return;
    }
    if (_textEditingController.text.length <= widget.minCharCount) {
      controller.close();
    } else {
      controller.open();
    }
    return;
  }

  void handlePressed(MenuController controller) {
    if (controller.isOpen) {
      currentHighlight = null;
      controller.close();
    } else {
      // close to open
      if (_textEditingController.text.isNotEmpty) {
        _enableFilter = false;
      }
      openController(controller);
    }
    setState(() {});
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _textEditingController.dispose();
    }
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    _initialMenu ??= _buildButtons(
      widget.dropdownMenuEntries,
      _textEditingController,
      textDirection,
      enableScrollToHighlight: false,
    );
    final DropdownMenuThemeData theme = DropdownMenuTheme.of(context);
    final DropdownMenuThemeData defaults = _DropdownMenuDefaultsM3(context);

    if (_enableFilter) {
      filteredEntries = filter(widget.dropdownMenuEntries, _textEditingController);
    }

    if (widget.enableSearch) {
      currentHighlight = search(filteredEntries, _textEditingController);
      if (currentHighlight != null) {
        scrollToHighlight();
      }
    }

    final List<Widget> menu = _buildButtons(
      filteredEntries,
      _textEditingController,
      textDirection,
      focusedIndex: currentHighlight,
    );

    final TextStyle? effectiveTextStyle =
        widget.textStyle ?? theme.textStyle ?? defaults.textStyle;

    MenuStyle? effectiveMenuStyle =
        widget.menuStyle ?? theme.menuStyle ?? defaults.menuStyle!;

    final double? anchorWidth = getWidth(_anchorKey);
    if (widget.width != null) {
      effectiveMenuStyle = effectiveMenuStyle.copyWith(
          minimumSize: WidgetStatePropertyAll<Size?>(Size(widget.width!, 0.0)));
    } else if (anchorWidth != null) {
      effectiveMenuStyle = effectiveMenuStyle.copyWith(
          minimumSize: WidgetStatePropertyAll<Size?>(Size(anchorWidth, 0.0)));
    }

    if (widget.menuHeight != null) {
      effectiveMenuStyle = effectiveMenuStyle.copyWith(
          maximumSize:
              WidgetStatePropertyAll<Size>(Size(double.infinity, widget.menuHeight!)));
    }
    final InputDecorationTheme effectiveInputDecorationTheme = widget.inputDecorationTheme ??
        theme.inputDecorationTheme ??
        defaults.inputDecorationTheme!;

    final MouseCursor effectiveMouseCursor =
        canRequestFocus() ? SystemMouseCursors.text : SystemMouseCursors.click;

    Widget menuAnchor = MenuAnchor(
      style: effectiveMenuStyle.copyWith(
        fixedSize: menu.isEmpty
            ? const WidgetStatePropertyAll(Size.zero)
            : effectiveMenuStyle.fixedSize,
      ),
      controller: _controller,
      menuChildren: menu,
      crossAxisUnconstrained: false,
      builder: (BuildContext context, MenuController controller, Widget? child) {
        assert(_initialMenu != null);
        final Widget trailingButton = Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
            isSelected: controller.isOpen,
            icon: widget.trailingIcon ?? const Icon(Icons.arrow_drop_down),
            selectedIcon: widget.selectedTrailingIcon ?? const Icon(Icons.arrow_drop_up),
            onPressed: () {
              handlePressed(controller);
            },
          ),
        );

        final Widget leadingButton = Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.leadingIcon ?? const SizedBox());

        final Widget textField = TextField(
            onTapOutside: (v) {
              FocusScope.of(context).unfocus();
            },
            key: _anchorKey,
            mouseCursor: effectiveMouseCursor,
            canRequestFocus: canRequestFocus(),
            enableInteractiveSelection: canRequestFocus(),
            textAlignVertical: TextAlignVertical.center,
            style: effectiveTextStyle,
            controller: _textEditingController,
            onEditingComplete: () {
              if (currentHighlight != null) {
                final DropdownMenuEntry<T> entry = filteredEntries[currentHighlight!];
                if (entry.enabled) {
                  _textEditingController.text = entry.label;
                  _textEditingController.selection =
                      TextSelection.collapsed(offset: _textEditingController.text.length);
                  widget.onSelected?.call(entry.value);
                }
              } else {
                widget.onSelected?.call(null);
              }
              if (!widget.enableSearch) {
                currentHighlight = null;
              }
              controller.close();
            },
            onTap: () {
              handlePressed(controller);
            },
            onChanged: (String text) {
              setState(() {
                filteredEntries = widget.dropdownMenuEntries;
                _enableFilter = widget.enableFilter;
              });
              openController(controller);
            },
            decoration: InputDecoration(
              enabled: widget.enabled,
              label: widget.label,
              hintText: widget.hintText,
              helperText: widget.helperText,
              errorText: widget.errorText,
              prefixIcon: widget.leadingIcon != null
                  ? Container(key: _leadingKey, child: widget.leadingIcon)
                  : null,
              suffixIcon: _isLoadingEntries ||
                      menu.isEmpty ||
                      _textEditingController.text.length <= widget.minCharCount
                  ? null
                  : trailingButton,
            ).applyDefaults(effectiveInputDecorationTheme));

        if (widget.expandedInsets != null) {
          // If [expandedInsets] is not null, the width of the text field should depend
          // on its parent width. So we don't need to use `_DropdownMenuBody` to
          // calculate the children's width.
          return textField;
        }

        return _DropdownMenuBody(
          width: widget.width,
          children: <Widget>[
            textField,
            for (final Widget item in _initialMenu!) item,
            trailingButton,
            leadingButton,
          ],
        );
      },
    );

    if (widget.expandedInsets != null) {
      menuAnchor = Container(
        alignment: AlignmentDirectional.topStart,
        // padding: EdgeInsets
        //     .zero, // widget.expandedInsets?.copyWith(top: 0.0, bottom: 0.0),
        child: menuAnchor,
      );
    }

    return Shortcuts(
      shortcuts: _kMenuTraversalShortcuts,
      child: Actions(
        actions: <Type, Action<Intent>>{
          _ArrowUpIntent: CallbackAction<_ArrowUpIntent>(
            onInvoke: handleUpKeyInvoke,
          ),
          _ArrowDownIntent: CallbackAction<_ArrowDownIntent>(
            onInvoke: handleDownKeyInvoke,
          ),
        },
        child: menuAnchor,
      ),
    );
  }
}

class _ArrowUpIntent extends Intent {
  const _ArrowUpIntent();
}

class _ArrowDownIntent extends Intent {
  const _ArrowDownIntent();
}

class _DropdownMenuBody extends MultiChildRenderObjectWidget {
  const _DropdownMenuBody({
    super.children,
    this.width,
  });

  final double? width;

  @override
  _RenderDropdownMenuBody createRenderObject(BuildContext context) {
    return _RenderDropdownMenuBody(
      width: width,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderDropdownMenuBody renderObject) {
    renderObject.width = width;
  }
}

class _DropdownMenuBodyParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderDropdownMenuBody extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _DropdownMenuBodyParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _DropdownMenuBodyParentData> {
  _RenderDropdownMenuBody({
    double? width,
  }) : _width = width;

  double? get width => _width;
  double? _width;
  set width(double? value) {
    if (_width == value) {
      return;
    }
    _width = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _DropdownMenuBodyParentData) {
      child.parentData = _DropdownMenuBodyParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    double maxWidth = 0.0;
    double? maxHeight;
    RenderBox? child = firstChild;

    final BoxConstraints innerConstraints = BoxConstraints(
      maxWidth: width ?? computeMaxIntrinsicWidth(constraints.maxWidth),
      maxHeight: computeMaxIntrinsicHeight(constraints.maxHeight),
    );
    while (child != null) {
      if (child == firstChild) {
        child.layout(innerConstraints, parentUsesSize: true);
        maxHeight ??= child.size.height;
        final _DropdownMenuBodyParentData childParentData =
            child.parentData! as _DropdownMenuBodyParentData;
        assert(child.parentData == childParentData);
        child = childParentData.nextSibling;
        continue;
      }
      child.layout(innerConstraints, parentUsesSize: true);
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      childParentData.offset = Offset.zero;
      maxWidth = math.max(maxWidth, child.size.width);
      maxHeight ??= child.size.height;
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }

    assert(maxHeight != null);
    maxWidth = math.max(_kMinimumWidth, maxWidth);
    size = constraints.constrain(Size(width ?? maxWidth, maxHeight!));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final RenderBox? child = firstChild;
    if (child != null) {
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      context.paintChild(child, offset + childParentData.offset);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final BoxConstraints constraints = this.constraints;
    double maxWidth = 0.0;
    double? maxHeight;
    RenderBox? child = firstChild;
    final BoxConstraints innerConstraints = BoxConstraints(
      maxWidth: width ?? computeMaxIntrinsicWidth(constraints.maxWidth),
      maxHeight: computeMaxIntrinsicHeight(constraints.maxHeight),
    );

    while (child != null) {
      if (child == firstChild) {
        final Size childSize = child.getDryLayout(innerConstraints);
        maxHeight ??= childSize.height;
        final _DropdownMenuBodyParentData childParentData =
            child.parentData! as _DropdownMenuBodyParentData;
        assert(child.parentData == childParentData);
        child = childParentData.nextSibling;
        continue;
      }
      final Size childSize = child.getDryLayout(innerConstraints);
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      childParentData.offset = Offset.zero;
      maxWidth = math.max(maxWidth, childSize.width);
      maxHeight ??= childSize.height;
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }

    assert(maxHeight != null);
    maxWidth = math.max(_kMinimumWidth, maxWidth);
    return constraints.constrain(Size(width ?? maxWidth, maxHeight!));
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    RenderBox? child = firstChild;
    double width = 0;
    while (child != null) {
      if (child == firstChild) {
        final _DropdownMenuBodyParentData childParentData =
            child.parentData! as _DropdownMenuBodyParentData;
        child = childParentData.nextSibling;
        continue;
      }
      final double maxIntrinsicWidth = child.getMinIntrinsicWidth(height);
      if (child == lastChild) {
        width += maxIntrinsicWidth;
      }
      if (child == childBefore(lastChild!)) {
        width += maxIntrinsicWidth;
      }
      width = math.max(width, maxIntrinsicWidth);
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      child = childParentData.nextSibling;
    }

    return math.max(width, _kMinimumWidth);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    RenderBox? child = firstChild;
    double width = 0;
    while (child != null) {
      if (child == firstChild) {
        final _DropdownMenuBodyParentData childParentData =
            child.parentData! as _DropdownMenuBodyParentData;
        child = childParentData.nextSibling;
        continue;
      }
      final double maxIntrinsicWidth = child.getMaxIntrinsicWidth(height);
      // Add the width of leading Icon.
      if (child == lastChild) {
        width += maxIntrinsicWidth;
      }
      // Add the width of trailing Icon.
      if (child == childBefore(lastChild!)) {
        width += maxIntrinsicWidth;
      }
      width = math.max(width, maxIntrinsicWidth);
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      child = childParentData.nextSibling;
    }

    return math.max(width, _kMinimumWidth);
  }

  @override
  double computeMinIntrinsicHeight(double height) {
    final RenderBox? child = firstChild;
    double width = 0;
    if (child != null) {
      width = math.max(width, child.getMinIntrinsicHeight(height));
    }
    return width;
  }

  @override
  double computeMaxIntrinsicHeight(double height) {
    final RenderBox? child = firstChild;
    double width = 0;
    if (child != null) {
      width = math.max(width, child.getMaxIntrinsicHeight(height));
    }
    return width;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final RenderBox? child = firstChild;
    if (child != null) {
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }
}

// Hand coded defaults. These will be updated once we have tokens/spec.
class _DropdownMenuDefaultsM3 extends DropdownMenuThemeData {
  _DropdownMenuDefaultsM3(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);

  @override
  TextStyle? get textStyle => _theme.textTheme.bodyLarge;

  @override
  MenuStyle get menuStyle {
    return const MenuStyle(
      minimumSize: WidgetStatePropertyAll<Size>(Size(_kMinimumWidth, 0.0)),
      maximumSize: WidgetStatePropertyAll<Size>(Size.infinite),
      visualDensity: VisualDensity.standard,
    );
  }

  @override
  InputDecorationTheme get inputDecorationTheme {
    return const InputDecorationTheme(border: OutlineInputBorder());
  }
}
