part of 'theme_cubit.dart';

/// * 🎛️ [AppThemeState] used in [AppThemeCubit] for managing UI preferences.
class AppThemeState extends Equatable {
  final bool isDarkTheme;

  const AppThemeState({required this.isDarkTheme});

  /// 🔄 Returns the initial default state.
  factory AppThemeState.initial() {
    return const AppThemeState(isDarkTheme: false);
  }

  /// 📝 Creates a copy of the state with updated properties.
  AppThemeState copyWith({bool? isDarkTheme}) {
    return AppThemeState(isDarkTheme: isDarkTheme ?? this.isDarkTheme);
  }

  /// 🔍 Equality check using `Equatable` for efficient state comparisons.
  @override
  List<Object> get props => [isDarkTheme];

  /// ℹ️ Readable Debug Output for Logging
  @override
  String toString() => 'AppSettingsState(isDarkTheme: $isDarkTheme)';

  ///
}
