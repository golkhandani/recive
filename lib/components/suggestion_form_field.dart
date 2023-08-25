import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin ToggleVisibityMixin {
  toggleVisiblity();
}

class SuggestionFormField<T> extends StatefulWidget {
  final String? label;
  final TextStyle? labelStyle;
  final double labelGap;

  final String? text;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final bool disabled;
  final TextStyle? disabledStyle;
  final String? hint;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final Color? backgroundCursorColor;
  final double height;
  final double? width;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsets contentPadding;
  final EdgeInsets margin;
  final bool obscureText;
  final String obscuringCharacter;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;

  final bool isLoading;
  final bool isVisible;
  final bool isDropDown;
  final bool isDropDownLoading;
  final double dropDownGap;
  final double dropDownHeight;

  final List<T>? dropDownItems;
  final Widget Function(BuildContext, ToggleVisibityMixin, List<T>?)?
      dropDownItemsBuilder;
  final Widget Function(BuildContext)? dropDownLoadingBuilder;

  // style
  final BorderRadiusGeometry borderRadius;
  final BoxBorder? border;
  final Color? boxBackgroundColor;
  final Color? inputBackgroundColor;
  final Color? dropDownBackgroundColor;

  const SuggestionFormField({
    super.key,
    // label
    this.label,
    this.labelGap = 8,
    this.labelStyle,

    // text field
    this.text,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.disabled = false,
    this.disabledStyle,
    this.hint,
    this.hintStyle,
    this.controller,
    this.focusNode,
    this.cursorColor,
    this.backgroundCursorColor,
    this.height = 56,
    this.width,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.margin = const EdgeInsets.all(16),
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.inputFormatters,
    this.keyboardType,

    // functions
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.isLoading = false,
    this.isVisible = false,

    // custom sections
    this.prefix,
    this.suffix,
    this.dropDownGap = 8,
    this.dropDownHeight = 200,
    this.isDropDown = true,
    this.isDropDownLoading = false,
    this.dropDownItems,
    this.dropDownItemsBuilder,
    this.dropDownLoadingBuilder,

    // style
    this.borderRadius = BorderRadius.zero,
    this.border,
    this.boxBackgroundColor = Colors.transparent,
    this.inputBackgroundColor = Colors.transparent,
    this.dropDownBackgroundColor = Colors.transparent,
  });

  @override
  State<SuggestionFormField> createState() => _SuggestionFormFieldState<T>();
}

