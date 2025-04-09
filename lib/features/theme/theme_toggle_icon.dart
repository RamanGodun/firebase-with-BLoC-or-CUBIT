import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_constants.dart' show AppConstants;
import '../../core/constants/app_strings.dart' show AppStrings;
import '../../core/utils_and_services/helpers.dart';
import '../../core/utils_and_services/overlay/overlay_service.dart'
    show OverlayNotificationService;
import 'theme_cubit/theme_cubit.dart' show AppThemeCubit;

/// 🌗 [ThemeToggleIcon] - Toggles between light and dark mode.
class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select<AppThemeCubit, bool>(
      (cubit) => cubit.state.isDarkTheme,
    );

    final themeIcon =
        isDarkMode ? AppConstants.darkModeIcon : AppConstants.lightModeIcon;
    final iconColor = Helpers.getColorScheme(context).primary;

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: Icon(themeIcon, color: iconColor),
        onPressed: () => _toggleTheme(context, isDarkMode),
      ),
    );
  }

  /// 🕹️ Toggles the theme between light and dark mode.w
  void _toggleTheme(BuildContext context, bool isDarkMode) {
    context.read<AppThemeCubit>().toggleTheme(!isDarkMode);

    // 🌟 Show overlay with correct message and icon
    final overlayMessage =
        isDarkMode ? AppStrings.lightModeEnabled : AppStrings.darkModeEnabled;
    final overlayIcon =
        isDarkMode ? AppConstants.lightModeIcon : AppConstants.darkModeIcon;

    OverlayNotificationService.showOverlay(
      context,
      message: overlayMessage,
      icon: overlayIcon,
    );
  }
}
