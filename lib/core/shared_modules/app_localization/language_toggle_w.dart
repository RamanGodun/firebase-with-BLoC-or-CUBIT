import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_localization/extensions/string_tr_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_overlays/user_driven_flow/user_driven_flow_context_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_localization/app_strings.dart';
import '../../shared_presentation/constants/_app_constants.dart' show AppIcons;
import 'keys/tr_keys.dart';
import 'keys/translation_factory.dart';

/// 🌐 [LanguageToggleIcon] — toggles between supported app languages
// final class LanguageToggleIcon extends StatefulWidget {
//   const LanguageToggleIcon({super.key});

//   @override
//   State<LanguageToggleIcon> createState() => _LanguageToggleIconState();
// }

// final class _LanguageToggleIconState extends State<LanguageToggleIcon> {
//   @override
//   Widget build(BuildContext context) {
//     final currentLocale = context.locale;
//     final isEnglish = currentLocale.languageCode == 'en';

//     final icon = isEnglish ? AppIcons.languageUk : AppIcons.languageEn;
//     final tooltip =
//         isEnglish
//             ? AppStrings.languageSwitchToUa
//             : AppStrings.languageSwitchToEn;

//     return Padding(
//       padding: const EdgeInsets.only(right: 8),
//       child: IconButton(
//         icon: Icon(icon, color: context.colorScheme.primary),
//         tooltip: tooltip.tl(),
//         onPressed: () => _toggleLanguage(isEnglish),
//       ),
//     );
//   }

//   void _toggleLanguage(bool isEnglish) async {
//     final newLocale = Locale(isEnglish ? 'uk' : 'en');
//     await context.setLocale(newLocale);

//     if (!mounted) return;

//     final key =
//         isEnglish
//             ? AppTranslationKeys.languageSwitchedToUa
//             : AppTranslationKeys.languageSwitchedToEn;

//     final localizedMessage = key.localize(context);

//     context.showUserBanner(localizedMessage, AppIcons.language);
//   }

//   //
// }

final class LanguageToggleIcon extends StatefulWidget {
  const LanguageToggleIcon({super.key});

  @override
  State<LanguageToggleIcon> createState() => _LanguageToggleIconState();
}

final class _LanguageToggleIconState extends State<LanguageToggleIcon> {
  static final _locales = [
    const Locale('en'),
    const Locale('uk'),
    const Locale('pl'),
  ];

  @override
  Widget build(BuildContext context) {
    final current = context.locale;
    final nextLocale = _getNextLocale(current);

    final icon = switch (current.languageCode) {
      'en' => AppIcons.languageUk,
      'uk' => AppIcons.languagePl,
      'pl' => AppIcons.languageEn,
      _ => Icons.translate,
    };

    final tooltip = switch (nextLocale.languageCode) {
      'uk' => AppStrings.languageSwitchToUa,
      'pl' => AppStrings.languageSwitchToPl,
      'en' => AppStrings.languageSwitchToEn,
      _ => 'language was changed',
    };

    return IconButton(
      icon: Icon(icon, color: context.colorScheme.primary),
      tooltip: tooltip.tl(),
      onPressed: () => _toggleLanguage(nextLocale),
    ).withPaddingOnly(right: 16);
  }

  Locale _getNextLocale(Locale current) {
    final index = _locales.indexWhere(
      (l) => l.languageCode == current.languageCode,
    );
    final nextIndex = (index + 1) % _locales.length;
    return _locales[nextIndex];
  }

  Future<void> _toggleLanguage(Locale nextLocale) async {
    await context.setLocale(nextLocale);
    if (!mounted) return;

    final messageKey = switch (nextLocale.languageCode) {
      'uk' => AppTranslationKeys.languageSwitchedToUa,
      'pl' => TranslatableFactory.simple(
        'overlay.language.switched_to_pl',
        fallback: 'Przełączono na język polski',
      ),
      'en' => AppTranslationKeys.languageSwitchedToEn,
      _ => TranslatableFactory.simple(
        'overlay.language.changed',
        fallback: 'Language changed',
      ),
    };

    context.showUserBanner(messageKey.localize(context), AppIcons.language);
  }
}
