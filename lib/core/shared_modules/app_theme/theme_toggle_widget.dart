import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_overlays/core/overlay_service.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared_presentation/constants/_app_constants.dart' show AppIcons;
import '../app_localization/app_strings.dart' show AppStrings;
import '../app_localization/keys/tr_keys.dart';
import 'theme_cubit/theme_cubit.dart' show AppThemeCubit;

/// 🌗 [ThemeToggleIcon] - Toggles between light and dark mode.
final class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final wasDarkMode = context.select<AppThemeCubit, bool>(
      (cubit) => cubit.state.isDarkTheme,
    );

    final icon = wasDarkMode ? AppIcons.darkMode : AppIcons.lightMode;

    final iconColor = context.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: () => _toggleTheme(context, wasDarkMode),
        tooltip:
            wasDarkMode
                ? AppStrings.lightModeEnabled
                : AppStrings.darkModeEnabled,
      ),
    );
  }

  /// 🕹️ Toggles the theme between light and dark mode.
  void _toggleTheme(BuildContext context, bool isDarkMode) {
    context.read<AppThemeCubit>().toggle();

    final message =
        isDarkMode
            ? AppTranslationKeys.lightModeEnabled.localize(context)
            : AppTranslationKeys.darkModeEnabled.localize(context);
    final icon = isDarkMode ? AppIcons.lightMode : AppIcons.darkMode;

    // 🌟 Show overlay with correct message and icon
    context.showUserBanner(message, icon);
    //
  }

  ///
}
