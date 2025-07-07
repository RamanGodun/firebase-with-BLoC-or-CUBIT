import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // потрібен для platformBrightness
import 'package:hydrated_bloc/hydrated_bloc.dart' show HydratedBloc;
import '../../../../modules_shared/theme/_theme_preferences.dart';
import '../../../../modules_shared/theme/app_theme_variants.dart';
import '../../../../modules_shared/theme/text_theme/text_theme_factory.dart';
import '../../../../modules_shared/theme/theme_cubit.dart';

abstract final class ThemeForInitialLoader {
  ThemeForInitialLoader._();

  static Future<ThemePreferences> get() async {
    try {
      final hydratedBox = HydratedBloc.storage;
      final dynamic themeJson = await hydratedBox.read('AppThemeCubit');
      debugPrint('[THEME LOG] ThemeJson in storage: $themeJson');

      if (themeJson != null) {
        final prefs = AppThemeCubit().fromJson(
          Map<String, dynamic>.from(themeJson as Map),
        );
        if (prefs != null) return prefs;
      }

      // fallback на system theme
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      debugPrint('[THEME LOG] Fallback to system theme: $brightness');

      return ThemePreferences(
        theme:
            brightness == Brightness.dark
                ? ThemeVariantsEnum.dark
                : ThemeVariantsEnum.light,
        font: AppFontFamily.sfPro,
      );
    } catch (e, st) {
      debugPrint('[THEME LOG] Error: $e\n$st');
      // ще нижчий fallback — завжди dark
      return const ThemePreferences(
        theme: ThemeVariantsEnum.dark,
        font: AppFontFamily.sfPro,
      );
    }
  }
}
