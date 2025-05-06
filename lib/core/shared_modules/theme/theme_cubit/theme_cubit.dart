import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

///* ⚙️[AppThemeCubit] - Manages:
///    - 🎨 Theme Mode: Light / Dark mode.
///    - State Persistence: using [HydratedCubit] to restore settings after app restart.
final class AppThemeCubit extends HydratedCubit<AppThemeState> {
  /// 🆕 Initializes with persisted state or default values.
  AppThemeCubit() : super(AppThemeState.initial());

  /// 🎨 [toggleTheme] toggles theme mode (Light / Dark).
  void toggle() => emit(state.copyWith(isDarkTheme: !state.isDarkTheme));

  /// 💾 [toJson] serializes state to JSON for persistent storage.
  @override
  Map<String, dynamic>? toJson(AppThemeState state) {
    return {'isDarkTheme': state.isDarkTheme};
  }

  /// 💾 [fromJson] de-serializes state from  JSON (from persistent storage).
  @override
  AppThemeState? fromJson(Map<String, dynamic> json) {
    try {
      return AppThemeState(isDarkTheme: json['isDarkTheme'] as bool? ?? false);
    } catch (_) {
      return null;
    }
  }

  ///
}
