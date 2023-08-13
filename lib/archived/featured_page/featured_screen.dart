import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/big_square_card.dart';
import 'package:recive/archived/category_section_row.dart';
import 'package:recive/components/sliver_gap.dart';

import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/custom_shape_background_widget.dart';
import 'package:recive/layout/sliver_header_delegate.dart';
import 'package:recive/models/recive.model.dart';

import 'greeting_header/greeting_header_component.dart';
import 'quick_search_header/quick_search_header_component.dart';

class FeaturedScreen extends HookWidget {
  static const name = 'featured';
  const FeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final content = CustomShapeBackgroundWidget(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: SliverHeaderDelegate(
              child: const PreferredSize(
                preferredSize: Size.fromHeight(64),
                child: GreetingHeader(),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
              child: const PreferredSize(
                preferredSize: Size.fromHeight(88),
                child: QuickSearchHeader(
                  onSelect: null,
                  onTextChanged: null,
                  textController: null,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: CategorySection(),
          ),
          const SliverGap(height: 16),
          for (var i = 1; i < 4; i++) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Featured Recives for Today",
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Builder(builder: (context) {
                      final images = <String>[...recive.imageUrls];
                      images.shuffle();
                      return BigSquareCard(
                          data: recive.copyWith(imageUrls: images.toList()));
                    }),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
    return content;
  }
}
