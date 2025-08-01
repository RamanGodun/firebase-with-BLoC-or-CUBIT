import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/theme/widgets_and_utils/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ui_constants/_app_constants.dart' show AppIcons;
import '../../../localization/generated/locale_keys.g.dart';
import '../../../localization/init_localization.dart';
import '../../theme_providers_or_cubits/theme_cubit.dart' show AppThemeCubit;

/// 🌗 [ThemeTogglerIcon] — toggles between light and dark mode and shows localized message.
//
final class ThemeTogglerIcon extends StatelessWidget {
  ///----------------------------------------------
  const ThemeTogglerIcon({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    final wasDark = context.select<AppThemeCubit, bool>(
      (cubit) => cubit.state.theme.isDark,
    );

    final icon = wasDark ? AppIcons.lightMode : AppIcons.darkMode;
    final iconColor = context.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: Icon(icon, color: iconColor),

        onPressed: () {
          /// 🕹️🔄 Toggles the theme between light and dark mode.
          context.read<AppThemeCubit>().toggleTheme();

          final msgKey =
              wasDark
                  ? LocaleKeys.theme_light_enabled
                  : LocaleKeys.theme_dark_enabled;
          final message = AppLocalizer.translateSafely(msgKey);

          // 🌟 Show overlay with correct message and icon
          context.showUserBanner(message: message, icon: icon);

          //
        },
      ),
    );
  }
}


////

////

////


/*


! For app on Riverpod this widget will be as follows:

/// 🌗 [ThemeTogglerIcon] — toggles light/dark mode and shows overlay notification
//
final class ThemeTogglerIcon extends ConsumerWidget {
  ///-----------------------------------------
  const ThemeTogglerIcon({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final wasDark = ref.watch(themeProvider).theme == ThemeVariantsEnum.dark;
    final icon = wasDark ? AppIcons.lightMode : AppIcons.darkMode;
    final iconColor = context.colorScheme.primary;

    return IconButton(
      icon: Icon(icon, color: iconColor),

      onPressed: () {
        //
        final newTheme =
            wasDark ? ThemeVariantsEnum.light : ThemeVariantsEnum.dark;

        /// 🕹️🔄 Toggles the theme between light and dark mode.
        ref.read(themeProvider.notifier).setTheme(newTheme);

        final msgKey =
            wasDark
                ? LocaleKeys.theme_light_enabled
                : LocaleKeys.theme_dark_enabled;
        final message = AppLocalizer.translateSafely(msgKey);

        // 🌟 Show overlay with correct message and icon
        context.showUserBanner(message: message, icon: icon);

        //
      },
    );
  }
}



 */