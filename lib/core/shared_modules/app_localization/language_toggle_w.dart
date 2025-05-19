import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_localization/extensions/string_tr_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_overlays/user_driven_flow/user_driven_flow_context_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_localization/app_strings.dart';
import '../../shared_presentation/constants/_app_constants.dart' show AppIcons;
import 'core/localization_config.dart';
import 'fallbacks_keys_when_no_localization/tr_keys.dart';

/// 🌐 [LanguageToggleIcon] — toggles between supported app languages

final class LanguageToggleIcon extends StatefulWidget {
  const LanguageToggleIcon({super.key});

  @override
  State<LanguageToggleIcon> createState() => _LanguageToggleIconState();
}

final class _LanguageToggleIconState extends State<LanguageToggleIcon> {
  @override
  Widget build(BuildContext context) {
    final current = context.locale;
    final supported = AppLocalization.supportedLocales;
    final nextLocale = _getNextLocale(current, supported);

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
      _ => 'Change language',
    };

    return IconButton(
      icon: Icon(icon, color: context.colorScheme.primary),
      tooltip: tooltip.tl(),
      onPressed: () => _toggleLanguage(nextLocale),
    ).withPaddingOnly(right: 16);
  }

  Locale _getNextLocale(Locale current, List<Locale> locales) {
    final index = locales.indexWhere(
      (l) => l.languageCode == current.languageCode,
    );
    final nextIndex = (index + 1) % locales.length;
    return locales[nextIndex];
  }

  Future<void> _toggleLanguage(Locale nextLocale) async {
    await context.setLocale(nextLocale);
    if (!mounted) return;

    final messageKey = switch (nextLocale.languageCode) {
      'uk' => FallbackKeysWhenNoLocalization.languageSwitchedToUa,
      'pl' => FallbackKeysWhenNoLocalization.languageSwitchedToPl,
      'en' => FallbackKeysWhenNoLocalization.languageSwitchedToEn,
      _ => FallbackKeysWhenNoLocalization.languageSwitchedToEn,
    };

    context.showUserBanner(messageKey, AppIcons.language);
  }
}
