import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

import 'package:recive/router/navigation_service.dart';

class ShareService {
  final NavigationService navigationService;
  ShareService({
    required this.navigationService,
  });

  Future<ShareResult> shareArt(
    BuildContext context, {
    String? subject,
    required String title,
  }) async {
    final uri = Uri(
      scheme: 'https',
      host: 'recive.com',
      path: navigationService.getUri(context).toString(),
    );
    return Share.shareWithResult(
      'Check out $title in Recive: $uri',
      subject: subject ?? title,
    );
  }
}
