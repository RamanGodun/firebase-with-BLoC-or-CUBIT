import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../localization/app_localizer.dart';
import '../../localization/generated/locale_keys.g.dart';
import '../../overlays/core/_context_x_for_overlays.dart';
import '../core/_theme_config.dart';
import '../core/theme_cubit.dart';
import '../core/theme_type_enum.dart.dart';

final class ThemePicker extends StatelessWidget {
  ///--------------------------------------
  const ThemePicker({super.key});
  //

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, ThemeConfig>(
      builder: (context, state) {
        return DropdownButton<ThemeTypes>(
          key: ValueKey(Localizations.localeOf(context).languageCode),
          value: state.theme,
          icon: const Icon(Icons.arrow_drop_down),
          underline: const SizedBox(),

          // 🔄 On theme change
          onChanged: (ThemeTypes? selected) {
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
              ThemeTypes.values.map((type) {
                return DropdownMenuItem<ThemeTypes>(
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

  String _themeLabel(BuildContext context, ThemeTypes type) {
    switch (type) {
      case ThemeTypes.light:
        return AppLocalizer.t(LocaleKeys.theme_light);
      case ThemeTypes.dark:
        return AppLocalizer.t(LocaleKeys.theme_dark);
      case ThemeTypes.amoled:
        return AppLocalizer.t(LocaleKeys.theme_amoled);
    }
  }

  String _chosenThemeLabel(BuildContext context, ThemeTypes type) {
    switch (type) {
      case ThemeTypes.light:
        return AppLocalizer.t(LocaleKeys.theme_light_enabled);
      case ThemeTypes.dark:
        return AppLocalizer.t(LocaleKeys.theme_dark_enabled);
      case ThemeTypes.amoled:
        return AppLocalizer.t(LocaleKeys.theme_amoled_enabled);
    }
  }
}
