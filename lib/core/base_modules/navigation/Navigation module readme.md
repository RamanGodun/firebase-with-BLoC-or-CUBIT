# 🧭 Navigation Module Manual

---

## 🔰 Overview

This module provides a **declarative, robust, and testable navigation system** for Flutter apps, built with:

* ✅ [GoRouter] for navigation & route management
* ⚡️ [Riverpod/BLoC/Cubit] for reactivity and state-driven redirects
* 🧩 Supports navigation side-effects, overlay management, and auth-driven routing
* 🦾 Designed for Clean Architecture, scalable projects, and modular codebases

---

## 🧠 Architecture & Core Flow

### 🔗 Declarative Routing

* **Centralized route config** in `AppRoutes` (single source of truth)
* Uses **named routes** and **absolute paths** for maintainability
* All navigation/redirect logic is **stateless & pure**, with dynamic conditions handled by services (e.g. `RoutesRedirectionService`)

### 🚦 Auth-driven Navigation

* **Auth state** is provided via Riverpod stream (`authStateStreamProvider` / `authStateStreamCubit`)
* **Redirects** are handled declaratively in the GoRouter’s `redirect` callback, based on:

  * Authenticated/unauthenticated state
  * Email verification
  * Loading/error states
  * Public vs protected routes
* UI rebuilds **only when necessary** thanks to Riverpod’s `.select()` / `BLoCSelector`

### 🎛 Overlay & Navigation Observers

* Global overlays (dialogs, snackbars, banners) are managed via `GlobalOverlayHandler`
* Navigation observers (e.g., for closing overlays) are attached to GoRouter

---

## 🏗 Structure & Main Components

```
lib/core/base_modules/navigation/
|
├── app_routes
│   ├── app_routes.dart
│   ├── route_paths.dart
│   └── routes_names.dart
├── core
│   ├── go_router_provider.dart
│   └── router_factory.dart
├── extensions
│   ├── failure_navigation_x.dart
│   ├── navigation_x.dart                 # Context extensions for GoRouter/Navigator
│   └── result_navigation_x.dart
├── Navigation module readme.md
└── utils
│   ├── page_transition.dart              # Centralized transitions (fade, etc.)
│   └── routes_redirection_service.dart   # Declarative redirect logic
|
└── ...
```

---

## 🚦 Flow: How Navigation Works

1. **App Launches:**

   * `AppRootViewShell` injects theme, GoRouter, and localization into `MaterialApp.router`

2. **Route Definitions:**

   * All app routes are defined in `AppRoutes.all` with names/paths
   * Custom transitions (e.g., fade) used for consistent UX

3. **Reactive GoRouter:**

   * GoRouter instance is provided via Riverpod (with `routerProvider`)
   * It watches the **auth state** and re-evaluates routes on changes

4. **Redirection Logic:**

   * Centralized in `RoutesRedirectionService.from(...)`
   * Handles all common flows:

     * Not signed in → `/signin`
     * Not verified → `/verifyEmail`
     * Auth error → `/signin`
     * Success → `/home`
     * Loading → `/splash`
   * Supports public & protected routes

5. **Navigation Side-Effects:**

   * Overlay observer closes dialogs/snackbars on route change
   * Overlay system is fully decoupled from business logic

6. **Extensions & Helpers:**

   * Context extensions (`goTo`, `goPushTo`, `pushTo`, etc.) for DX and concise navigation in UI logic
   * Result extensions allow chaining navigation after success flows

---

## ✨ Best Practices & Patterns

* **Always use named routes** via constants (`RoutesNames`, `RoutesPaths`)
* Use statye managers (e.g., **Riverpod providers** `routerProvider`) instead of raw GoRouter for DI and rebuild control
* **All navigation/redirect logic lives outside UI** (no inline navigation in widgets)
* Use **OverlayNavigatorObserver** for dismissing overlays automatically
* Chain navigation after domain/result operations (see `ResultNavigationExt`)
* Keep route config **centralized** and **testable**
* For protected flows, always use declarative redirects, not imperative `push`/`go` calls

---

## 🧑‍💻 Example: Auth-Driven Navigation Flow

```dart
final router = GoRouter(
  initialLocation: RoutesPaths.splash,
  routes: AppRoutes.all,
  observers: [OverlayNavigatorObserver()],
  redirect: (context, state) {
    final authState = ref.watch(authStateStreamProvider);
    return RoutesRedirectionService.from(context, state, authState);
  },
);
```

**Result:**

* User launches app → `/splash`
* Unauthenticated → `/signin`
* Authenticated, not verified → `/verifyEmail`
* Authenticated & verified → `/home`
* Any route error → `/pageNotFound`

---

## 🧑‍🔧 Example: Declarative Navigation in UI

```dart
context.goTo(RoutesNames.home);
context.goPushTo(RoutesNames.profile);
context.pushTo(const MyCustomPage());
```

* These are safe, typed helpers via `NavigationX` extension

---

## 📝 Error Handling & Navigation

* Use `FailureNavigationX` to handle redirects on domain failures (e.g. 401 → sign out and go to `/signin`)
* Use `ResultNavigationExt` to trigger navigation after successful results in a functional style

---


## 🏁 Final Notes

> This navigation module is designed for production apps needing clean code, security, and excellent UX.
> It enables full separation of concerns and flexible, scalable route management.

---
