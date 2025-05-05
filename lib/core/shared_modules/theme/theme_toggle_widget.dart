import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/constants/_app_constants.dart' show AppIcons;
import '../../presentation/constants/app_strings.dart' show AppStrings;
import '../overlay/_overlay_service.dart' show OverlayNotificationService;
import 'theme_cubit/theme_cubit.dart' show AppThemeCubit;

/// 🌗 [ThemeToggleIcon] - Toggles between light and dark mode.
class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select<AppThemeCubit, bool>(
      (cubit) => cubit.state.isDarkTheme,
    );

    final icon = isDarkMode ? AppIcons.darkMode : AppIcons.lightMode;

    final iconColor = context.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: () => _toggleTheme(context, isDarkMode),
        tooltip:
            isDarkMode
                ? AppStrings.lightModeEnabled
                : AppStrings.darkModeEnabled,
      ),
    );
  }

  /// 🕹️ Toggles the theme between light and dark mode.
  void _toggleTheme(BuildContext context, bool isDarkMode) {
    context.read<AppThemeCubit>().toggle();

    // 🌟 Show overlay with correct message and icon
    OverlayNotificationService.showOverlay(
      context,
      message:
          isDarkMode ? AppStrings.lightModeEnabled : AppStrings.darkModeEnabled,
      icon: isDarkMode ? AppIcons.lightMode : AppIcons.darkMode,
    );
  }

  ///
}
