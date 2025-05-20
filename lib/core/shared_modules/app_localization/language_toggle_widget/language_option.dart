import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_localization/code_base_for_both_options/text_widget.dart';
import 'package:flutter/material.dart';
import '../generated/locale_keys.g.dart';

/// 🌐🌍 Enum describing supported app languages with metadata
// ---------------------------------------------------

enum LanguageOption {
  en(
    Locale('en'),
    '🇬🇧',
    LocaleKeys.languages_switched_to_en,
    'Change to English',
  ),
  uk(
    Locale('uk'),
    '🇺🇦',
    LocaleKeys.languages_switched_to_ua,
    'Змінити на українську',
  ),
  pl(
    Locale('pl'),
    '🇵🇱',
    LocaleKeys.languages_switched_to_pl,
    'Zmień na polski',
  );

  const LanguageOption(this.locale, this.flag, this.messageKey, this.label);

  final Locale locale;
  final String flag;
  final String messageKey;
  final String label;

  /// Converts to styled [PopupMenuItem], disables current language
  PopupMenuItem<LanguageOption> toMenuItem(String currentLangCode) {
    final isCurrent = locale.languageCode == currentLangCode;

    return PopupMenuItem<LanguageOption>(
      value: this,
      enabled: !isCurrent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      height: 36,
      child: Opacity(
        opacity: isCurrent ? 0.5 : 1.0,
        child: Row(
          children: [
            TextWidget(flag, TextType.titleSmall, alignment: TextAlign.start),
            const SizedBox(width: 12),
            Expanded(
              child: TextWidget(
                label,
                TextType.titleSmall,
                alignment: TextAlign.start,
              ),
            ),
            if (isCurrent)
              const Icon(Icons.check, size: 16, color: AppColors.darkAccent),
          ],
        ),
      ),
    );
  }

  ///
}
