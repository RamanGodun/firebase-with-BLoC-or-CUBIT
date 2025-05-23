# 🌐 Localization Module Manual

---

## 🔰 Overview

This module delivers a **robust and scalable localization layer** that:

- ✅ Supports full localization via [`easy_localization`](https://pub.dev/packages/easy_localization)
- 🔁 Gracefully degrades with internal fallback-only mode
- 🔒 Ensures safe key resolution across all UI
- 🧩 Provides test-friendly, override-ready architecture

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
flutter pub run easy_localization:generate \
  -S assets/translations \
  -O lib/core/shared_modules/app_localization/generated \
  -o codegen_loader.g.dart

flutter pub run easy_localization:generate \
  -f keys \
  -S assets/translations \
  -O lib/core/shared_modules/app_localization/generated \
  -o locale_keys.g.dart
```

---

## 📁 File Structure

```
app_localization/
├── code_base_for_both_options/
│   ├── _app_localizer.dart
│   ├── fallback_keys.dart
│   ├── app_strings.dart
│   ├── text_widget.dart
│   ├── key_value_x_for_text_w.dart
├── language_toggle_widget/
│   ├── _toggle_button.dart
│   └── language_option.dart
├── generated/
│   ├── codegen_loader.g.dart
│   └── locale_keys.g.dart
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
localization system that works regardless of setup.

Use it in all apps that prioritize quality UX, clean code, and safe i18n support.
