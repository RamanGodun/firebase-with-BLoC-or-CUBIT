part of 'theme_cubit.dart';

/// 🎨 [AppThemeState] — Represents current theme mode (light/dark)
/// ✅ Immutable + equatable state for [AppThemeCubit]

final class AppThemeState extends Equatable {
  //----------------------------------------

  /// 🌙 Whether dark mode is enabled
  final bool isDarkTheme;

  /// 🆕 Constructor for [AppThemeState]
  const AppThemeState({required this.isDarkTheme});

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
