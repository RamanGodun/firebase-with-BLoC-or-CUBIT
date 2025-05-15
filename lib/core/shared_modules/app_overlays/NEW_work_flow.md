""

# 🧠 Overlay System Workflow Manual — Production-Grade Architecture

This document defines the **overlay rendering system** workflow in the app. It is structured to ensure *single source of truth*, clean architecture, and perfect UX separation between state-driven, side-effect-driven, and user-driven overlays.

---

## ✅ Architectural Principles

### 🟢 Core Rules:

* 🔄 **State-driven overlays** (e.g. loaders, empty states) are controlled by `Cubit/Bloc` via `BlocBuilder`.
* 🔒 **Side-effect overlays** (e.g. error dialogs/snackbars) are shown through `BlocListener` + `Dispatcher`.
* 💬 **User-driven overlays** (e.g. confirmation dialogs, adding data) are shown **manually** via `OverlayService`.

---

## 🗺️ System Layers

### 1. **Dispatcher-based Overlays**

Dispatcher is responsible for queueing, conflict resolution, insertion, and lifecycle management of transient overlays (banners, snackbars, error dialogs, toasts).

**Entry Point:**

```dart
context.showError(model);
context.showSnackbar(...);
context.showBanner(...);
context.showDialog(...); // via dispatcher
```

**Core Flow:**

```
ListenerWrapper → FailureUIModel → context.showError(...) → Dispatcher → OverlayEntry → Render
```

**Relevant Files:**

* `OverlayDispatcher`
* `OverlayUIEntry` subclasses (e.g. `DialogOverlayEntry`)
* `OverlayConflictStrategy`, `OverlayPolicyResolver`
* `context_show_overlay_x.dart`

---

### 2. **StateManager-driven Overlays (Builders)**

Used to show `loaders`, `empty screens`, or `data content` via `BlocBuilder` or `HookBuilder`.

**Entry Point:**

```dart
BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) => switch (state) {
    ProfileLoading() => LoaderWidget(), // direct widget
    ...
  },
);
```

**Key Principle:**

> Loader is not a transient overlay. It’s part of the main layout flow and must live inside the Builder — not via Dispatcher.

---

### 3. **Manually Triggered User-Driven Dialogs**

Dialogs shown via direct user interaction (button press, swipe, FAB) must be called **without Dispatcher** to avoid overlay queue interference.

**Entry Point:**

```dart
OverlayService.showAddItemDialog(context);
```

**Why?**

* Dispatcher is not aware of modal context.
* Dispatcher queues and replaces overlays — which can **conflict with modal dialogs**.

**Relevant File:**

* `overlay_service.dart`

---

## 🧩 File Usage Guide

| Component                        | Purpose                                            | Usage Context                   |
| -------------------------------- | -------------------------------------------------- | ------------------------------- |
| `OverlayContextX`                | DSL extension for Dispatcher overlays              | Side-effects (errors, feedback) |
| `OverlayDispatcher`              | Queues + manages overlay conflicts                 | Auto-managed                    |
| `OverlayUIPresets`               | Shared UI styles for snackbars, banners, dialogs   | Visual consistency              |
| `OverlayUIEntry` subclasses      | Declarative overlay descriptors                    | Internal Dispatcher use         |
| `GlobalOverlayHandler`           | Keyboard + overlay dismiss gesture handler         | Wraps `MaterialApp.builder`     |
| `OverlayService`                 | Manual user interaction overlays (not queued)      | Used for `showDialog`/modals    |
| `ListenerWrapper` (BlocListener) | Handles one-shot feedback (failure, success, etc.) | Pushes to Dispatcher            |
| `Builder` (BlocBuilder)          | Renders layout based on `Cubit` state              | Loader, UI widgets              |

---

## 🧪 Conflict-Resolution Policies

Each overlay entry defines:

* `OverlayPriority` — controls replacement importance.
* `OverlayReplacePolicy` — how to handle existing overlays.
* `OverlayCategory` — logical type (banner, loader, dialog).

Dispatcher consults `OverlayPolicyResolver` to determine if:

* current overlay must be dismissed
* queued overlay must wait
* new overlay must be dropped

---

## 🧠 Real World Flow

### A. ProfilePage (State-based loader, Dispatcher-based error)

```dart
BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) => switch (state) {
    ProfileLoading() => LoaderWidget(),       // UI-driven
    ProfileError() => ErrorContent(),         // fallback view
    ProfileLoaded(:user) => UserProfileCard(user: user),
  },
);
```

```dart
BlocListener<ProfileCubit, ProfileState>(
  listenWhen: (prev, curr) => curr is ProfileError,
  listener: (context, state) {
    final model = state.failure.consume();
    if (model != null) context.showError(model); // Dispatcher-driven
  },
);
```

### B. SignInPage (SideEffect + Form feedback)

* Listener handles only `failure`.
* Builder handles only form `status`.

---

## ✅ Summary: Best Practice Flow

| Type            | Who triggers | Where rendered         | Via                      | Dispatcher? |
| --------------- | ------------ | ---------------------- | ------------------------ | ----------- |
| Loader          | `Cubit`      | `Builder`              | `LoaderWidget()`         | ❌ No        |
| Error Dialog    | `Listener`   | `Overlay`              | `context.showError()`    | ✅ Yes       |
| User Dialog     | User         | `Dialog` via Navigator | `OverlayService`         | ❌ No        |
| Snackbar/Banner | `Listener`   | `Overlay`              | `context.showSnackbar()` | ✅ Yes       |

---

## ✅ Conclusions

* ❗ **Dispatcher must never manage long-lived loaders or user dialogs.**
* 🧱 Dispatcher is perfect for transient feedback overlays.
* 🎮 Always ensure UI has a *single source of truth* — either via Cubit state or user interaction — never both simultaneously.

""
