import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../logging/_app_logger.dart';
import 'generated/codegen_loader.g.dart';

abstract final class AppLocalization {
  AppLocalization._();

  /// 🌐🌍 Supported locales for the app
  static final supportedLocales = [
    const Locale('en'),
    const Locale('uk'),
    const Locale('pl'),
  ];

  /// 🌐🌍 Localization path in assets
  static const localizationPath = 'assets/translations';

  /// 🌐🌍 Fallback locale for the app
  static const fallbackLocale = Locale('en');

  ///
  static Widget wrap(Widget child) {
    if (!supportedLocales.contains(fallbackLocale)) {
      AppLogger.logException(
        StateError('fallbackLocale "$fallbackLocale" not in supportedLocales'),
      );
    }
    try {
      return EasyLocalization(
        supportedLocales: supportedLocales,
        path: localizationPath,
        fallbackLocale: fallbackLocale,
        assetLoader: const CodegenLoader(),
        child: child,
      );
    } catch (e, s) {
      AppLogger.logException(e, s);
      rethrow;
    }
  }

  ///
}
