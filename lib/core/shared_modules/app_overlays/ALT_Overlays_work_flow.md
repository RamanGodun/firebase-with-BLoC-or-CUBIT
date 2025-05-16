# 🧠 Overlay System Workflow Manual — Production-Grade Architecture

This document defines the **overlay rendering system** in a modular Flutter app, outlining 
both the **State-Driven** and **User-Driven** overlay flows. The system ensures clean separation of concerns, 
robust conflict resolution, and production-ready animation behavior.

---

## ✅ Architectural Overview

### 🧩 Key Principles:

Overlay system is split into two flows:

1. **State-Driven Overlays** — shown automatically from Bloc/Cubit state.
2. **User-Driven Overlays** — triggered manually from user interactions.

---

## 🗺️ Directory Layout

```
core/
├── shared_modules/
│   ├── overlays/
│   │   ├── state_driven_flow/     ◀️ State Dispatcher & Entries
│   │   └── user_driven_flow/      ◀️ Job Queue & Jobs
│   └── app_animation/
│       └── animation_host.dart   ◀️ Central animation handler
```

### ✅ AnimationHost

* Centralized widget responsible for entry/exit animations.
* Located in `core/shared_modules/app_animation/`
* Called inside `OverlayEntry.builder()`.

---

## 🧠 State-Driven Overlay Flow

### 🎯 Purpose

Handles overlays triggered by application logic/state.
Best for error flows, form validation, or side effects in listeners.

### 🔁 Usage

```dart
context.showError(...);
context.showSnackbar(...);
context.showBanner(...);
context.showDialog(...);
```

### 📦 Dispatcher Responsibilities

* Queues `OverlayUIEntry` requests
* Resolves conflicts with `OverlayPolicyResolver`
* Inserts into root overlay via `OverlayEntry`
* Triggers animation through `AnimationHost`

---

## 🧩 OverlayUIEntry

Each overlay entry subclass must provide:

* `build(context)` → Widget using `AnimationHost`
* `OverlayConflictStrategy` → replacement/collision logic
* `OverlayDismissPolicy` → whether the user can dismiss it

### ✅ Implementations:

* `BannerOverlayEntry`
* `SnackbarOverlayEntry`
* `DialogOverlayEntry`

> ✅ Error vs Non-error handled by `isError` + strategy.

---

## 🔄 Conflict Resolution

Overlay replacement is governed by:

```dart
OverlayConflictStrategy(
  priority: OverlayPriority.critical,
  policy: OverlayReplacePolicy.forceReplace,
  category: OverlayCategory.error,
);
```

### Properties:

* `OverlayPriority`: normal | high | critical
* `OverlayReplacePolicy`: waitQueue | forceReplace | forceIfSameCategory | forceIfLowerPriority | dropIfSameType
* `OverlayCategory`: banner | snackbar | dialog | error

---

## 🧪 Example: Error Dialog

```dart
BlocListener<MyCubit, MyState>(
  listenWhen: (_, curr) => curr is MyErrorState,
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

---

## ✅ State-Driven Summary

| Action       | API Used                 | Dispatcher | UI Layer    | Animation     |
| ------------ | ------------------------ | ---------- | ----------- | ------------- |
| Error Banner | `context.showError()`    | ✅ Yes      | AppBanner   | AnimationHost |
| Snackbar     | `context.showSnackbar()` | ✅ Yes      | AppSnackbar | AnimationHost |
| Dialog       | `context.showError()`    | ✅ Yes      | AppDialog   | AnimationHost |
| Info Dialog  | `context.showDialog()`   | ✅ Yes      | AppDialog   | AnimationHost |

---

## ⛔ Don'ts

* ❌ Never use Dispatcher for loaders
* ❌ Avoid mixing overlays inside `BlocBuilder`
* ❌ Keep all animation logic in `AnimationHost`, not entries

---

## 🧭 User-Driven Overlay Flow

### 🎯 Purpose

Handles overlays triggered directly by user input (e.g. FAB, tap, long press).
Fully independent from application state.

### 🔁 Usage

```dart
context.showUserDialog(...);
context.showUserSnackbar(...);
context.showUserBanner(...);
```

> These APIs enqueue a job to `OverlayQueueManager`

---

## 🧩 Architecture Summary

| Component             | Role                                               |
| --------------------- | -------------------------------------------------- |
| `OverlayQueueManager` | Per-type FIFO queue with concurrency control       |
| `OverlayJob`          | Represents one queued overlay action               |
| `*_OverlayJob`        | Executes overlay rendering (Dialog, Snackbar, etc) |
| `AnimationHost`       | Handles animations and auto-dismiss logic          |

---

### 🔄 Workflow

1. `context.showUserDialog()` is called
2. Job is created (e.g. `DialogOverlayJob`)
3. Job is added to queue in `OverlayQueueManager`
4. If no active overlay of that type: `job.show()`
5. Job inserts an `OverlayEntry`
6. `AnimationEngine.play()` triggers appearance
7. On dismiss, reverse animation + entry removal
8. Manager proceeds to next job (if any)

---

## 📦 OverlayQueueManager

* Maintains separate FIFO queues per overlay type
* Supports banner, snackbar, and dialog flows in parallel
* Ensures clean UX: one-at-a-time per type

---

## 📄 OverlayJob API

```dart
abstract class OverlayJob {
  UserDrivenOverlayType get type;
  Duration get duration;
  Future<void> show();
}
```

---

## 🖼️ Rendering via AnimationHost

All overlays (banners, dialogs, snackbars) rendered via `AnimationHost`:

```dart
AnimationHost(
  overlayType: UserDrivenOverlayType.dialog,
  platform: animationPlatform,
  displayDuration: duration,
  onDismiss: () => ..., // cleanup
  builderWithEngine: (engine) => IOSAppDialog(...),
);
```

---

## ✅ User-Driven Summary

| Action   | API Used                     | Queue Manager | UI Widget   | Animates via  |
| -------- | ---------------------------- | ------------- | ----------- | ------------- |
| Banner   | `context.showUserBanner()`   | ✅ Yes         | AppBanner   | AnimationHost |
| Snackbar | `context.showUserSnackbar()` | ✅ Yes         | AppSnackbar | AnimationHost |
| Dialog   | `context.showUserDialog()`   | ✅ Yes         | AppDialog   | AnimationHost |

---

## ✍️ Notes

* 🟢 Dialogs require manual user dismissal
* 🟢 Banners and snackbars auto-dismiss via `displayDuration`
* 🧩 Can be used safely in parallel with State-Driven flow
* 🔌 OverlayQueueManager is independent from `OverlayDispatcher`

---

## 🧩 Adding a Custom OverlayJob

1. Create a class extending `OverlayJob`
2. Implement `show()` with `OverlayEntry + AnimationHost`
3. Add usage via `context.showUserX(...)`
4. Register `type` in `OverlayQueueManager`

---

## 💡 Example Usage

```dart
FloatingActionButton(
  onPressed: () => context.showUserDialog(
    title: 'Logout?',
    content: Text('Are you sure you want to log out?'),
    confirmText: 'Yes',
    cancelText: 'Cancel',
  ),
);
```

---

## 📌 Final Thoughts

> Use **State-Driven** overlays for logic-initiated flows (errors, forms).
> Use **User-Driven** overlays for interactive flows (taps, buttons).

This dual-architecture keeps overlays predictable, scalable, and testable.
