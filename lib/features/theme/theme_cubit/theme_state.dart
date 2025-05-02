part of 'theme_cubit.dart';

class AppThemeState extends Equatable {
  final bool isDarkTheme;

  const AppThemeState({required this.isDarkTheme});

  factory AppThemeState.initial() => const AppThemeState(isDarkTheme: false);

  AppThemeState copyWith({bool? isDarkTheme}) =>
      AppThemeState(isDarkTheme: isDarkTheme ?? this.isDarkTheme);

  @override
  List<Object> get props => [isDarkTheme];
}
