import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/core/components/navigation_item.dart';
import 'package:recive/core/components/scaffold_shell.dart';
import 'package:recive/modules/categories_page/cubits/category_fake_data.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

final kBlurConfig = ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);

extension NavigationShellExtension on BuildContext {
  static bool _isUsingFloatingNavBar = false;
  bool get isUsingFloatingNavBar => _isUsingFloatingNavBar;
  set isUsingFloatingNavBar(val) {
    _isUsingFloatingNavBar = val;
  }
}

class NavigationShell extends StatefulWidget {
  const NavigationShell({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.child,
    this.onTap,
    this.extendedWidth = 172,
    this.collapsedWidth = 72,
    this.height = 64,
    this.navBarMaxWidth = 400,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.black,
    this.backgroundColor = Colors.grey,
    this.useFloatingNavBar = true,
    this.borderRadius = 15,
    this.handleTopSafePadding = true,
  });

  final double extendedWidth;
  final double collapsedWidth;
  final double height;
  final double navBarMaxWidth;
  final double borderRadius;

  final List<NavigationItem> items;
  final int currentIndex;
  final Widget child;
  final void Function(int)? onTap;

  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  final bool useFloatingNavBar;
  final bool handleTopSafePadding;

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  late bool _isRailExtended = false;
  late double _railWidth = 1;

  @override
  void initState() {
    context.isUsingFloatingNavBar = widget.useFloatingNavBar;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isRailExtended = context.isUltraWideWith;
        _railWidth = context.isNarrowWith
            ? 1
            : _isRailExtended
                ? widget.extendedWidth
                : widget.collapsedWidth;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(
      backgroundColor: context.colorTheme.surface,
      handleTopSafePadding: widget.handleTopSafePadding,
      bottomNavigationBar: context.isNarrowWith && !widget.useFloatingNavBar ? _buildBottomNavigationBar() : null,
      child: context.isNarrowWith ? _buildNarrowContainer() : _buildWideContainer(),
    );
  }

  Widget _buildNarrowContainer() {
    final safePadding = widget.handleTopSafePadding ? context.viewTopPaddingHeight : 0.0;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: safePadding),
          child: widget.child,
        ),
        if (widget.useFloatingNavBar) _buildFloatingNavigationBar(),
      ],
    );
  }

  Widget _buildWideContainer() {
    if (kIsWeb) {
      return Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://unsplash.com/photos/dBp9dbQCh4Q/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjkxOTYyNzc4fA&force=true&w=2400"),
                  fit: BoxFit.cover,
                ),
                color: context.colorTheme.primary,
              ),
            ),
          ),
          Positioned(
            top: 12,
            bottom: 12,
            right: 112 + 12 + MediaQuery.sizeOf(context).height * .5,
            left: 112,
            child: LayoutBuilder(builder: (context, box) {
              return SizedBox(
                height: box.maxHeight,
                width: box.maxWidth,
                child: CardContainer(
                  color: context.colorTheme.surface.withOpacity(0.7),
                  borderRadius: kMediumBorderRadius,
                  padding: EdgeInsets.zero,
                  child: Container(
                    color: Colors.transparent,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Text(
                                'Vancity Explore',
                                style: context.textTheme.headerMedium.style,
                              ),
                              const SizedBox(height: 48),
                              const Text(introText),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Positioned(
            top: 12,
            bottom: 12,
            right: 112,
            width: MediaQuery.sizeOf(context).height * .5,
            child: CardContainer(
              borderRadius: kMediumBorderRadius,
              padding: EdgeInsets.zero,
              child: _buildNarrowContainer(),
            ),
          )
        ],
      );
    }
    return Stack(
      children: [
        _buildRailContentWrapper(),
        _buildRailNavigationBar(),
      ],
    );
  }

  Widget _buildRailContentWrapper() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      top: 0,
      left: _railWidth,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.vHeight,
          maxWidth: context.vWidth - _railWidth,
        ),
        child: widget.child,
      ),
    );
  }

  Widget _buildRailNavigationBar() {
    return Visibility(
      visible: !context.isNarrowWith,
      child: Positioned(
        top: 0,
        left: 0,
        bottom: 0,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: LayoutBuilder(builder: (context, box) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Theme(
                    data: ThemeData(
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: NavigationRail(
                      backgroundColor: widget.backgroundColor,
                      labelType: NavigationRailLabelType.none,
                      extended: _isRailExtended,
                      onDestinationSelected: widget.onTap,
                      elevation: 4,
                      groupAlignment: -1,
                      unselectedIconTheme: IconThemeData(
                        opacity: 100,
                        color: widget.inactiveColor,
                      ),
                      unselectedLabelTextStyle: TextStyle(color: widget.inactiveColor),
                      selectedIconTheme: IconThemeData(
                        opacity: 100,
                        color: widget.activeColor,
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: widget.activeColor,
                      ),
                      destinations: widget.items.mapIndexed((i, e) {
                        return NavigationRailDestination(
                          icon: Icon(e.iconData),
                          label: Text(e.label ?? ''),
                        );
                      }).toList(),
                      selectedIndex: widget.currentIndex,
                      minWidth: widget.collapsedWidth,
                      minExtendedWidth: widget.extendedWidth,
                      trailing: Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: _railWidth,
                          alignment: _isRailExtended ? Alignment.bottomRight : Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: IconButton(
                              icon: Icon(
                                _isRailExtended ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                                color: widget.inactiveColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isRailExtended = !_isRailExtended;
                                  _railWidth = context.isNarrowWith
                                      ? 1
                                      : _isRailExtended
                                          ? widget.extendedWidth
                                          : widget.collapsedWidth;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return SizedBox(
      height: 100,
      child: Theme(
        data: ThemeData(
          shadowColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          canvasColor: widget.backgroundColor,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          items: widget.items
              .mapIndexed(
                (i, e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.iconData,
                    color: i == widget.currentIndex ? widget.activeColor : widget.inactiveColor,
                  ),
                  label: e.label,
                ),
              )
              .toList(),
          selectedItemColor: widget.activeColor,
          unselectedItemColor: widget.inactiveColor,
          currentIndex: widget.currentIndex,
          onTap: widget.onTap,
        ),
      ),
    );
  }

  Widget _buildFloatingNavigationBar() {
    final safePadding = context.viewBottomPaddingHeight;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: safePadding,
          left: 12,
          right: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(.2, .2),
              blurRadius: 1,
              color: context.colorTheme.shadow,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            filter: kBlurConfig,
            child: Container(
              constraints: BoxConstraints(
                minHeight: widget.height,
                maxHeight: widget.height,
                maxWidth: widget.navBarMaxWidth,
              ),
              color: widget.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.items.mapIndexed((i, e) {
                  final color = i == widget.currentIndex ? widget.activeColor : widget.inactiveColor;
                  return Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: kSmallPadding.left),
                    child: GestureDetector(
                      onTap: () => widget.onTap?.call(i),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            e.iconData,
                            color: color,
                            size: 20,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            e.label ?? '',
                            style: context.textTheme.bodyMedium.copyWith(color: color).style,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
