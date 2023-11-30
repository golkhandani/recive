import 'package:flutter/material.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

final emptySearchResultSnackbar = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Sorry',
    message: "We couldn't find any art around you!",

    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
    contentType: ContentType.warning,
    // to configure for material banner
    inMaterialBanner: true,
  ),
);
