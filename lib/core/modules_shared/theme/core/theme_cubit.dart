import 'package:hydrated_bloc/hydrated_bloc.dart';

import '_theme_config.dart';
import 'theme_type_enum.dart.dart';
import '../text_theme/text_theme_factory.dart';

/// 🎨 [AppThemeCubit] — manages [ThemeConfig] (theme variant + font)
/// ✅ Uses [HydratedCubit] for state persistence
final class AppThemeCubit extends HydratedCubit<ThemeConfig> {
  ///---------------------------------------------------------

  AppThemeCubit()
    : super(const ThemeConfig(theme: ThemeTypes.light, font: FontFamily.sfPro));

  /// 🌓 Update theme only
  void setTheme(ThemeTypes theme) => emit(state.copyWith(theme: theme));

  /// 🔤 Update font only
  void setFont(FontFamily font) => emit(state.copyWith(font: font));

  /// 🧩 Update both theme and font
  void setThemeAndFont(ThemeTypes theme, FontFamily font) =>
      emit(ThemeConfig(theme: theme, font: font));

  /// 💾 Serialize state to JSON for persistence
  @override
  Map<String, dynamic>? toJson(ThemeConfig state) {
    return {'theme': state.theme.name, 'font': state.font.name};
  }

  ///
  void toggleTheme() {
    final newTheme =
        state.theme == ThemeTypes.dark ? ThemeTypes.light : ThemeTypes.dark;
    emit(state.copyWith(theme: newTheme));
  }

  /// 💾 Deserialize state from JSON
  @override
  ThemeConfig? fromJson(Map<String, dynamic> json) {
    try {
      final theme = ThemeTypes.values.firstWhere(
        (e) => e.name == json['theme'],
        orElse: () => ThemeTypes.light,
      );
      final font = FontFamily.values.firstWhere(
        (e) => e.name == json['font'],
        orElse: () => FontFamily.sfPro,
      );
      return ThemeConfig(theme: theme, font: font);
    } catch (_) {
      return null;
    }
  }
}
