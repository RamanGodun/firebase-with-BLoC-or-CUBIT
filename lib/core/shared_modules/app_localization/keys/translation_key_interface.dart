import 'package:flutter/material.dart';
import '../core/translation_resolver.dart';

/// 🌍 Interface for any translatable message key
abstract interface class ITranslationKey {
  String get translationKey;
  String get fallback;
  Map<String, String> get params;

  /// ✅ Localizes message using context
  String localize(BuildContext context) =>
      LocalizationResolver.safeTrWithFallback(
        context,
        translationKey,
        fallback,
        namedArgs: params,
      );
}
