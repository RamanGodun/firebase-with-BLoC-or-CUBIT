# 🌐 Localization Module Manual

---

## 🔰 Overview

This module delivers a **robust and scalable localization layer** that:

- ✅ Supports full localization via [`easy_localization`](https://pub.dev/packages/easy_localization)
- 🔁 Gracefully degrades with internal fallback-only mode
- 🔒 Ensures safe key resolution across all UI
- 🧩 Provides test-friendly, override-ready architecture

---

## 📢 Flutter Widget Localization (DatePicker, Dialogs, etc.)

❗️ System Flutter Widgets (DatePicker, TimePicker, etc.) are NOT localized by EasyLocalization!

By default, only the strings you pass through .tr() are localized via EasyLocalization.
But system widgets (DatePicker, TimePicker, Material dialogs, built-in banners, SnackBars, etc.) use Flutter’s native internationalization pipeline.

To ensure full localization for such widgets ALWAYS set these fields in MaterialApp:

```dart
MaterialApp(
  locale: context.locale, // from EasyLocalization
  supportedLocales: context.supportedLocales, // or a direct list
  localizationsDelegates: context.localizationDelegates, // includes both EasyLocalization & Flutter
  ...
)

or manually:

MaterialApp(
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    EasyLocalization.of(context)!.delegate,
  ],
  supportedLocales: [
    const Locale('en'),
    const Locale('uk'),
    const Locale('pl'),
  ],
  ...
)
```

📝 Why is this?
Flutter widgets rely on the standard localizationsDelegates and supportedLocales for all system text.
EasyLocalization is only a wrapper for explicit .tr() calls and does NOT replace or intercept these delegates.

✅ TL;DR

If your app needs DatePicker/TimePicker/Dialog to be localized, always configure MaterialApp as above.
Otherwise, you will see only default local for these widgets.

---

## 🧠 Architecture Summary

### 🔄 Resolver Modes

| Mode                  | Description                                                            |
| --------------------- | ---------------------------------------------------------------------- |
| ✅ `EasyLocalization` | Resolves via `.tr()` from JSON keys                                    |
| 🟡 Fallback-only      | Uses static `LocalesFallbackMapper.resolveFallback(key)` or raw string |

**Core function:**

```dart
AppLocalizer.t('form.email', fallback: 'Email')
```

---

## 🔧 Bootstrap Integration (VERY IMPORTANT)

You MUST choose your mode manually in the bootstrap phase:

```dart
// ✅ Enable when using EasyLocalization
AppLocalizer.init(resolver: (key) => key.tr());

// 🟡 Enable fallback-only mode (e.g., early error handling)
AppLocalizer.init(resolver: (key) => LocalesFallbackMapper.resolveFallback(key));
```

📌 This logic goes in `AppBootstrap._initLocalization()`.

---

## 🧩 Key Components

### 🔹 `AppLocalizer`

- Central public API for resolving localization keys
- Method: `t(String key, {String? fallback})`
- Fallback-aware, `.tr()` safe, logs missing keys via `AppLogger`

### 🔹 `LocalesFallbackMapper`

- Immutable `Map<String, String>` used when localization isn’t initialized
- Safeguards all `Failure → UI` messages and splash/startup cases

### 🔹 `FallbackKeysForErrors`

- Static constants for fallback strings (e.g., timeouts, network errors)

### 🔹 `AppStrings`

- For static, non-translatable strings (e.g., test labels, debug UI text)

---

## 📦 Widgets & Text Resolution

### ✅ Shared Pattern: `_resolveText()` or `_resolveLabel()`

All UI components MUST use this pattern for safe localization fallback:

```dart
String _resolveText(String raw, String? fallback) {
  final isKey = raw.contains('.');
  return (isKey && AppLocalizer.isInitialized)
      ? AppLocalizer.t(raw, fallback: fallback ?? raw)
      : raw;
}
```

### 🔤 `TextWidget`

```dart
TextWidget(LocaleKeys.profile_email, TextType.bodySmall)
```

- Safe wrapper over `Text()` with styling + localization fallback

### ✍️ `AppTextField`

```dart
AppTextField(label: LocaleKeys.form_email, fallback: 'Email', ...)
```

- Uses `_resolveLabel()` internally for label safety

### 🧮 `KeyValueTextWidget`

```dart
KeyValueTextWidget(labelKey: LocaleKeys.profile_email, value: user.email, ...)
```

- Displays localized label + dynamic value (e.g. profile fields)

---

## ❗ Error Handling Integration

```dart
final uiText = AppLocalizer.t(failure.key!, fallback: failure.message);
```

- Used in `FailureToUIModelX`
- Always returns readable message
- Logs missing or raw strings

---

## 🛠 Setup Guide

### 1. Add Dependency

```yaml
dependencies:
  easy_localization: ^3.0.0
```

### 2. Create JSON Files in:

```
assets/translations/
  - en.json
  - uk.json
  - pl.json
```

### 3. Register Assets in `pubspec.yaml`

```yaml
flutter:
  assets:
    - assets/translations/
```

### 4. iOS Setup

```xml
<key>CFBundleLocalizations</key>
<array>
  <string>en</string>
  <string>uk</string>
  <string>pl</string>
</array>
```

### 5. Wrap App in `EasyLocalization`

```dart
runApp(AppLocalization.wrap(MyApp()));
```

### 6. Configure `MaterialApp`

```dart
MaterialApp(
  locale: context.locale,
  supportedLocales: context.supportedLocales,
  localizationsDelegates: context.localizationDelegates,
)
```

---

## ⚙️ Code Generation

You MUST generate keys + loader:

### 🧬 Install build_runner

```bash
flutter pub add --dev build_runner
```

### 🧬 Run generators

```bash
dart run easy_localization:generate \
  -S assets/translations \
  -O lib/core/base_modules/localization/generated \
  -o codegen_loader.g.dart

dart run easy_localization:generate \
  -f keys \
  -S assets/translations \
  -O lib/core/base_modules/localization/generated \
  -o locale_keys.g.dart
```

---

## 📁 Module files Structure

```
├── app_localizer.dart
├── extensions
│   └── string_x.dart
├── generated
│   ├── codegen_loader.g.dart
│   └── locale_keys.g.dart
├── localization_logger.dart
├── Localization_README.md
├── localization_wrapper.dart
├── when_app_without_localization
│   ├── app_strings.dart
│   └── fallback_keys.dart
└── widgets
    ├── key_value_text_widget.dart
    ├── language_option.dart
    ├── language_toggle_button.dart
    └── text_widget.dart
```

---

## 🧪 Testing / Debugging

Use force-init to override:

```dart
AppLocalizer.forceInit(resolver: (k) => '🔤 $k');
```

Or:

```dart
AppLocalizer.forceInit(resolver: LocalesFallbackMapper.resolveFallback);
```

Use `AppStrings` in tests for static values.

---

## ✅ Best Practices Checklist

| Task                                         | Done? |
| -------------------------------------------- | ----- |
| Use `AppLocalizer.t()` only                  | ✅    |
| Avoid `.tr()` directly                       | ✅    |
| Use `TextWidget` over `Text()`               | ✅    |
| Use `AppTextField` with `fallback`           | ✅    |
| Implement `_resolveText()` in custom widgets | ✅    |
| Log fallbacks via `AppLogger`                | ✅    |
| Generate `locale_keys.g.dart`                | ✅    |
| Wrap app with `AppLocalization.wrap()`       | ✅    |

---

## 🏁 Final Notes

> This module ensures a **resilient**, **developer-friendly**, and **future-proof**
> localization system that works regardless of setup.

Use it in all apps that prioritize quality UX, clean code, and safe i18n support.
