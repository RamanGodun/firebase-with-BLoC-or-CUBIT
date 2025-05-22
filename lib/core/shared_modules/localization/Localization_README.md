# 🌐 Localization Module Manual

## 🔰 Overview

This module offers a **robust, flexible, and fail-safe localization system** that works:

* ✅ With full localization (`easy_localization`)
* 🚫 Or even without it, in fallback-only mode

It ensures UI texts, form labels, and error messages remain user-friendly and consistent across both scenarios.

---

## 🧠 Core Architecture

### 📌 Localization Modes

| Mode                    | Description                                                     |
| ----------------------- | --------------------------------------------------------------- |
| ✅ With EasyLocalization | Resolves keys from JSON assets via `.tr()`                      |
| 🚫 Without Localization | Uses fallback map for errors & returns raw key or fallback text |

### 🔄 Central Resolver: `AppLocalizer`

```dart
AppLocalizer.t('profile.name', fallback: 'Name')
```

* Smartly routes to `.tr()` if initialized
* Else, uses fallback key map or raw string
* Logs fallback usages via `AppLogger`

---

## 🧩 Key Classes

### 🔹 `AppLocalizer`

* Public API: `t(String key, {String? fallback})`
* Internally used by all UI text widgets
* Safe and universal

### 🔹 `LocalesFallbackMapper`

* Used when EasyLocalization is **not** initialized
* Contains key-to-message mappings (used in `Failure` cases)

```dart
'failure.network.no_connection' → 'No internet connection'
```

### 🔹 `FallbackKeysForErrors`

* Stores static fallback strings for known error types

```dart
static const timeout = 'Request timeout. Try again.';
```

### 🔹 `AppStrings`

* Stores **non-translatable**, static app strings
* Used for constants like field hints in tests or internal labels

---

## 🧾 Localization in Widgets

### 🔤 `TextWidget`

Drop-in replacement for `Text()` with safe localization built-in.

```dart
TextWidget(LocaleKeys.profile_email, TextType.bodySmall)
```

**Internal Logic:**

* If value looks like a key (e.g., contains dot `.`) and `AppLocalizer.isInitialized`, resolves via `AppLocalizer.t()`
* Else returns fallback or original string

Private method `_resolveText()` encapsulates the logic.

### ✍️ `AppTextField`

Used for input forms with localized label support:

```dart
AppTextField(
  label: LocaleKeys.form_email,
  fallback: 'Email',
  ...
)
```

Private method `_resolveLabel()` mirrors `TextWidget._resolveText()` logic.

**Both widgets work the same in both modes** (with or without EasyLocalization).

---

## ❗ Error Handling Integration

### 🎯 Domain → UI: `Failure` → `FailureUIModel`

Inside extension `FailureToUIModelX`:

```dart
final resolvedText = AppLocalizer.t(translationKey!, fallback: message);
```

This ensures:

* UI always displays readable string
* Whether app uses EasyLocalization or not
* Logging of missing translations

### 🔒 Why Fallback Classes Matter

| Class                   | Role                                                              |
| ----------------------- | ----------------------------------------------------------------- |
| `LocalesFallbackMapper` | Maps known failure keys → messages (no EasyLocalization required) |
| `FallbackKeysForErrors` | Stores static fallback strings used by the mapper                 |

These act as a **guaranteed backup** layer, especially for:

* Minimal apps without EasyLocalization
* Early initialization stages (e.g., splash errors)

---

## 🛠 Setup Instructions

### 1. Add Dependency

```yaml
dependencies:
  easy_localization: ^3.0.0
```

### 2. Create JSON Files

Place in `assets/translations/`:

```bash
en.json
uk.json
pl.json
```

Minimal `en.json` example:

```json
{
  "profile": {
    "name": "Name",
    "email": "Email"
  }
}
```

### 3. Register Assets in `pubspec.yaml`

```yaml
flutter:
  assets:
    - assets/translations/
```

### 4. iOS Setup (`Info.plist`)

```xml
<key>CFBundleLocalizations</key>
<array>
  <string>en</string>
  <string>uk</string>
  <string>pl</string>
</array>
```

### 5. Initialize Localization

```dart
await EasyLocalization.ensureInitialized();
AppLocalizer.init(resolver: (key) => key.tr());
```

🔁 **Or fallback mode only:**

```dart
AppLocalizer.init(
  resolver: (key) => LocalesFallbackMapper.resolveFallback(key),
);
```

### 6. Wrap Your App

```dart
runApp(AppLocalization.wrap(MyApp()));
```

### 7. Integrate with `MaterialApp`

```dart
MaterialApp(
  locale: context.locale,
  supportedLocales: context.supportedLocales,
  localizationsDelegates: context.localizationDelegates,
)
```

---

## ⚙️ Code Generation (Required)

Run the following to generate loader + keys:

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

## ✅ Summary Reference Table

| Layer            | With EasyLocalization      | Fallback Mode (No lib)         |
| ---------------- | -------------------------- | ------------------------------ |
| `TextWidget`     | `.tr()` → localized string | raw key or fallback            |
| `AppTextField`   | localized label from key   | fallback label string          |
| `FailureUIModel` | key → localized message    | mapped via fallback dictionary |

---

## 📁 File Structure Overview

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

## 👨‍💻 Best Practices

✅ Always:

* Use `AppLocalizer.t()` instead of `.tr()` in domain/middleware/UI logic
* Prefer `TextWidget` over native `Text()` — it’s safer
* Use `AppTextField` for form fields — auto-localized labels
* Maintain fallback key coverage in `LocalesFallbackMapper`
* Log untranslated keys using `AppLogger`

🛑 Avoid:

* Direct use of `.tr()` in deeply nested logic
* Hardcoded strings in UI — use localization keys or `AppStrings`

---
