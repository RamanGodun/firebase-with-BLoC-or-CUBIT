import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared_presentation/constants/_app_constants.dart' show AppIcons;
import '../../localization/generated/locale_keys.g.dart';
import '../../localization/code_base_for_both_options/_app_localizer.dart';
import '../theme_cubit/theme_cubit.dart' show AppThemeCubit;

/// 🌗 [ThemeToggleIcon] — toggles between light and dark mode and shows localized message.
final class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final wasDark = context.select<AppThemeCubit, bool>(
      (cubit) => cubit.state.isDarkTheme,
    );

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: Icon(
          wasDark ? AppIcons.darkMode : AppIcons.lightMode,
          color: context.colorScheme.primary,
        ),
        tooltip:
            wasDark
                ? LocaleKeys.theme_light_enabled.tr()
                : LocaleKeys.theme_dark_enabled.tr(),
        onPressed: () => _toggleTheme(context, wasDark),
      ),
    );
  }

  /// 🕹️ Toggles the theme between light and dark mode.
  void _toggleTheme(BuildContext context, bool wasDark) {
    context.read<AppThemeCubit>().toggle();

    final msgKey =
        wasDark
            ? LocaleKeys.theme_light_enabled
            : LocaleKeys.theme_dark_enabled;
    final message = AppLocalizer.t(msgKey);
    final icon = wasDark ? AppIcons.lightMode : AppIcons.darkMode;

    // 🌟 Show overlay with correct message and icon
    context.showUserBanner(message: message, icon: icon);
  }

  //
}
