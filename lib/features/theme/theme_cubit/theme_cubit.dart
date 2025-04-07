import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

/// ⚙️ **[AppThemeCubit]** - Manages application settings, includes:
/// - 🎨 **Theme Mode:** Light / Dark mode.
/// - 🔄 **State Shape Mode:** `Listener` vs. `StreamSubscription`.

/// **State Persistence:** Uses `HydratedCubit` to restore settings after app restart.
class AppThemeCubit extends HydratedCubit<AppThemeState> {
  /// 🆕 **Initializes with persisted state or default values.**
  AppThemeCubit() : super(AppThemeState.initial());

  /// 🎨 **Toggles theme mode (Light / Dark).**
  void toggleTheme(bool isDarkMode) {
    emit(state.copyWith(isDarkTheme: isDarkMode));
  }

  /// 💾 **Serializes state to JSON for persistent storage.**
  @override
  Map<String, dynamic>? toJson(AppThemeState state) {
    return {'isDarkTheme': state.isDarkTheme};
  }

  ///@override
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
