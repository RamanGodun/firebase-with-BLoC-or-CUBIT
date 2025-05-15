import 'package:flutter/foundation.dart' show immutable;

import 'translation_factory.dart';

/// 🔖 Pre-defined keys for UI/UX-messages

@immutable
sealed class AppTranslationKeys {
  static final languageSwitchedToEn = TranslatableFactory.of(
    'overlay.language.switched_to_en',
    fallback: 'Switched to English',
  );

  static final languageSwitchedToUa = TranslatableFactory.of(
    'overlay.language.switched_to_ua',
    fallback: 'Переключено на українську',
  );

  static final unexpected = TranslatableFactory.of(
    'overlay.error.unexpected',
    fallback: 'Something went wrong',
  );

  static final noInternet = TranslatableFactory.of(
    'overlay.error.no_internet',
    fallback: 'No internet connection',
  );

  static final timeout = TranslatableFactory.of(
    'overlay.error.timeout',
    fallback: 'Request timeout. Try again.',
  );

  static final saved = TranslatableFactory.of(
    'overlay.success.saved',
    fallback: 'Saved successfully',
  );

  static final deleted = TranslatableFactory.of(
    'overlay.success.deleted',
    fallback: 'Item deleted',
  );

  static final lightModeEnabled = TranslatableFactory.of(
    'overlay.theme.light_enabled',
    fallback: 'Light mode enabled',
  );

  static final darkModeEnabled = TranslatableFactory.of(
    'overlay.theme.dark_enabled',
    fallback: 'Dark mode enabled',
  );
}
