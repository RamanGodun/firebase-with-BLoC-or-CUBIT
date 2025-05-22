# 🚀 OverlaysAppOverlaysFlow — Flutter Overlay Architecture Guide

This document outlines the full lifecycle and modular structure of the **Overlay System** used in the app.
 It demonstrates how overlays are triggered, animated, resolved, and dismissed in a
 **Clean, Platform-Aware, Declarative, and Scalable** architecture.

---

## 🧩 Project Structure Overview

* `ContextXForOverlays` — DSL-style extension for calling overlays from `BuildContext`
* `OverlayBaseMethods` — low-level base extension that builds actual UI entries
* `OverlayUIEntry` — abstract descriptor of a queued overlay (dialog/banner/snackbar)
* `OverlayDispatcher` — orchestrator that manages queue, conflict resolution, and dismissal
* `AnimatedOverlayWrapper` — animation lifecycle container
* `PlatformMapper` — maps platform to platform-specific widget (iOS/Android)
* `GlobalOverlayHandler` — gesture handler to dismiss overlays and keyboard
* `OverlayStatusCubit` — reactive state of overlay presence
* `OverlayNavigatorObserver` — resets overlays on navigation events

---

## 🔁 Triggering Flow (from top to bottom)

```mermaid
graph TD;
  A[UI Widget / BlocListener] --> B(context.showError / showUserBanner);
  B --> C[ContextXForOverlays];
  C --> D[OverlayBaseMethods];
  D --> E[getEngine(platform)];
  E --> F[PlatformMapper.resolveAppDialog/Banner/Snackbar];
  F --> G[AnimatedOverlayWrapper];
  G --> H[OverlayUIEntry];
  H --> I[OverlayDispatcher.enqueueRequest];
```

---

## ✅ High-Level API (context extension)

### 🔽 Priority-aware

```dart
context.showError(model);       // ShowAs.infoDialog by default, priority = high
```

### 🔼 User-initiated (low priority)

```dart
context.showUserDialog(...);    // Priority = userDriven
context.showUserBanner(...);
context.showUserSnackbar(...);
```

These methods **wrap `OverlayBaseMethods`**, but assign **default priority**, **preset**, and **strategy**.

---

## 📦 Overlay Entry Lifecycle

### 1. **Engine** (animations)

* Chosen via `getEngine(OverlayCategory)`
* Injected into platform widget

### 2. **Widget** (platform-aware)

* Built by `PlatformMapper`
* Uses `Fade/Scale/SlideTransition`
* Animated by injected `AnimationEngine`

### 3. **Wrapper**

* Wrapped in `AnimatedOverlayWrapper`
* Controls entrance/exit lifecycle
* Accepts `displayDuration`

### 4. **Entry**

* Instantiated as `OverlayUIEntry` (e.g., `SnackbarOverlayEntry`)
* Includes: `priority`, `policy`, `dismissPolicy`, `tapPassthrough`

### 5. **Queue + Dispatcher**

* Sent to `OverlayDispatcher.enqueueRequest(...)`
* Strategy resolved via `OverlayPolicyResolver`
* Inserted into overlay with `OverlayEntry`
* Barrier is added via `TapThroughOverlayBarrier`

---

## 🧠 Overlay Dispatcher Logic

* Holds **queue** of `OverlayQueueItem`
* Checks if overlay is active
* Applies conflict **replacement or wait policy**
* Controls animation dismissal callbacks
* Applies debounce per `OverlayCategory`

---

## 🎛️ Tap-Through Mechanism

Overlays support **tap-through UX** by default for banners/snackbars:

```dart
TapThroughOverlayBarrier(
  enablePassthrough: true,
  onTapOverlay: () => dismissIfAllowed(),
  child: bannerWidget,
)
```

This allows user to **interact with widgets underneath** overlay (e.g., click a button behind banner).

---

## 🌐 Global Overlay Handler

```dart
GlobalOverlayHandler(
  dismissKeyboard: true,
  dismissOverlay: true,
  child: MaterialApp.router(...),
)
```

* Attached in `AppMaterialAppRouter.builder`
* On global tap:

  * Hides keyboard
  * Dismisses overlay if `OverlayDismissPolicy.dismissible`

---

## 🛰️ Navigation-Aware Overlays

* `OverlayNavigatorObserver` listens to route changes
* Auto-clears overlays via `dispatcher.clearAll()`
* Prevents stale overlays after navigation

---

## 📡 State Exposure

### 1. **Reactive**

```dart
context.watch<OverlayStatusCubit>().state; // true if active
```

### 2. **Non-Reactive**

```dart
context.overlayStatus; // fast, cached read (extension)
```

Use these to disable buttons / prevent unwanted inputs when overlays are active.

---

## ✅ Design Principles Followed

* **Clean Architecture**: UI & Dispatcher decoupled
* **Dependency Inversion**: Dispatcher accessed via `context.dispatcher` (DI)
* **Open/Closed**: Add new overlay types without touching Dispatcher logic
* **Encapsulation**: Overlay logic lives in its own entries
* **Single Responsibility**: Each overlay entry handles only its UI + strategy

---

## 🧪 Testing & Extensibility

* New overlays (e.g. Toast, Loader) = new `OverlayUIEntry`
* Swap platform widgets without changing flow
* Swap AnimationEngine per category easily

---

## 🧭 Summary

The `OverlaysAppOverlaysFlow` module is a **declarative**, **platform-aware**, and **state-driven**/**user-driven**  
system for managing  overlays with rich conflict and animation support. Its separation of concerns allows 
for full testability, scalability, and UX consistency across app platforms.

---
