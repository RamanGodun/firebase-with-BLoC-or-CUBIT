import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

/// 🌐 [AppLocalizationUtils] — Handles safe .tr() with or without EasyLocalization
abstract final class AppLocalizationUtils {
  static String tr(
    BuildContext context,
    String key, {
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    try {
      return trInternal(
        context,
        key,
        args: args,
        namedArgs: namedArgs,
        gender: gender,
      );
    } catch (_) {
      return key; // ❌ fallback if EasyLocalization is not available
    }
  }

  static String trInternal(
    BuildContext context,
    String key, {
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    final easyLoc = EasyLocalization.of(context);
    if (easyLoc == null || !easyLoc.supportedLocales.contains(context.locale)) {
      return key;
    }

    return key.tr(args: args ?? [], namedArgs: namedArgs ?? {}, gender: gender);
  }

  ///
}
