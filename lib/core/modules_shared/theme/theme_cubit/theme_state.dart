part of 'theme_cubit.dart';

/// 🎨 [AppThemeState] — Represents current theme mode (light/dark)
/// ✅ Immutable + equatable state for [AppThemeCubit]
/// ✅ [AppThemeState] — Implements common interface for Builder.

final class AppThemeState extends Equatable implements IAppThemeState {
  //----------------------------------------

  /// 🌙 Whether dark mode is enabled
  final bool isDarkTheme;

  /// 🆕 Constructor for [AppThemeState]
  const AppThemeState({required this.isDarkTheme});

  /// 🔁 Returns the current [ThemeMode] based on [isDarkTheme] flag.
  @override
  ThemeMode get mode => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  /// 🟢 Initial state: Light mode (false)
  factory AppThemeState.initial() => const AppThemeState(isDarkTheme: false);

  /// 🔁 Creates a copy with optional override
  AppThemeState copyWith({bool? isDarkTheme}) =>
      AppThemeState(isDarkTheme: isDarkTheme ?? this.isDarkTheme);

  /// 🧪 Equatable props for efficient state comparison
  @override
  List<Object> get props => [isDarkTheme];

  //
}
