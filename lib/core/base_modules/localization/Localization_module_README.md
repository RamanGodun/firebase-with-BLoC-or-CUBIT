# 🌍 Localization Module Guide

_Last updated: 2025-08-01_

---

## 🎯 GOAL

This module provides a **universal, modular, and scalable localization system** for Flutter apps, based on `EasyLocalization`.
It supports both **Riverpod** and **Cubit/BLoC** without code duplication and enables fully declarative, testable, and fallback-ready i18n.

- 🧩 Designed for Clean Architecture and state-agnostic flows
- 🌐 Built for modular codebases: localization is completely isolated
- ⚙️ Supports pluralization and boot-time and fallback initialization modes
- 🧪 Works in tests, CLI, and no-context environments

---

## 🚀 Setup Guide

---

### 1. Add Dependency

```yaml
dependencies:
  easy_localization: ^3.0.0
```

---

### 2. Create JSON Files in `assets/translations/`:

```
assets/translations/
  - en.json
  - uk.json
  - pl.json
```

---

### 3. Register Assets in `pubspec.yaml`

```yaml
flutter:
  assets:
    - assets/translations/
```

---

### 4. iOS Setup

```xml
<key>CFBundleLocalizations</key>
<array>
  <string>en</string>
  <string>uk</string>
  <string>pl</string>
</array>
```

---

### 5. ⚙️ Bootstrap Integration (before `runApp()`)

📌 This logic goes in `AppBootstrap._initLocalization()`.
You MUST choose your mode manually in the bootstrap phase:

```dart
Future<void> initEasyLocalization() async {
  await EasyLocalization.ensureInitialized();

  /// 🌍 Sets up the global localization resolver for the app (when using EasyLocalization)
  AppLocalizer.init(resolver: (key) => key.tr());
    // ? when app without localization, then instead previous method use next:
    // AppLocalizer.initWithFallback();

  // 🟡 Enable fallback-only mode (e.g., early error handling)
  AppLocalizer.init(resolver: (key) => LocalesFallbackMapper.resolveFallback(key));
}
```

---

### 6. Wrap App in `EasyLocalization`

#### In app with Riverpod as state manager:

```dart
runApp(
  ProviderScope(
    parent: GlobalDIContainer.instance,
    child: AppLocalizationShell(),
  ),
);
```

#### In app with Cubit/BLoC as state manager:

```dart
runApp(GlobalProviders(child: AppLocalizationShell()));
```

---

### 7. Call `LocalizationWrapper.configure` in `AppLocalizationShell`

```dart
class AppLocalizationShell extends StatelessWidget {
  const AppLocalizationShell({super.key});

  @override
  Widget build(BuildContext context) {
    return LocalizationWrapper.configure(const AppRootViewShell());
  }
}
```

---

### 8. Configure `MaterialApp`

```dart
MaterialApp.router(
  locale: context.locale,
  supportedLocales: context.supportedLocales,
  localizationsDelegates: context.localizationDelegates,
  // ...theme, router, overlays
);
```

Localization is injected into `MaterialApp.router()` for hot reload support.

---

### ⚙️ 9. Use Code Generation.

You MUST generate keys + loader:

- 🧬 Install build_runner

```bash
flutter pub add --dev build_runner
```

- 🧬 Run generators

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

## 📝 Usage

- Use only generated keys — never hardcode translation keys or locale codes in the UI/business logic.

### Accessing Translations

```dart
Text(LocaleKeys.profile_username.tr()),
Text(LocaleKeys.welcome_message.tr(args: [userName])),
```

### Switching Languages

```dart
// Switch to Ukrainian, for example:
context.setLocale(const Locale('uk', 'UA'));
```

### Pluralization & Contextualization

```dart
LocaleKeys.items_count.trPlural(count),
LocaleKeys.welcome_gender.tr(gender: user.gender),
```

### ✅ Shared Pattern: `_resolveText()` or `_resolveLabel()`

All UI components MUST use this pattern for safe localization fallback:

