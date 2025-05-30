import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../shared_modules/localization/generated/locale_keys.g.dart';

/// 🌍 [LocalizationConfig] — Extracts and holds localization settings from [BuildContext].
/// ✅ Includes active locale, supported locales and localization delegates.
@immutable
final class LocalizationConfig {
  final Locale locale;
  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate<dynamic>> delegates;

  const LocalizationConfig({
    required this.locale,
    required this.supportedLocales,
    required this.delegates,
  });

  /// 📦 Extracts localization state from Flutter context.
  factory LocalizationConfig.fromContext(BuildContext context) {
    return LocalizationConfig(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      delegates: context.localizationDelegates,
    );
  }

  /// 🏷️ Localized app title used in [MaterialApp.title].
  String get title => LocaleKeys.app_title.tr();

  //
}
