import 'dart:ui';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/theme/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FilterContainerController extends ChangeNotifier {
  bool _visible = false;

  bool get isVisible => _visible;

  void open() {
    _visible = true;
    notifyListeners();
  }

  void close() {
    _visible = false;
    notifyListeners();
  }

  void toggle() {
    _visible = !_visible;
    notifyListeners();
  }
}

class FilterContainer extends StatefulWidget {
  const FilterContainer({
    super.key,
    required this.description,
    required this.controller,
    required this.child,
  });

  final FilterContainerController controller;
  final Widget description;
  final Widget child;

  @override
  State<FilterContainer> createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool isVisible = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Durations.medium1, // Customize duration
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    widget.controller.addListener(_handleControllerChange);
    super.initState();
  }

  void _handleControllerChange() {
    if (widget.controller.isVisible) {
      portal.show();
      WidgetsBinding.instance.addPostFrameCallback((_) => _animationController.forward());
    } else {
      _animationController.reverse().then((_) => portal.hide());
    }
  }

  OverlayPortalController get portal => _portal;
  final OverlayPortalController _portal = OverlayPortalController();

  @override
  void didUpdateWidget(covariant FilterContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleControllerChange);
      widget.controller.addListener(_handleControllerChange);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.controller.removeListener(_handleControllerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: portal,
      overlayChildBuilder: (BuildContext context) {
        return OverflowBox(
          fit: OverflowBoxFit.max,
          child: Container(
            margin: EdgeInsets.only(
              top: context.vTopSafeHeight + kToolbarHeight + kMediumPadding.top,
              right: kMediumPadding.right,
              left: kMediumPadding.left,
              bottom: kMediumPadding.bottom,
            ),
            child: GestureDetector(
              onTap: widget.controller.close,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final opacity = _animation.value;
                  return Opacity(
                    opacity: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        ((1 - opacity) * (20) + kMediumBorderRadius.topRight.y),
                      ),
                      child: Align(
                        alignment: const Alignment(1, -1),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: opacity * 5.0,
                            sigmaY: opacity * 5.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  context.colorTheme.navBackground.withOpacity(kSmallOpacity),
                              border: kBoxBorder,
                              borderRadius: BorderRadius.circular(
                                ((1 - opacity) * (20) + kMediumBorderRadius.topRight.y),
                              ),
                            ),
                            height: (opacity * context.vHeight),
                            width: opacity * context.vWidth,
                            child: opacity != 1 ? const SizedBox() : widget.description,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
