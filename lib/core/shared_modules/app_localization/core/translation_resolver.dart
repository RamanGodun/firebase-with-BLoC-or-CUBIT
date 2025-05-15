import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

/// 🌐 [LocalizationResolver] — Handles safe .tr() with or without EasyLocalization
abstract final class LocalizationResolver {
  LocalizationResolver._();

  ///
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

  /// ✅ Utility for deep equality check of String maps
  static bool mapEquals(Map<String, String> a, Map<String, String> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }

  ///
  static String safeTrWithFallback(
    BuildContext context,
    String key,
    String fallback, {
    Map<String, String> namedArgs = const {},
  }) {
    try {
      final localized = tr(context, key, namedArgs: namedArgs);
      return (localized == key) ? fallback : localized;
    } catch (_) {
      return fallback;
    }
  }

  ///
}