```dart
  String _resolveText(String raw, String? fallback) {
    final isLocalCaseKey = raw.contains('.');
    if (isLocalCaseKey && AppLocalizer.isInitialized) {
      return AppLocalizer.translateSafely(raw, fallback: fallback ?? raw);
    }
    return raw;
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

---

## 🧩 Architecture & Flow

> **Declarative, DI-agnostic, and robust — designed for production & multi-language growth.**

- **Single entrypoint:** All localization setup and context integration flows through `LocalizationWrapper.configure(...)`.
- **App-level injection:** Locale and delegates always injected at the highest possible widget (usually `MaterialApp.router`).
- **Generated keys:** Access all translations via generated constants (`LocaleKeys`) — never use hardcoded keys.
- **Hot reload & async switching:** Language/locale can be switched at runtime, with instant app reload. Supports both sync and async switching.
- **Fallbacks & custom resolvers:** Built-in fallback for missing translations; allows for custom resolution logic per app or module.
- **Pluralization/context:** Supports plural, gender, and context-based translations out-of-the-box.
- **Modular:** Localization is completely isolated and testable — no hidden app dependencies.
- **Hot reload support** Locale, supportedLocales, and delegates are always injected into MaterialApp using `context.*` for hot reload support.

### Typical Localization Flow

1. **App bootstraps**, ensuring EasyLocalization is initialized before app launch.
2. **LocalizationWrapper** injects all context and translation delegates.
3. **MaterialApp.router** is configured with locale, supportedLocales, and delegates from context.
4. **Keys are used via LocaleKeys** everywhere in code (no magic strings).
5. **Language can be switched** at runtime — UI reloads automatically.

---

## 📦 File Structure

- No tight coupling with app-level DI or state management. Only localization logic inside this module.
  Each folder and file is strictly responsible for a single concern (core, assets, extensions, context, keys, etc). Example structure:

```
localization/
      .
      ├── core_of_module
      │   ├── init_localization.dart        # Central public API for resolving localization keys
      │   └── localization_wrapper.dart     # App-level wrapper injecting context
      |
      ├── generated                         # must be created via easy\_localization codegen
      │   ├── codegen_loader.g.dart
      │   └── locale_keys.g.dart
      |
      ├── module_widgets
      │   ├── key_value_text_widget.dart
      │   ├── language_toggle_button
      │   │   ├── language_option.dart
      │   │   └── toggle_button.dart
      │   └── text_widget.dart
      |
      ├── utils                             # Utils, including declarative translation access (tr, plural, args)
      │   ├── localization_logger.dart
      │   ├── string_x.dart
      │   └── text_from_string_x.dart
      |
      ├── without_localization_case
      |   ├── app_strings.dart              # For static, non-translatable strings (e.g., test labels, debug UI text)
      |   └── fallback_keys.dart            # Constants used in tests or fallback mode
      |
      └── Localization_module_README.md
```

- Also there is assets/translations folder with all locale JSON files

---

## ❓ FAQ

> **How do I add a new language?**

- Add a new JSON file (e.g. `fr-FR.json`) to `assets/translations/`.
- Add the new locale to `supportedLocales` in your bootstrap/init config.
- Add all translation keys to the new file.

---

> **How do I use custom pluralization or context?**

- Use `.trPlural()`, `.tr(gender: ...)`, or context-based `.tr(context: ...)` on LocaleKeys.
- See EasyLocalization docs for advanced syntax.

---

> **How do I unit-test translations?**

- Access all translations via generated keys (`LocaleKeys`).
- Use EasyLocalization's testing utilities, or mock context/locale for custom unit tests.

---

> **Can I lazy-load or split translation files?**

- Yes, EasyLocalization supports async/custom loaders and modular asset splits.
- Configure loaders in the module's init code if needed.

---

> **How do I add keys?**

- Add to all translation files and regenerate `locale_keys.g.dart`.
- Use keys everywhere for full compile-time safety.

---

> **How perform Error Handling Integration?**

````dart
final uiText = AppLocalizer.t(failure.key!, fallback: failure.message);
    - Used in `FailureToUIModelX`
    - Always returns readable message
    - Logs missing or raw strings



-----------

> **Do this module localize system widgets?**

* `EasyLocalization` does not localize system widgets (DatePickers, TimePickers, Built-in material widgets, etc).
❗️ By default, only the strings you pass through .tr() are localized via EasyLocalization.

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
````

This injects both EasyLocalization and native ones:

- GlobalMaterialLocalizations
- GlobalCupertinoLocalizations
- GlobalWidgetsLocalizations

---

## 💡 Best Practices

- Always use `LocaleKeys` — never hardcode translation keys in code.
- Inject localization context/delegates as high as possible in the widget tree (`MaterialApp.router`).
- Use extension methods for context locale access and switching — never call EasyLocalization statically in UI.
- Place all translation assets in `/assets/translations/` for easy scaling/maintenance.
- Always regenerate keys after adding translations.
- Prefer context-based pluralization and gender forms for natural language.
- Keep translation files clean and consistent across languages — avoid key drift or inconsistent structure.
- Document custom logic, pluralization rules, or loaders at module level.
- Implement `_resolveText()` in custom widgets

---

### ⚠️ Avoid Pitfalls

- Never use hardcoded strings or keys for translations — always use `LocaleKeys`.
- Never inject locale, delegates, or supportedLocales manually — always use context extensions.
- Never couple localization logic with business/state logic — always keep this module isolated.
- Don’t add translation keys in only one language — always update all translation files in sync.
- Never override built-in EasyLocalization logic unless absolutely necessary.
- Avoid large, monolithic translation files — modularize by features for scale.

---

## ✅ Final Notes

- Fully modular: works with both Riverpod and Cubit/BLoC — no code duplication
- Highly testable: all logic and context extensions are isolated
- Built for scale: add/remove languages and keys with minimal friction
- Compile-time safety: all translation keys are generated and type-safe and fallback aware
  All translations are strongly typed via `LocaleKeys`
- Production-ready: supports async switching, fallbacks, pluralization, and context
- Clean separation: all localization code, assets, and logic live in this module only

---

> **Happy coding! 🌍✨**
> Build robust, scalable Flutter apps for every market, language, and audience and ... architecture-first.

---
