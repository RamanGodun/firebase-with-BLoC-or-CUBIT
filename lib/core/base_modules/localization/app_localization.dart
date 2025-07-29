import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'generated/codegen_loader.g.dart';

abstract final class LocalizationWrapper {
  //---------------------------------
  LocalizationWrapper._();
  //

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

  /// Wraps the provided widget with localization configuration.
  /// Ensures that the entire subtree has access to EasyLocalization,
  /// which enables locale switching, translation, and fallback logic.
  static Widget configure(Widget child) {
    return EasyLocalization(
      supportedLocales: supportedLocales,
      path: localizationPath,
      fallbackLocale: fallbackLocale,
      assetLoader: const CodegenLoader(),
      child: child,
    );
  }

  //
}
