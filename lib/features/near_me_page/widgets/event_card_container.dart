import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/near_me_page/near_me_detail_screen.dart';
import 'package:recive/features/near_me_page/near_me_screen.dart';
import 'package:recive/features/near_me_page/widgets/event_card_container_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class EventCardContainer extends StatelessWidget {
  const EventCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final EventCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme.tertiary.withOpacity(0.6);
    final fontColor = context.colorScheme.onTertiary;

    final child = LayoutBuilder(builder: (context, box) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: color,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data.title,
                      maxLines: 1,
                      style: context.titleMediumOnPrimaryContainer
                          .withColor(fontColor),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });

    final heroTag = data.id + DateTime.now().toString();
    const route = NearMeScreen.name + NearbyDetailScreen.name;
    final extra = ExtraData(
      summary: NearbyDetailSummaryData(
        id: data.id,
        title: data.title,
        imageUrl: data.imageUrl,
      ),
      heroTag: heroTag,
    );
    final pathParams = {
      DetailScreen.pathParamId: data.id,
    };
    final navigationService = locator.get<NavigationService>();
    final extraJson = extra.toJson((inner) => inner.toJson());

    return RepaintBoundary(
      child: InkWell(
        onTap: () {
          navigationService.pushTo(
            route,
            pathParameters: pathParams,
            extra: extraJson,
          );
        },
        child: Hero(
          tag: heroTag,
          child: CachedNetworkImage(
            imageUrl: data.imageUrl,
            imageBuilder: (context, imageProvider) =>
                _buildEventCard(imageProvider, color, child),
            placeholder: (context, url) => _buildEventLoading(color),
            errorWidget: (context, url, error) =>
                _buildEventCard(null, color, child),
          ),
        ),
      ),
    );
  }

  Container _buildEventLoading(Color color) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container _buildEventCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Widget child,
  ) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        image: imageProvider == null
            ? null
            : DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                opacity: 0.9,
              ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color.lighten(0.1),
            color.darken(0.3),
          ],
        ),
      ),
      padding: kTinyPadding,
      child: child,
    );
  }
}
