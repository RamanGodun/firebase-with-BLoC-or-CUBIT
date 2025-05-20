import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_overlays/user_driven_flow/user_driven_flow_context_x.dart';
import '../../../shared_presentation/constants/_app_constants.dart'
    show AppIcons;
import 'language_option.dart';

/// 🌐🌍 [LanguageToggleButton] — macOS-style drop-down with flag + native text
//-------------------------------------------------------------------------

final class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLangCode = context.locale.languageCode;

    return PopupMenuButton<LanguageOption>(
      tooltip: 'Change Language',
      padding: EdgeInsets.zero,
      icon: Icon(
        AppIcons.language,
        color: context.colorScheme.primary,
      ).withPaddingOnly(right: 20),
      itemBuilder:
          (_) =>
              LanguageOption.values
                  .map((e) => e.toMenuItem(currentLangCode))
                  .toList(),
      onSelected: (option) {
        final locale = option.locale;
        final bannerMessage = option.messageKey.tr();
        final showBanner = context.showUserBanner;

        context.setLocale(locale).then((_) {
          showBanner(bannerMessage, AppIcons.language);
        });
      },
    );
  }
}