class _SuggestionFormFieldState<T> extends State<SuggestionFormField<T>>
    with SingleTickerProviderStateMixin, ToggleVisibityMixin {
  // general
  final _textFieldKey = GlobalKey();
  final _layerLink = LayerLink();
  late final colorTheme = Theme.of(context);
  late final textTheme = Theme.of(context).textTheme;

  // label
  late final _labelStyle = widget.labelStyle ?? textTheme.labelMedium;

  // text field
  late final _controller = widget.controller ?? TextEditingController();
  late final _focusNode = widget.focusNode ?? FocusNode();
  late final _textStyle = widget.disabled
      ? (widget.disabledStyle ?? textTheme.bodyMedium!)
      : (widget.textStyle ?? textTheme.bodyMedium!);
  late final _hintStyle = widget.hintStyle ??
      textTheme.bodyMedium!.copyWith(
        color: colorTheme.hintColor,
      );

  late final _cursorColor = widget.cursorColor ?? colorTheme.primaryColor;
  late final _backgroundCursorColor =
      widget.backgroundCursorColor ?? colorTheme.primaryColor;
  late final _height = widget.height;
  late final _width = widget.width;

// calculations
  double get _possibleFontSize =>
      (_textStyle.fontSize ?? textTheme.bodyMedium!.fontSize!);
  late final _maxPossibleFontSize =
      (_height ~/ (_textStyle.height ?? _possibleFontSize / _height))
          .floorToDouble();
  double get maxPossibleFontSize =>
      _possibleFontSize * (_textStyle.height ?? 1) > _height
          ? _maxPossibleFontSize
          : _possibleFontSize;

  bool isEditingText = false;

  bool _hasOpenedOverlay = false;
  OverlayEntry? _overlayEntry;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _animation =
      Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1, curve: Curves.easeOutCubic),
    ),
  );

  bool get _shouldDraw => !_hasOpenedOverlay && widget.isVisible;
  @override
  void toggleVisiblity() {
    if (!_hasOpenedOverlay) {
      openOverlay();
    } else {
      closeOverlay();
    }
  }

  void openOverlay() {
    if (kDebugMode) {
      print(
          "_________________| openOverlay $_shouldDraw $_hasOpenedOverlay - ${widget.isVisible}");
    }
    if (_shouldDraw && widget.isVisible) {
      setState(() => _hasOpenedOverlay = true);
      _overlayEntry?.remove();
      _overlayEntry = null;
      createOverLay();
      if (_overlayEntry != null) {
        Overlay.of(context).insert(_overlayEntry!);
        _animationController.forward();
      }
    }
  }

  void closeOverlay() {
    if (!_shouldDraw) {
      _animationController.reverse().then((value) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
      setState(() {
        _hasOpenedOverlay = false;
      });
    }
  }

  bool isLoading = false;
  final _isLoading = ValueNotifier<bool>(false);
  final _items = ValueNotifier<List<T>>([]);

  void setupIsTextEditing() {
    isEditingText = _controller.text.isNotEmpty;
    _controller.addListener(() {
      setState(() {
        isLoading = true;
      });
      if (_controller.text.isEmpty) {
        setState(() {
          isEditingText = false;
        });
      } else {
        setState(() {
          isEditingText = true;
        });
      }
    });
  }

  void setupIsDropDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNode.hasFocus) {
        openOverlay();
      } else {
        closeOverlay();
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        openOverlay();
      } else {
        closeOverlay();
      }
    });
  }

  @override
  void initState() {
    _focusNode.unfocus();
    if (widget.text != null) {
      _controller.text = widget.text!;
    }

    _controller.addListener(() {
      final formState = _formKey.currentState;
      if (formState?.hasError ?? false) {
        formState?.reset();
      }
      formState?.didChange(_controller.text);
    });

    setupIsTextEditing();
    setupIsDropDown();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SuggestionFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDropDownLoading == widget.isDropDownLoading) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _isLoading.value = widget.isDropDownLoading;
      _items.value = widget.dropDownItems ?? [];
      if (widget.isVisible) {
        openOverlay();
      } else {
        closeOverlay();
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      // note if it's a higher level controller,
      // parent is responsible of handling it states
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormFieldState<String>>();

  void createOverLay() {
    if (_overlayEntry == null && _hasOpenedOverlay) {
      RenderBox innerRenderBox =
          _textFieldKey.currentContext!.findRenderObject() as RenderBox;
      final margin = widget.margin;
      _overlayEntry ??= OverlayEntry(
        builder: (context) => MouseRegion(
          opaque: false,
          child: GestureDetector(
            onTap: () => closeOverlay(),
            behavior: HitTestBehavior.translucent,
            child: Material(
              color: Colors.transparent,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(-margin.left, innerRenderBox.size.height),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizeTransition(
                    sizeFactor: _animation,
                    axis: Axis.vertical,
                    child: ValueListenableBuilder(
                        valueListenable: _items,
                        builder: (context, items, _) {
                          return ValueListenableBuilder<bool>(
                              valueListenable: _isLoading,
                              builder: (context, isLoading, _) {
                                return Container(
                                  height: (items.isEmpty && !isLoading)
                                      ? 0
                                      : widget.dropDownHeight,
                                  width:
                                      innerRenderBox.size.width + margin.left,
                                  padding: EdgeInsets.only(
                                    top: widget.dropDownGap,
                                    bottom: margin.bottom,
                                    left: margin.left,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: widget.borderRadius,
                                      border: widget.border,
                                    ),
                                    child: Material(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: widget.borderRadius,
                                      color: widget.dropDownBackgroundColor,
                                      elevation: 2,
                                      child: Builder(builder: (context) {
                                        if (widget.isLoading &&
                                            widget.dropDownLoadingBuilder !=
                                                null) {
                                          return widget
                                              .dropDownLoadingBuilder!(context);
                                        }
                                        return widget.dropDownItemsBuilder!(
                                          context,
                                          this,
                                          items,
                                        );
                                      }),
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: _formKey,
      initialValue: _controller.text,
      validator: (_) {
        return null;
      },
      builder: (formState) {
        return Container(
          margin: widget.margin,
          color: widget.boxBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null) ...[
                Text(widget.label!, style: _labelStyle),
                SizedBox(height: widget.labelGap),
              ],
              CompositedTransformTarget(
                link: _layerLink,
                child: Container(
                  key: _textFieldKey,
                  height: _height,
                  width: _width,
                  decoration: BoxDecoration(
                    borderRadius:
                        widget.borderRadius.add(BorderRadius.circular(1)),
                    border: widget.border,
                    color: widget.inputBackgroundColor,
                  ),
                  child: ClipRRect(
                    borderRadius: widget.borderRadius,
                    child: Row(
                      children: [
                        // prefix
                        if (widget.prefix != null)
                          Container(
                            alignment: Alignment.center,
                            child: widget.prefix,
                          ),
                        Expanded(
                          child: Stack(
                            children: [
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 100),
                                opacity: widget.hint != null && !isEditingText
                                    ? 1
                                    : 0,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: widget.contentPadding,
                                    child: Text(
                                      widget.hint!,
                                      style: _hintStyle,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: widget.contentPadding,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: EditableText(
                                    onTapOutside: (_) => FocusManager
                                        .instance.primaryFocus
                                        ?.unfocus(),
                                    forceLine: true,
                                    textHeightBehavior:
                                        const TextHeightBehavior(
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                      applyHeightToFirstAscent: false,
                                      applyHeightToLastDescent: true,
                                    ),
                                    onChanged: widget.onChanged,
                                    onEditingComplete: widget.onEditingComplete,
                                    onSubmitted: widget.onSubmitted,
                                    obscureText: widget.obscureText,
                                    obscuringCharacter:
                                        widget.obscuringCharacter,
                                    inputFormatters: widget.inputFormatters,
                                    keyboardType: widget.keyboardType,
                                    controller: _controller,
                                    focusNode: _focusNode,
                                    readOnly: widget.disabled,
                                    textAlign: widget.textAlign,
                                    style: _textStyle.copyWith(
                                      textBaseline: TextBaseline.ideographic,
                                    ),
                                    cursorColor: _cursorColor,
                                    backgroundCursorColor:
                                        _backgroundCursorColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // suffix
                        if (widget.suffix != null)
                          Container(
                            alignment: Alignment.center,
                            child: widget.suffix,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (formState.errorText != null) ...[
                SizedBox(height: widget.labelGap / 2),
                Text(
                  formState.errorText!,
                  style: _labelStyle?.copyWith(
                      color: colorTheme.colorScheme.error),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
