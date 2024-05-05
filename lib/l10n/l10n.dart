import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('tr'),
  ];

  static Locale get systemLocale {
    var languageCode = Platform.localeName.split("_")[0];
    debugPrint("System Language Code: $languageCode");
    if (languageCode == "en" || languageCode == "tr") {
      return Locale(languageCode);
    } else {
      return const Locale("en");
    }
  }
}
