import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/scaffold_shell.dart';
import 'package:recive/layout/sliver_header_delegate.dart';

class NotificationScreen extends HookWidget {
  static const name = 'notification';
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(
      safeAreaColor: context.schema.primaryContainer,
      handleTopSafePadding: true,
      backgroundColor: context.schema.background,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverHeaderDelegate(
              child: PreferredSize(
                preferredSize: const Size.fromHeight(72),
                child: TitleHeader(
                  backgroundColor: context.schema.primaryContainer,
                  title: NotificationScreen.name.toCapitalized(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
