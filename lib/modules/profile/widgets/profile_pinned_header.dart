import 'package:flutter/material.dart';

import 'package:custom_clippers/custom_clippers.dart';

import 'package:recive/core/components/custom_shape_background_widget.dart';
import 'package:recive/core/components/navigation_shell.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class ProfilePinnedHeader extends StatelessWidget {
  const ProfilePinnedHeader({
    super.key,
    required this.profileImageUrl,
    required this.profileName,
    required this.isLoading,
    required this.onLogout,
  });

  final String? profileImageUrl;
  final String? profileName;
  final bool isLoading;
  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return ClipperShadowPainter(
      clipper: SinCosineWaveClipper(
        verticalPosition: VerticalPosition.bottom,
        horizontalPosition: HorizontalPosition.right,
      ),
      shadow: Shadow(
        color: context.colorTheme.shadow,
        offset: Offset.zero,
        blurRadius: 4,
      ),
      child: BackdropFilter(
        filter: kBlurConfig,
        child: Container(
          height: 220,
          color: context.colorTheme.navBackground,
          child: Stack(
            children: [
              Positioned(
                top: 12,
                right: 24,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: context.colorTheme.navBackground.darken(0.1),
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                        offset: const Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: profileImageUrl != null ? NetworkImage(profileImageUrl!) : null,
                    backgroundColor: context.colorTheme.primary,
                    radius: 72,
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 24,
                right: 72 * 2 + 24 + 12,
                child: Text(
                  profileName ?? '',
                  style: context.textTheme.titleTiny.onNavBackground.style,
                ),
              ),
              Positioned(
                bottom: 80,
                left: 24,
                right: 72 * 2 + 24 + 12,
                child: InkWell(
                  onTap: onLogout,
                  child: Container(
                    padding: kTinyPadding,
                    alignment: Alignment.center,
                    constraints: const BoxConstraints.expand(height: 48),
                    decoration: ShapeDecoration(
                      color: context.colorTheme.secondary,
                      shape: const StadiumBorder(
                        side: BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    child: isLoading
                        ? const Center(
                            child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          ))
                        : Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: context.textTheme.titleTiny.onSecondary.style,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
