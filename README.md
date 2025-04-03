# Riverpod Reminder

[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

---

## ✨ Project Overview

**Riverpod Reminder** is a highly modular and scalable Flutter application serving as a personal **reference companion** and **interactive playground** for mastering **Riverpod** — the modern, robust state management library.

Designed with both clarity and flexibility in mind, this app helps developers:

- ✅ **Understand** Riverpod's essential provider types and state patterns
- 🚀 **Experiment** with async flows, lifecycle management, and overrides
- 🔁 **Compare** manual vs code-generated providers
- 🧠 **Deepen** knowledge through hands-on, real-world scenarios

Whether you're preparing for an interview, onboarding teammates, or revisiting advanced state logic — **Riverpod Reminder** functions as your centralized, organized **knowledge base** for everything Riverpod.

---

### ⚙️ App Modes via `AppConfig`

Riverpod Reminder is highly configurable through compile-time flags defined in `AppConfig`. This allows seamless switching between various architectural modes:

#### 🧭 Navigation Mode

- `isUsingGoRouter = true` →

  - Enables full GoRouter-based navigation
  - Includes **nested routes**, **StatefulShellRoute**, **BottomNavigationBar**, and **auth guards**
  - Demonstrates public/private route flows with reactive redirects

- `isUsingGoRouter = false` →
  - Displays a **dynamic homepage** with a dropdown list of 12 Riverpod features
  - Navigation is handled via enhanced enums and a simple routing helper

#### 🧬 Code Generation Mode

- `isUsingCodeGeneration = true` →

  - Enables **@riverpod**, **@freezed**, and other codegen tools for declarative provider generation
  - Active in features like 1, 3, 4, etc.

- `isUsingCodeGeneration = false` →
  - Falls back to **manually written providers** to demonstrate the differences side-by-side

#### 🔁 State Management Mode

- `isUsingStateNotifierProvider = true` →

  - Feature 5 uses `StateNotifierProvider` with **immutable Freezed-based state**

- `isUsingStateNotifierProvider = false` →
  - Switches to `ChangeNotifierProvider` with **mutable logic**

---

## 🏐 Purpose

**Riverpod Reminder** is built as a robust and interactive **developer utility** tailored for Flutter engineers who want to elevate their understanding of state management using **Riverpod v2** — across both **manual** and **codegen** paradigms.

This app is more than a showcase — it’s a hands-on **knowledge base**, **experimentation lab**, and **learning accelerator**, purpose-built to serve:

- 🔁 **Everyday reference** for refreshing Riverpod providers, patterns, modifiers, and lifecycles
- 🧪 **Experimentation sandbox** for testing scoped overrides, lifecycle behaviors, or advanced patterns in isolation
- 🚀 **Onboarding toolkit** for teams adopting Riverpod or transitioning to clean state management architecture
- 🧩 **Mini-app launcher** with 14+ interactive features demonstrating real-world usage scenarios
- 🎓 **Educational companion** for interview prep, internal training, or deep dives into async behavior, caching, navigation, or performance tuning

> Whether you're exploring **GoRouter integration**, toggling between **codegen/manual**, comparing **StateNotifier vs ChangeNotifier**, or inspecting provider lifecycles — this app provides a structured yet flexible environment to **learn, compare, iterate, and evolve** your Riverpod expertise.

---

## 🏠 Project Structure

### 🏢 `core/`

> Shared infrastructure, constants, configs, and UI utilities used across all features.

#### `core/domain/`

- **app_constants/**

  - `app_constants.dart`: Generic constants
  - `app_strings.dart`: Static UI strings

- **config/**

  - **observer/**: Custom logging observers for AsyncValues
  - **router/**: GoRouter config, route names/paths, auth provider
  - `app_config.dart`: Global switches for router mode, codegen, state approach

- **models/**

  - `activity_model/`, `product_model/`: Freezed models with serialization
  - `enums.dart`: App-wide enums (Cities, Features, etc.)

- **providers/**

  - **dio_and_retrofit/dio_providers/**: API clients per domain
  - **errors_handling/**: Error dialog simulation
  - **sh_prefs/**: SharedPreferences layer
  - `features_provider.dart`: Tracks current feature selection

- **utils_and_services/**
  - `helpers.dart`: Formatters, navigation helpers
  - `dialogs_service.dart`: Alert logic
  - **overlay/**: Custom UI overlays and notifications

#### `core/ui/`

> Centralized UI layer: theming, widgets, layout components

- **\_theming/**

  - `app_theme.dart`: Light/Dark theme setup
  - `text_styles.dart`: Central typography
  - `theme_provider.dart`: Riverpod state manager for themes

- **pages/**

  - `home_page.dart`: Homepage with dynamic feature-based routing
  - `other_page.dart`: Placeholder/testing UI

- **widgets/**
  - **buttons/**
    - `custom_button.dart`, `custom_floating_button.dart`
    - `outlined.dart`: For standard secondary actions
    - `custom_button_4_go_router.dart`: Special button for GoRouter testing
    - `get_weather_button.dart`: Feature-specific action button
  - `custom_app_bar.dart`, `activity_widget.dart`, `custom_list_tile.dart`
  - `feature_selection_dialog.dart`: Dropdown feature picker dialog
  - `alert_dialog.dart`, `mini_widgets.dart`, `text_widget.dart`

### 📚 `core/docs/`

> ✅ Centralized, markdown-based **Riverpod knowledge base**

Each file is a self-contained **guide**, **cheat sheet**, or **concept explanation** covering specific Riverpod topics.

📌 Use this folder as the **source of truth** when:

- Onboarding new developers
- Debugging provider behavior
- Comparing architectural approaches or patterns

> Organized for clarity, consistency, and long-term maintainability.

---

### 🧰 Features

Each feature is located in `features/<index>_<feature_name>/`, fully modular and almost each one with separation into `domain/` and `presentation/`.

---

| #   | Feature                | Description                                                                                                                              |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 0   | **GoRouter**           | GoRouter navigation with guards, scoped auth, and stateful routing                                                                       |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | **Simple Providers**   | Demonstrates Provider, Provider.autoDispose, Provider.family, and Provider.autoDispose.family using both manual and                      |
|     |                        | generated styles. Lifecycle behavior is observable through logger integration and switching is handled via AppConfig.                    |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 2   | **State Provider**     | Showcases `StateProvider`, `StateProvider.autoDispose`, `StateProvider.family`, and `StateProvider.autoDispose.family`.                  |
|     |                        | Each modifier demonstrates different lifecycle and caching behavior. Includes dynamic reset, manual invalidation,                        |
|     |                        | critical state listening (with dialog alerts), and UI-driven background changes. Contains a creative mini-game to explore state logic.   |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 3   | **Future Provider**    | Demonstrates `FutureProvider`, `FutureProvider.autoDispose`, `FutureProvider.family`, and `FutureProvider.autoDispose.family`.           |
|     |                        | Features list fetching, user details navigation, refresh indicators, caching via `ref.keepAlive()`, and selective invalidation.          |
|     |                        | Codegen/manual switching is handled via `AppConfig`, with lifecycle logging and UI-based loading/error states fully integrated.          |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 4   | **Stream Provider**    | Showcases `StreamProvider` with both `autoDispose` and `keepAlive` behavior depending on mode.                                           |
|     |                        | Ticker emits values every second using `Stream.periodic` with `.take(n)` logic. Includes lifecycle logging, UI formatting,               |
|     |                        | and disposal behavior comparison between manual and generated providers. Switching handled via `AppConfig`.                              |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 5   | **StateNotifier**      | Compares mutable vs immutable state approaches using `ChangeNotifierProvider` and `StateNotifierProvider`.                               |
|     | /                      | Features a shared Todos UI, with dynamic switching via `AppConfig`.                                                                      |
|     | **ChangeNotifier**     | - `ChangeNotifier`: mutable list with direct mutation and `notifyListeners()`                                                            |
|     |                        | - `StateNotifier`: immutable list with `copyWith()` and explicit state replacement                                                       |
|     |                        | Demonstrates shared widgets, dynamic builder logic, and integration with hooks for input.                                                |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 6   | **Notifier Provider**  | Highlights modern `Notifier` API with `NotifierProvider` and `NotifierProvider.autoDispose.family`.                                      |
|     | **(Riverpod v2)**      | - Shows counter logic with `keepAlive` and `autoDispose` behaviors                                                                       |
|     |                        | - Demonstrates two distinct state shapes:                                                                                                |
|     |                        | - Enum-based: `status`, `error`, `data` in a Freezed DTO                                                                                 |
|     |                        | - Sealed class-based: fully pattern-matchable `state` with `when()`/`switch`                                                             |
|     |                        | - Explores code reuse, instance lifecycle tracking, delayed refresh, and UI fallback on failure                                          |
|     |                        | - Integrated with error simulation, floating action controls, and dynamic refresh options                                                |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 7   | **Async Provider**     | Demonstrates `AsyncNotifier` pattern for loading async data with built-in guards and error fallback logic.                               |
|     |                        | - Two state shapes explored:                                                                                                             |
|     |                        | - Enum-based (`status`, `data`, `error`) using `Freezed` DTO                                                                             |
|     |                        | - Sealed class (`when()`/`switch`) with explicit state variants                                                                          |
|     |                        | - Error simulation for retry logic, lifecycle tracking                                                                                   |
|     |                        | - Pattern-based UI rendering with visual fallback to last successful state (prevWidget cache)                                            |
|     |                        | - Auto-loaded on initialization (`fetchActivity` triggered in `build()`)                                                                 |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 8   | **AsyncNotifier**      | Refined logic separation with `AsyncNotifier`, showcasing declarative loading, error handling, and side-effect-free state flow.          |
|     | **Provider**           | - Auto-initialized fetch via `build()`, lifecycle tracked                                                                                |
|     |                        | - Demonstrates two real-life cases:                                                                                                      |
|     |                        | - **Activity Fetcher** with `AsyncValue.guard`, error dialog, and conditional refresh                                                    |
|     |                        | - **Counter Logic** with increment/decrement, artificial delay, and error simulation                                                     |
|     |                        | - Uses `AsyncValue` extensions for logging/debugging (`props`, `.isLoading`, etc.)                                                       |
|     |                        | - Fully reactive UI rendering (`when(...)`, skipLoadingOnRefresh, skipError)                                                             |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 9   | **AsyncStream**        | Async streams using `StreamProvider` and `Stream + AsyncNotifier` combo for reactive ticking logic.                                      |
|     | **Provider**           | - Ticker page: demonstrates pure `StreamProvider.autoDispose`, lifecycle-aware and stateless                                             |
|     |                        | - Timer page: hybrid approach with `Stream + AsyncNotifier`, enabling full control: start/pause/resume/reset                             |
|     |                        | Uses `Stream.periodic().take(n)` + `StreamSubscription` for tick control                                                                 |
|     |                        | State managed through sealed classes (`TimerInitial`, `TimerRunning`, etc.) with full UI pattern matching                                |
|     |                        | UI reacts with conditional rendering & controls using `.when()` and `maybeWhen()`                                                        |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 10  | **Provider Lifecycle** | Demonstrates advanced lifecycle management with `keepAlive`, `ref.onCancel`, and `Consumer` performance gains.                           |
|     |                        | - `keepAliveLink.close()` after delay (10s/25s) for conditional caching                                                                  |
|     |                        | - Time-based caching: counter & product list cached with timers using `ref.onCancel`                                                     |
|     |                        | - `Consumer` widget usage for performance boost: prevents over-rebuilding & provider invalidation                                        |
|     |                        | - Cascade providers: showcases dependency chains and lifecycle impact when provider types change                                         |
|     |                        | - Logs lifecycle events (`onDispose`, `onCancel`, etc.) to visualize provider instance behavior                                          |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 11  | **Optimization**       | Demonstrates Riverpod’s scoped rebuild strategies, local state isolation, and ProviderScope overrides for performance tuning.            |
|     |                        | - `ProviderScope.overrideWithValue` for per-item local state isolation (avoids full list rebuilds)                                       |
|     |                        | - Fine-grained rebuild control using `ConsumerWidget` vs full `ref.watch`                                                                |
|     |                        | - Scoped overrides to simulate multiple instances of the same provider with custom initialization                                        |
|     |                        | - Clean `ItemTile` rebuild only when scoped state changes (ideal for lists, chat items, etc.)                                            |
|     |                        | - Shows how to implement reusable counters with isolated state using class-based and closure-based overrides                             |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 12  | **Pagination**         | Demonstrates both infinite scroll and numbered pagination using Dio + Riverpod.                                                          |
|     |                        | - Infinite scroll via `infinite_scroll_pagination` with Riverpod-integrated `PagingController`                                           |
|     |                        | - Number-based pagination using `NumberPaginator` and Riverpod state with `page` as dynamic input                                        |
|     |                        | - Async data caching with `ref.keepAlive()` and delayed `ref.onCancel(...)` for smoother UX                                              |
|     |                        | - Lifecycle-aware data fetching with disposal, cancellation, and Dio integration                                                         |
|     |                        | - Product details shown on tap via detail providers (also with lifecycle hooks and custom `onDispose`)                                   |
|     |                        | - Decoupled repository layer per pagination mode (infinite vs. numbered)                                                                 |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 13  | **AsyncValues**        | Demonstrates robust `AsyncValue` state management and UI rendering for async operations.                                                 |
|     |                        | - Weather app with two state shapes:                                                                                                     |
|     |                        | 1. **AsyncNotifier** (`state = AsyncLoading(); await AsyncValue.guard(...)`)                                                             |
|     |                        | 2. **Stateless FutureProvider** with dependent `city` provider                                                                           |
|     |                        | - Simulated async fetch per city with loading delays and intentional failures (error simulation)                                         |
|     |                        | - Dynamic switching of cities via `NotifierProvider<int>` (index)                                                                        |
|     |                        | - Reusable `AsyncValue.when(...)` UI rendering: `skipError: true`, `skipLoadingOnRefresh: false`                                         |
|     |                        | - Error-handling with `ref.listen(...).hasError` for showing dialog separately from UI                                                   |
|     |                        | - Demo includes practical comparison of two `AsyncValue` management styles                                                               |
| --- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |

---

## 🧩 Advanced Logging & Lifecycle Tracking

Riverpod Reminder provides a **robust observability layer** for tracking provider lifecycle events, debugging async state flows, and understanding reactive state transitions in detail.
This makes it an invaluable tool not only for development but also for **learning, teaching, and debugging Riverpod-based apps**.

### 🛰️ Provider Lifecycle Tracking

**✅ ProviderObserver Logger** — Custom `ProviderObserver` registered in `main.dart`:

- Captures all lifecycle events: **add**, **update**, **dispose**
- Logs structured data using **pretty-printed JSON**
- Includes **timestamps**, provider names, and `AsyncError` traces when applicable

### 🧠 AsyncValue Debugging Utilities

**✅ AsyncValue Extensions** — Utility extensions for easier debugging of `AsyncValue`:

- `.toStr` → concise string output (state, value, error)
- `.props` → detailed flags for `isLoading`, `isRefreshing`, `hasError`, etc.

**✅ AsyncValueLogger** — Dedicated logger class used in **Feature 13 (AsyncValues)**:

- Logs `.value`, `.valueOrNull`, `.requireValue` safely
- Captures common state breakdowns and errors for visibility into async state flow

### 🔄 Provider Lifecycle Hooks

**✅ Lifecycle Hooks in Providers**

- Most providers implement `ref.onDispose()` and `ref.onCancel()` for tracking lifecycle events and resource cleanup
- Ensures awareness of when and why providers are rebuilt, recreated, or destroyed

**✅ Manual Lifecycle Logs**

- Providers and features include `debugPrint(...)` logs to trace state transitions, rebuild triggers, and refresh events
- Especially useful when debugging caching logic, scoped invalidation, or provider overrides

> ✅ Together, these tools transform the app into a powerful Riverpod **diagnostics lab** — giving developers full visibility into what’s happening under the hood.

---

## 📦 Tech Stack

- **Flutter 3.7+** with **Material 3** support
- **Riverpod v2** — declarative, testable state management
  - Manual & Codegen styles (switchable via `AppConfig`)
  - Includes:  
    `Notifier`, `AsyncNotifier`, `StateNotifier`, `ChangeNotifier`,  
    `Provider`, `FutureProvider`, `StreamProvider`
- **Riverpod Codegen Suite**
  - `@riverpod`, `@freezed`, `build_runner`, `riverpod_generator`, `json_serializable`
- **Freezed & JsonSerializable** — for immutable DTOs & model classes
- **Dio** — powerful REST client with cancellation & token support
- **Retrofit** — declarative HTTP abstraction built on Dio
- **GoRouter** — robust routing with:
  - Nested navigation (`StatefulShellRoute`)
  - Auth guards (based on `authStateProvider`)
  - Path & query parameters
- **Advanced Debugging & Logging**
  - `ProviderObserver (Logger)` — full lifecycle tracking: init, update, dispose
  - `AsyncValueLogger` — rich debugging for async states (.value, .error, .requireValue)
  - `AsyncValueXX extension` — simplified `.toStr` and `.props` for logging
  - Manual `debugPrint` messages across providers
- **Lifecycle Hooks in Providers**
  - Usage of `ref.onDispose()` and `ref.onCancel()` to track cleanup, caching, and rebuilds
- **Local Storage**
  - `SharedPreferences` (user prefs, auth flags)
  - `GetStorage` (lightweight key-value cache)
- **Intl** — timestamp formatting & structured logs
- **Pagination Libraries**
  - `infinite_scroll_pagination` — for endless lists
  - `number_paginator` — page-based navigation
- **Hooks** — via `flutter_hooks` and `hooks_riverpod` for functional UI logic
- **Typography** — Apple-style `SF Pro Text` font family
- **Clean Architecture** — modular project structure:
  - `core/`, `features/`, `domain/`, `presentation/`, `ui/`
- **Flexible Configuration via AppConfig**
  - Enable/disable:
    - ✅ GoRouter
    - ✅ Codegen vs Manual providers
    - ✅ StateNotifier vs ChangeNotifier

---

---

## 🚀 Getting Started

1. Clone the repository:
   git clone https://github.com/RamanGodun/RiverPod-RemindeR

```

2. Install dependencies:
flutter pub get
```

3. Run in GoRouter mode or Standard mode:
   // In lib/core/domain/config/app_config.dart
   static const bool isUsingGoRouter = true; // or false

```

4. Run the app:
flutter run
```

---

## 🔍 License

This project is licensed under the [MIT License](LICENSE).

## 🤝 Contributing

Feel free to fork the repo, open issues, or submit PRs for improvements!

---

## 🔧 TODO (Improvements & Cleanup)

To further improve the structure, consistency, and UI polish across the project:

### ✅ Centralize UI Constants & Strings

Extract all hardcoded values and text from feature presentation layers into centralized files:

- `core/domain/app_constants/app_constants.dart`  
  → For reusable constants: spacing, durations, sizes, animation configs, etc.

- `core/domain/app_constants/app_strings.dart`  
  → For UI labels, descriptions, buttons, alerts, and error messages

> 📌 This promotes reusability, theming consistency, and easier localization in future.

---

### ✅ Improve UI Design Consistency

- Ensure all screens adhere to consistent **spacing**, **padding**, and **color system**
- Apply **ThemeMode (light/dark)** awareness across features
- Review typography and element alignment for a **clean, modern UI** look and feel

---

# firebase-with-BLoC-or-CUBIT
