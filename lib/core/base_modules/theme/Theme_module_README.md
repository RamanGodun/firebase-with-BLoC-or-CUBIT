# 🎨 Theme & Preferences Module Guide

*Last updated: 2025-08-01*

------------------------------------------------------------------------------------------------------------------------

## 🎯 Purpose

This module provides a **universal, declarative, and persistent theme system** for Flutter applications.
It encapsulates all theme logic (colors, fonts, spacing, shadows, typography) 
and supports **both Riverpod and Cubit/BLoC** without code duplication.



------------------------------------------------------------------------------------------------------------------------

## 🚀 Quick Start

### With Cubit:

```dart
// In MaterialApp
BlocSelector<AppThemeCubit, ThemePreferences, ThemePreferences>(
  selector: (state) => state,
  builder: (context, prefs) {
    return MaterialApp(
      theme: prefs.buildLight(),
      darkTheme: prefs.buildDark(),
      themeMode: prefs.mode,
    );
  },
);
```

### With Riverpod:

```dart
// Inside ConsumerWidget
final prefs = ref.watch(themeProvider);
MaterialApp(
  theme: prefs.buildLight(),
  darkTheme: prefs.buildDark(),
  themeMode: prefs.mode,
);
```


-------------------------------------------------------------------------------------------------------------------------

## 📦 File Structure

theme/
├── \_theme\_preferences.dart          # Core DTO for theme config
├── app\_theme\_variants.dart          # Enum of theme variants
├── theme\_builder\_x.dart             # Extension to build ThemeData
├── text\_theme/                       # Fonts & typography factory
├── extensions/                        # Extensions for ThemeMode, TextStyle
├── theme\_providers\_or\_cubits/      # Dual state management
│   ├── theme\_cubit.dart              # Cubit with HydratedBloc
│   ├── theme\_provider.dart           # Riverpod StateNotifier
│   └── theme\_storage\_provider.dart  # Persistent storage provider
├── ui\_constants/                     # Colors, spacing, shadows, icons
├── widgets\_and\_utils/
│   ├── blur\_wrapper.dart
│   ├── barrier\_filter.dart
│   ├── theme\_props\_inherited\_w\.dart
│   └── theme\_toggle\_widgets/
│       ├── theme\_picker.dart         # Dropdown/list of themes
│       └── theme\_toggler.dart        # Toggle button for theme switching


------------------------------------------------------------------------------------------------------------------------

## 🧩 Architecture & Flow

### High-level Flow

1. `ThemePreferences` defines selected variant + font.
2. `ThemeConfigNotifier` (Riverpod) or `AppThemeCubit` (Cubit) updates preferences.
3. `ThemeVariantsEnum.build()` + `ThemeCacheMixin` generate ThemeData.
4. `MaterialApp.router()` consumes light/dark theme via `prefs.buildLight()`.

### Dual-State Support

| Approach | State Logic         | Persistence         |
| -------- | ------------------- | ------------------- |
| Cubit    | AppThemeCubit       | HydratedBloc (JSON) |
| Riverpod | ThemeConfigNotifier | GetStorage          |



------------------------------------------------------------------------------------------------------------------------

## 📝 Usage

### Theme toggling

```dart
// Cubit
context.read<AppThemeCubit>().toggleTheme();

// Riverpod
ref.read(themeProvider.notifier).setTheme(ThemeVariantsEnum.dark);
```

### Font switching

```dart
ref.read(themeProvider.notifier).setFont(AppFontFamily.aeonik);
```

### UI widgets

```dart
// Theme toggler button
ThemeToggler();

// Theme picker dropdown
ThemePicker(
  onChanged: (variant) =>
    ref.read(themeProvider.notifier).setTheme(variant),
);
```



------------------------------------------------------------------------------------------------------------------------

## ❓ FAQ

> **How do I add a new theme variant?**

* Add it to `ThemeVariantsEnum` in `app_theme_variants.dart`.
* Add color tokens to `AppColors`.

> **How to use ThemeToggler?**

* Simply place `ThemeToggler()` in your UI; it will call `toggleTheme()` internally.

> **Can I use Material 3?**

* Yes, extend `ThemeVariantX.build()` with Material3 fields.



------------------------------------------------------------------------------------------------------------------------

## 💡 Best Practices

* Keep all colors and typography in `ui_constants/` and `text_theme/`.
* Never hardcode styles in UI.
* Use `ThemeCacheMixin` to avoid rebuild cost.
* Use extension methods (e.g., `context.theme`) for cleaner syntax.

## ⚠️ Avoid Pitfalls

* Do not bypass `themeProvider` or `AppThemeCubit` directly.
* Avoid mutating `ThemePreferences` — always use `copyWith`.



------------------------------------------------------------------------------------------------------------------------

## ✅ Final Notes

* Supports both **Riverpod** and **Cubit**. Theme state saved across sessions using `GetStorage` or `HydratedBloc`.
* Easily extendable via enums/configs
* Highly testable, no context-coupling
* Fully declarative + composable UI integration
* Colors, spacing, shadows, icons defined in `ui_constants/`.
* Custom fonts via `text_theme_factory`.
* Ready-to-use components like `ThemePicker` and `ThemeToggler`.


---
> > **Happy coding! 🎬✨** 
🏆 Build beautiful, scalable apps with consistent themes — architecture-first, UI-last.
---