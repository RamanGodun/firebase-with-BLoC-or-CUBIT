part 'theme_storage_provider.dart';

/*

! For app on Riverpod instead cubit use next providers: 




/// 🧩 [themeProvider] — StateNotifier for switching themes with injected storage
//
final themeProvider =
    StateNotifierProvider<ThemeConfigNotifier, ThemePreferences>(
      ///
      (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
      //
    );

////

////

/// 🌗 [ThemeConfigNotifier] — Manages the ThemeMode state with persistent storage
//
class ThemeConfigNotifier extends StateNotifier<ThemePreferences> {
  ///----------------------------------------------------------
  //
  final GetStorage _storage;
  static const _themeKey = 'selected_theme';
  static const _fontKey = 'selected_font';

  ThemeConfigNotifier(this._storage)
    : super(
        ThemePreferences(
          theme: _loadTheme(_storage),
          font: _loadFont(_storage),
        ),
      );

  ///

  /// 🧩 Load saved theme from storage
  static ThemeVariantsEnum _loadTheme(GetStorage storage) {
    //
    final stored = storage.read<String>(_themeKey);
    return ThemeVariantsEnum.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => ThemeVariantsEnum.light,
    );
  }

  /// 🔤 Load saved font
  static AppFontFamily _loadFont(GetStorage storage) {
    //
    final stored = storage.read<String>(_fontKey);
    return AppFontFamily.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => AppFontFamily.sfPro,
    );
  }

  /// 🌓 Update theme only
  void setTheme(ThemeVariantsEnum theme) {
    //
    state = ThemePreferences(theme: theme, font: state.font);
    _storage.write(_themeKey, theme.name);
  }

  /// 🔤 Update font only
  void setFont(AppFontFamily font) {
    //
    state = ThemePreferences(theme: state.theme, font: font);
    _storage.write(_fontKey, font.name);
  }

  /// 🧩 Update both at once
  void setThemeAndFont(ThemeVariantsEnum theme, AppFontFamily font) {
    //
    state = ThemePreferences(theme: theme, font: font);
    _storage.write(_themeKey, theme.name);
    _storage.write(_fontKey, font.name);
  }

  //
}




 */
