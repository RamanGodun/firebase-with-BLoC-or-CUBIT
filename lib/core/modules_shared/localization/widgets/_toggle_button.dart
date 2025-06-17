import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import '../../theme/core/constants/_app_constants.dart' show AppIcons;
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
        final showBanner = context.showUserBanner;

        //  🌐🌍 Change localization
        context.setLocale(option.locale).then((_) {
          //
          // 🌟 Show overlay with correct message and icon
          showBanner(message: option.messageKey.tr(), icon: AppIcons.language);
        });
      },
    );
  }
}
