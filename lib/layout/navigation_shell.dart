import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:recive/components/navigation_item.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/scaffold_shell.dart';

final kBlurConfig = ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);

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

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  late bool _isRailExtended = false;
  late double _railWidth = 1;

  @override
  void initState() {
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
      bottomNavigationBar: context.isNarrowWith && !widget.useFloatingNavBar
          ? _buildBottomNavigationBar()
          : null,
      child: context.isNarrowWith
          ? _buildNarrowContainer()
          : _buildWideContainer(),
    );
  }

  Widget _buildNarrowContainer() {
    final safePadding = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(top: safePadding), child: widget.child),
        if (widget.useFloatingNavBar) _buildFloatingNavigationBar(),
      ],
    );
  }

  Widget _buildWideContainer() {
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
                      unselectedLabelTextStyle:
                          TextStyle(color: widget.inactiveColor),
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
                          alignment: _isRailExtended
                              ? Alignment.bottomRight
                              : Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: IconButton(
                              icon: Icon(
                                _isRailExtended
                                    ? Icons.arrow_back_ios
                                    : Icons.arrow_forward_ios,
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
    return Container(
      height: 100,
      color: Colors.redAccent,
      child: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          canvasColor: widget.backgroundColor,
        ),
        child: BottomNavigationBar(
          elevation: 4,
          items: widget.items
              .mapIndexed(
                (i, e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.iconData,
                    color: i == widget.currentIndex
                        ? widget.activeColor
                        : widget.inactiveColor,
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
    final safePadding = MediaQuery.of(context).padding.bottom;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: safePadding,
          left: 16,
          right: 16,
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
              color: widget.backgroundColor.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.items.mapIndexed((i, e) {
                  final color = i == widget.currentIndex
                      ? widget.activeColor
                      : widget.inactiveColor;
                  return Container(
                    color: Colors.transparent,
                    padding: context.smallPadding,
                    child: GestureDetector(
                      onTap: () => widget.onTap?.call(i),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(e.iconData, color: color),
                          Text(
                            e.label ?? '',
                            style: context.textTheme.bodyMedium!
                                .copyWith(color: color),
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
