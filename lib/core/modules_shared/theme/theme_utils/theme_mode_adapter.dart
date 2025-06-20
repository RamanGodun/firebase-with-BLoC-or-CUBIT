import 'package:flutter/material.dart' show ThemeMode;

/// 🌗 [IAppThemeState] — Platform-agnostic theme interface.
/// ✅ Used to unify access to ThemeMode across Bloc and Riverpod.
abstract interface class IAppThemeState {
  ThemeMode get mode;
}

////

////

/// 🌗 [ThemeModeAdapter] — Wraps ThemeMode for compatibility with IAppThemeState.
final class ThemeModeAdapter implements IAppThemeState {
  const ThemeModeAdapter(this._mode);
  final ThemeMode _mode;

  @override
  ThemeMode get mode => _mode;
}
