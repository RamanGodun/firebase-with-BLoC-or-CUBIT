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







## 🧭 User-Driven Overlay Flow

### 🎯 Purpose

Manages overlays triggered **manually** by user interactions (e.g. tapping a button, gesture, etc.).
These overlays are not connected to application state and are **queued separately** to ensure UX consistency and predictability.

---

### 🚀 Entry Point

```dart
context.showUserDialog(...);
context.showUserSnackbar(...);
context.showUserBanner(...);
```

These methods enqueue a job in the `OverlayQueueManager`, which manages queue lifecycles **per overlay type** (banner, snackbar, dialog).

---

## 🧩 Core Architecture

### 📦 Components

| Component             | Responsibility                                         |
| --------------------- | ------------------------------------------------------ |
| `OverlayQueueManager` | Queues overlay jobs per type, ensures one-at-a-time    |
| `OverlayJob`          | Represents a queued task to render an overlay          |
| `DialogOverlayJob`    | Creates animated dialog and inserts via `OverlayEntry` |
| `SnackbarOverlayJob`  | Renders platform-aware snackbar                        |
| `BannerOverlayJob`    | Displays animated banners                              |
| `AnimationHost`       | Executes entry/exit animations and cleanup             |

---

### 📌 Workflow Summary

1. `BuildContext.showUserDialog(...)` is called
2. Job is created: `DialogOverlayJob`
3. `OverlayQueueManager.enqueue(job)`
4. If no active job of that type: `job.show()` is called
5. `OverlayEntry` is created and inserted via `Overlay.of(context)`
6. `AnimationEngine.play()` starts entrance animation
7. On dismiss, `AnimationEngine.reverse()` is called
8. Entry is removed, and next job in queue is processed

---

## 🧠 OverlayQueueManager

* Maintains a **separate FIFO queue per overlay type**
* Ensures only one banner/snackbar/dialog is shown at a time
* Automatically proceeds to next item once the current one is dismissed

```dart
final _queues = <UserDrivenOverlayType, Queue<OverlayJob>>{...};
final _active = <UserDrivenOverlayType, bool>{...};
```

---

## 🧱 OverlayJob Interface

Every job implements:

```dart
abstract class OverlayJob {
  UserDrivenOverlayType get type;
  Duration get duration;
  Future<void> show();
}
```

This keeps the API clean, flexible, and consistent with all job types.

---

## 🖼️ Animation & Dismiss

All jobs use `AnimationHost`:

```dart
AnimationHost(
  overlayType: UserDrivenOverlayType.dialog,
  displayDuration: Duration.zero,
  platform: animationPlatform,
  onDismiss: () {
    entry.remove();
    completer.complete();
  },
  builderWithEngine: (engine) => AndroidAppDialog(...),
)
```

> `AnimationHost` ensures **smooth transitions**, **timed auto-dismiss** (for banners/snackbars), and correct cleanup.

---

## ✅ Summary: User-Driven Overlay Flow

| Action      | API Used                     | Queue Manager | UI Layer      | Animates via    |
| ----------- | ---------------------------- | ------------- | ------------- | --------------- |
| Banner      | `context.showUserBanner()`   | ✅ Yes         | `AppBanner`   | `AnimationHost` |
| Snackbar    | `context.showUserSnackbar()` | ✅ Yes         | `AppSnackbar` | `AnimationHost` |
| Info Dialog | `context.showUserDialog()`   | ✅ Yes         | `AppDialog`   | `AnimationHost` |

---

## ✍️ Notes

* ❗ Dialogs require **manual user dismissal**, unless customized
* ✅ Banner/snackbar overlays auto-dismiss using `displayDuration`
* 🚫 This system is completely **independent** from `OverlayDispatcher`
* 🔄 Can be safely used **in parallel** with State-Driven flow

---

## 🧩 Extending the Flow

To add a new user-driven overlay:

1. Create a new `OverlayJob` subclass
2. Register it in `OverlayQueueManager` enum
3. Trigger it via `context.showUser...()` extension

---

## 🧪 Example: FAB-triggered Overlay

```dart
FloatingActionButton(
  onPressed: () => context.showUserDialog(
    title: 'Delete item?',
    content: Text('Are you sure you want to delete this item?'),
    confirmText: 'Yes',
    cancelText: 'No',
  ),
);
```

Will queue and show a platform-aware dialog via `AnimationHost`.

---

## 🧷 Final Tip

> Always prefer **State-Driven** overlays for side-effects and logic errors,
> and **User-Driven** overlays for user-initiated UI flows.

This clear separation enforces UX predictability and better testability.

