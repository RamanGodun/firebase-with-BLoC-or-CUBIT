import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hydrated_bloc/hydrated_bloc.dart' show HydratedBloc;

import '../../../../modules_shared/theme/_theme_preferences.dart';
import '../../../../modules_shared/theme/app_theme_variants.dart';
import '../../../../modules_shared/theme/text_theme/text_theme_factory.dart';
import '../../../../modules_shared/theme/theme_cubit.dart';

abstract final class ThemeForInitialLoader {
  ///------------------------------------
  ThemeForInitialLoader._();

  static Future<ThemePreferences> get() async {
    final hydratedBox = HydratedBloc.storage;
    final dynamic themeJson = await hydratedBox.read('AppThemeCubit');
    debugPrint('[THEME LOG] ThemeJson in storage: $themeJson');

    final ThemePreferences? initialTheme =
        themeJson == null
            ? const ThemePreferences(
              theme: ThemeVariantsEnum.light,
              font: AppFontFamily.sfPro,
            )
            : AppThemeCubit().fromJson(
              Map<String, dynamic>.from(themeJson as Map),
            );

    debugPrint('[THEME LOG] Initial theme resolved: $initialTheme');
    return initialTheme!;
  }

  //
}
