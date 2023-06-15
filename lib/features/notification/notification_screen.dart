import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/layout/scaffold_shell.dart';
import 'package:recive/layout/sliver_header_delegate.dart';

class NotificationScreen extends HookWidget {
  static const name = 'notification';
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(
      handleTopSafePadding: true,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: SliverHeaderDelegate(
              child: PreferredSize(
                preferredSize: const Size.fromHeight(72),
                child: TitleHeader(
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
