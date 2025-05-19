import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

abstract final class AppLocalization {
  AppLocalization._();

  /// 🌐 Supported locales for the app
  static final supportedLocales = [
    const Locale('en'),
    const Locale('uk'),
    const Locale('pl'),
  ];

  /// 🌐 Localization path in assets
  static const localizationPath = 'assets/translations';

  /// 🌐 Fallback locale for the app
  static const fallbackLocale = Locale('en');

  ///
  static Widget wrap(Widget child) {
    return EasyLocalization(
      supportedLocales: supportedLocales,
      path: localizationPath,
      fallbackLocale: fallbackLocale,
      child: child,
    );
  }

  ///
}
