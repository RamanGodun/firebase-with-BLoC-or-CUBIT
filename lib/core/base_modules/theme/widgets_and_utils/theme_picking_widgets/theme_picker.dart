import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../localization/core_of_module/init_localization.dart';
import '../../../localization/generated/locale_keys.g.dart';
import '../../../localization/module_widgets/text_widget.dart';
import '../../../overlays/core/_context_x_for_overlays.dart';
import '../../theme_providers_or_cubits/theme_cubit.dart';
import '../../module_core/theme_variants.dart';

/// 🌗 [ThemePicker] — Allows to pick the theme mode and shows overlay notification
/// Use this widget in both Riverpod or Cubit/BLoC apps by toggling the relevant section.
/// Only one block (Riverpod or Cubit) should be uncommented at a time.
///
final class ThemePicker extends StatelessWidget {
  ///--------------------------------------
  const ThemePicker({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    /// 🔴 RIVERPOD — Uncomment for apps using Riverpod
    /*
      final themeConfig = ref.watch(themeProvider);
      final themeNotifier = ref.read(themeProvider.notifier);
    */

    /// 🟢 RIVERPOD — Uncomment for apps using Cubit/BLoC
    final themeConfig = context.watch<AppThemeCubit>().state;
    final themeNotifier = context.read<AppThemeCubit>();

    final locale = Localizations.localeOf(context);

    return DropdownButton<ThemeVariantsEnum>(
      key: ValueKey(locale.languageCode),
      value: themeConfig.theme,
      icon: const Icon(Icons.arrow_drop_down),
      underline: const SizedBox(),

      /// 🔄 When user picks a theme
      onChanged: (ThemeVariantsEnum? selected) {
        if (selected == null) return;

        // 🟢 Apply selected theme
        themeNotifier.setTheme(selected);

        // 🏷️ Fetch localized label
        final label = _chosenThemeLabel(context, selected);

        // 🌟 Show overlay banner with confirmation
        context.showUserBanner(message: label, icon: Icons.palette);
      },

      // 🧾 Theme options list
      items:
          [
                ThemeVariantsEnum.light,
                ThemeVariantsEnum.dark,
                ThemeVariantsEnum.amoled,
              ]
              .map(
                (type) => DropdownMenuItem<ThemeVariantsEnum>(
                  value: type,
                  child: TextWidget(
                    _themeLabel(context, type),
                    TextType.titleMedium,
                  ),
                ),
              )
              .toList(),
    );
  }

  ////
  ////

  /// 🏷️ Returns localized label for theme in dropdown
  String _themeLabel(BuildContext context, ThemeVariantsEnum type) {
    switch (type) {
      case ThemeVariantsEnum.light:
        return AppLocalizer.translateSafely(LocaleKeys.theme_light);
      case ThemeVariantsEnum.dark:
        return AppLocalizer.translateSafely(LocaleKeys.theme_dark);
      case ThemeVariantsEnum.amoled:
        return AppLocalizer.translateSafely(LocaleKeys.theme_amoled);
    }
  }

  /// 🏷️ Returns localized label for confirmation banner
  String _chosenThemeLabel(BuildContext context, ThemeVariantsEnum type) {
    switch (type) {
      case ThemeVariantsEnum.light:
        return AppLocalizer.translateSafely(LocaleKeys.theme_light_enabled);
      case ThemeVariantsEnum.dark:
        return AppLocalizer.translateSafely(LocaleKeys.theme_dark_enabled);
      case ThemeVariantsEnum.amoled:
        return AppLocalizer.translateSafely(LocaleKeys.theme_amoled_enabled);
    }
  }

  //
}
