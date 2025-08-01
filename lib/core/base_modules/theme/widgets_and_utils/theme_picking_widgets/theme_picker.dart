import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../localization/core_of_module/init_localization.dart';
import '../../../localization/generated/locale_keys.g.dart';
import '../../../overlays/core/_context_x_for_overlays.dart';
import '../../module_core/app_theme_preferences.dart';
import '../../theme_providers_or_cubits/theme_cubit.dart';
import '../../module_core/theme_variants.dart';

/// 🌗 [ThemePicker] — Allows to pick the theme mode and shows overlay notification
//
final class ThemePicker extends StatelessWidget {
  ///--------------------------------------
  const ThemePicker({super.key});
  //

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, ThemePreferences>(
      builder: (context, state) {
        return DropdownButton<ThemeVariantsEnum>(
          key: ValueKey(Localizations.localeOf(context).languageCode),
          value: state.theme,
          icon: const Icon(Icons.arrow_drop_down),
          underline: const SizedBox(),

          // 🔄 On theme change
          onChanged: (ThemeVariantsEnum? selected) {
            if (selected == null) return;

            // 🟢 Update theme
            context.read<AppThemeCubit>().setTheme(selected);

            // 🏷️ Get localized label
            final label = _chosenThemeLabel(context, selected);

            // 🌟 Show overlay
            context.showUserBanner(message: label, icon: Icons.palette);
          },

          // 📃 Theme options
          items:
              ThemeVariantsEnum.values.map((type) {
                return DropdownMenuItem<ThemeVariantsEnum>(
                  value: type,
                  child: Text(
                    _themeLabel(context, type),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  ////
  ////

  /// 🏷️ Returns localized label for a given theme type
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

  ////

  /// 🏷️ Returns localized label for a given theme type
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


////

////

////


/*


! For app on Riverpod this widget will be as follows:

/// 🌗 [ThemePicker] — Allows to pick the theme mode and shows overlay notification
//
final class ThemePicker extends ConsumerWidget {
  ///--------------------------------------
  const ThemePicker({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final themeConfig = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final locale = Localizations.localeOf(context);

    return DropdownButton<ThemeVariantsEnum>(
      key: ValueKey(locale.languageCode),
      value: themeConfig.theme,
      icon: const Icon(Icons.arrow_drop_down),
      underline: const SizedBox(),

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

  /// 🏷️ Returns localized label for a given theme type
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

  /// 🏷️ Returns localized label for a given theme type
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



 */