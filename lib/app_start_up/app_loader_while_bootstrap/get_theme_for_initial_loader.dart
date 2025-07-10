import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Required for platformBrightness
import 'package:hydrated_bloc/hydrated_bloc.dart' show HydratedBloc;
import '../../core/foundation/theme/_theme_preferences.dart';
import '../../core/foundation/theme/app_theme_variants.dart';
import '../../core/foundation/theme/text_theme/text_theme_factory.dart';
import '../../core/foundation/theme/theme_cubit.dart';

/// [ThemeForInitialLoader] provides the initial ThemePreferences for the loader/splash phase.
/// It reads from HydratedBloc's storage, parses theme preferences, or falls back to system brightness.

abstract final class ThemeForInitialLoader {
  ///------------------------------------
  ThemeForInitialLoader._();
  //

  /// Tries to read the persisted theme from [HydratedBloc] storage.
  /// - If a valid theme is found, returns it.
  /// - If not, falls back to the current platform brightness (system theme).
  /// - If an error occurs, returns a hardcoded dark theme as a last-resort fallback.

  static Future<ThemePreferences> get() async {
    try {
      final hydratedBox = HydratedBloc.storage;
      // Read serialized theme JSON from HydratedBloc storage
      final dynamic themeJson = await hydratedBox.read('AppThemeCubit');
      debugPrint('[THEME LOG] ThemeJson in storage: $themeJson');

      if (themeJson != null) {
        // Try to parse theme from persisted JSON
        final prefs = AppThemeCubit().fromJson(
          Map<String, dynamic>.from(themeJson as Map),
        );
        if (prefs != null) return prefs;
      }

      // Fallback: Use current system theme (light/dark) as default
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      debugPrint('[THEME LOG] Fallback to system theme: $brightness');

      /// Returns initial [ThemePreferences] for the app loader.
      return ThemePreferences(
        theme:
            brightness == Brightness.dark
                ? ThemeVariantsEnum.dark
                : ThemeVariantsEnum.light,
        font: AppFontFamily.sfPro,
      );
    } catch (e, st) {
      // On error: fallback to hardcoded dark theme (never crash loader)
      debugPrint('[THEME LOG] Error: $e\n$st');
      return const ThemePreferences(
        theme: ThemeVariantsEnum.dark,
        font: AppFontFamily.sfPro,
      );
    }
  }
}
