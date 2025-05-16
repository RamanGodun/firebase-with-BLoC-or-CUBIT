# 🧠 Overlay System Workflow Manual — Production-Grade Architecture

This document outlines the **overlay rendering system** in a modular Flutter app, specifically detailing 
the finalized **State-Driven Overlay Flow**. The system separates UI overlays into **State-Driven** 
and **User-Driven** flows for maximum scalability, testability, and UX consistency.

---

## ✅ Architectural Principles

### 🧩 Key Design:

* The system is divided into two flows:

  1. **State-Driven Overlays** — shown automatically via state changes (e.g. Cubit).
  2. **User-Driven Overlays** — shown from direct user actions (e.g. button tap).

> **This section documents only State-Driven Overlay Flow.** User-Driven flow is documented separately.

---

## 🗺️ File & Module Structure

```
core/
├── shared_modules/
│   ├── overlays/
│   │   ├── state_driven_flow/          ◀️ This file
│   │   └── user_driven_flow/           ◀️ (Separate)
│   └── app_animation/
│       └── animation_host.dart         ◀️ Central Animation Host Widget
```

### ✅ AnimationHost location:

* `AnimationHost` (shared endpoint for all overlay widgets)
* Lives in `app_animation` module (not in overlays)
* Called from `OverlayEntry.build()`

---

## 🧠 State-Driven Overlay Flow

### 🎯 Purpose

Manages all overlays triggered from the application state (e.g. BlocListener).
Designed for side-effect rendering: error banners, dialogs, snackbars, etc.

### 🔁 Entry Point

```dart
context.showError(model);
context.showSnackbar(...);
context.showBanner(...);
context.showDialog(...);
```

These methods internally create an `OverlayUIEntry` and enqueue it via `OverlayDispatcher`.

### 📦 Dispatcher Responsibilities

* Queues overlay entries
* Resolves conflicts and dismiss policies
* Injects overlays into root `Overlay` using `OverlayEntry`
* Calls `AnimationHost` as render point

---

## 🧩 Overlay Entry Components

### 📌 Common:

All `OverlayUIEntry` subclasses must provide:

* `build(BuildContext)` — returns widget calling `AnimationHost`
* `OverlayConflictStrategy` — defines queue/replace rules
* `OverlayDismissPolicy` — whether can be dismissed by user
* `OverlayCategory` & `OverlayPriority` — used for conflict resolution

### ✅ Subclasses:

* `BannerOverlayEntry`
* `SnackbarOverlayEntry`
* `DialogOverlayEntry`

> ❗ All error and non-error flows use the same entries. Error flows are distinguished via `isError = true` + different `OverlayConflictStrategy`.

---

## 🧠 Overlay Conflict Resolution

### ✅ Managed via:

* `OverlayConflictStrategy` object
* `OverlayPolicyResolver.shouldReplaceCurrent(...)`

### 📌 Strategy Properties:

```dart
OverlayPriority: normal | high | critical
OverlayReplacePolicy: waitQueue | forceReplace | forceIfSameCategory | forceIfLowerPriority | dropIfSameType
OverlayCategory: banner | snackbar | dialog | error
```

### 🧠 Sample:

```dart
OverlayConflictStrategy(
  priority: OverlayPriority.critical,
  policy: OverlayReplacePolicy.forceReplace,
  category: OverlayCategory.error,
)
```

---

## 🧪 Failure Handling (example)

```dart
BlocListener<MyCubit, MyState>(
  listenWhen: (prev, curr) => curr is MyErrorState,
  listener: (context, state) {
    final model = state.failure.consume();
    if (model != null) {
      context.showError(
        model,
        showAs: ShowErrorAs.dialog,
        preset: OverlayErrorUIPreset(),
      );
    }
  },
);
```

### 🔄 Will render:

* Platform-aware animated dialog
* Shown via `DialogOverlayEntry`
* Inserted through `OverlayDispatcher`
* Animated using `AnimationHost`

---

## ✅ Summary: State-Driven Overlay Flow

| Action       | API Used                 | Dispatcher | UI Layer      | Animates via    |
| ------------ | ------------------------ | ---------- | ------------- | --------------- |
| Error Banner | `context.showError()`    | ✅ Yes      | `AppBanner`   | `AnimationHost` |
| Snackbar     | `context.showSnackbar()` | ✅ Yes      | `AppSnackbar` | `AnimationHost` |
| Error Dialog | `context.showError()`    | ✅ Yes      | `AppDialog`   | `AnimationHost` |
| Info Dialog  | `context.showDialog()`   | ✅ Yes      | `AppDialog`   | `AnimationHost` |

---

## ⛔ What Not To Do

* ❌ Do not use Dispatcher for loaders or state-based widgets
* ❌ Do not mix UI overlays with BlocBuilder content
* ❌ Do not put animation or UI logic in `OverlayUIEntry` directly — only in `AnimationHost`

---

## ⏭️ Next Section: `User-Driven Overlay Flow`

*Coming soon — documents manual overlays shown from UI interaction (FABs, gestures, etc.)*
