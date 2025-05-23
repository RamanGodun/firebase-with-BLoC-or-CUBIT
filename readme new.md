## 📦 Core Modules

> The foundational layer providing infrastructure, UI standards, and clean integrations
> across all features in a modular, testable, and scalable architecture.

---

### 🧭 Navigation (GoRouter)

- **Declarative + Auth-aware** routing using `GoRouter`
- `AppRouterConfig` provides `delegate`, `parser`, `provider`
- `AuthRedirectMapper` routes users based on `AuthBloc` state
- `GoRouterRefresher` rebuilds on auth state stream changes
- `OverlayNavigatorObserver` resets overlays on navigation

```dart
MaterialApp.router(
  routerDelegate: AppRouterConfig.delegate,
  routeInformationParser: AppRouterConfig.parser,
  routeInformationProvider: AppRouterConfig.provider,
);
```

---

### 🎨 Theming System

- Defined via `AppThemeType`, `AppThemeConfig`, and `AppThemes`
- Supports `light`, `dark`, `amoled`, and `glass` modes
- Persisted with `HydratedBloc`
- Typography resolved via `AppTextStyles`

```dart
BlocBuilder<AppThemeCubit, AppThemeState>(
  builder: (_, state) => MaterialApp(
    theme: AppThemes.resolve(AppThemeType.light),
    darkTheme: AppThemes.resolve(AppThemeType.amoled),
    themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
  ),
);
```

---

### 🧩 Overlay Animation Engine

- Modular overlay lifecycle handler using `OverlayDispatcher`
- `AnimatedOverlayWrapper` handles animation and auto-dismiss
- Platform-aware engines: `IOSOverlayAnimationEngine`, `AndroidOverlayAnimationEngine`
- Supports dialog, snackbar, banner, toast
- Declarative `context.showError(...)` API

---

### 🛡️ Error Handling System

- Dual paradigm: AZER (fold) and DSL-style (`.match()`, `DSLLikeResultHandler`)
- Centralized `FailureMapper`, `FailureUIModel`, and `Consumable<T>`
- Unified result types: `ResultFuture<T> = Future<Either<Failure, T>>`
- Error overlay via `OverlayDispatcher`

```dart
await useCase().matchAsync(
  onFailure: (f) => emit(Error(f)),
  onSuccess: (d) => emit(Success(d)),
);
```

---

### 📑 Form Fields System

- Built on `Formz` with clean validation classes (Email, Password, etc)
- Shared widgets via `InputFieldFactory`, `AppTextField`, `FormSubmitButton`
- Built-in status helpers: `FormzStatusX`
- FocusNode manager via `useAuthFocusNodes()`

```dart
InputFieldFactory.create(
  type: InputFieldType.email,
  errorText: state.email.uiError,
  onChanged: context.read<SignInCubit>().emailChanged,
);
```

---

### 🌐 Localization Layer

- Powered by `easy_localization`
- Centralized `AppLocalizer.t(...)` with fallback support
- Static keys via `locale_keys.g.dart`
- Optional fallback-only mode with `LocalesFallbackMapper`
- Integrated in `AppBootstrap` and `AppMaterialAppRouter`

---

### 🧰 Shared Presentation

- Core widgets like `LoaderWidget`, `CustomAppBar`, `RedirectTextButton`
- Styling constants via `UIConstants`, `AppColors`, `AppIcons`, `AppSpacing`
- All widgets fully theme-aware and localizable

---

### 🧪 Utils & Extensions

- Extensions: `ContextMediaX`, `WidgetAlignX`, `WidgetPaddingX`, `StringX`, etc.
- Helpers: `Debouncer`, `AppKeys`, `typedefs`, `DateTimeX`, `DurationX`
- Fully tested and used across all features

---

### ✅ Core Principles

- Clean Architecture (Data → Domain → Presentation)
- SOLID, SRP, and testability in all utilities
- Platform-native behavior (iOS/macOS inspired)
- Declarative, type-safe, and DI-compatible

> Each module is isolated, injectable, and scalable. Easily testable, override-ready, and designed with Flutter best practices for real-world apps.
