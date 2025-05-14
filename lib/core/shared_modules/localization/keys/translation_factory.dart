import 'package:flutter/material.dart' show BuildContext;
import '../core/translation_resolver.dart';
import 'translation_key_contract.dart';

final class TranslatableFactory {
  /// ✅ Static translation key with fallback only
  static TranslationKey simple(String key, {required String fallback}) =>
      SimpleTranslatable(key, fallback: fallback);

  /// ✅ Parameterized translation key with args
  static TranslationKey param(
    String key, {
    required String fallback,
    required Map<String, String> args,
  }) => ParameterizedTranslatable(key, fallback: fallback, params: args);

  /// 🧩 Universal shortcut based on `args` presence
  static TranslationKey of(
    String key, {
    required String fallback,
    Map<String, String>? args,
  }) {
    if (args == null || args.isEmpty) {
      return simple(key, fallback: fallback);
    }
    return param(key, fallback: fallback, args: args);
  }

  ///
}

/// 📌 Parameterized translation key holder
final class ParameterizedTranslatable implements TranslationKey {
  @override
  final String translationKey;

  @override
  final String fallback;

  @override
  final Map<String, String> params;

  ParameterizedTranslatable(
    this.translationKey, {
    required this.fallback,
    required this.params,
  });

  @override
  String localize(BuildContext context) =>
      LocalizationResolver.safeTrWithFallback(
        context,
        translationKey,
        fallback,
        namedArgs: params,
      );
}

/// 📌 Static translation key holder
final class SimpleTranslatable implements TranslationKey {
  @override
  final String translationKey;

  @override
  final String fallback;

  @override
  final Map<String, String> params;

  SimpleTranslatable(
    this.translationKey, {
    required this.fallback,
    this.params = const {},
  });

  @override
  String localize(BuildContext context) =>
      LocalizationResolver.safeTrWithFallback(
        context,
        translationKey,
        fallback,
        namedArgs: params,
      );
}
