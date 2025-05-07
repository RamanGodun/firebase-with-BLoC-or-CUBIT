# 📦 Flutter Overlay & Error Feedback System — Production-Grade Manual (v2)

> **Optimized for:** Clean Architecture • Stateless UI • Declarative Notifications • Platform-Adaptive Overlays

---

## 🎯 Purpose

Design a **robust, centralized, and extensible overlay system** for:

* ✅ Error & success feedback (snackbars, banners, dialogs, overlays)
* ✅ Stateless UI & separation of concerns
* ✅ Platform-aware rendering
* ✅ Overlay conflict prevention & queuing

---

## 🧱 Architectural Overview

### 1. `GlobalOverlayHandler`

```dart
builder: (context, child) => GlobalOverlayHandler(child: child!);
```

* ✅ Wraps root for auto-dismiss of keyboard & overlays

### 2. `OverlayDispatcher`

```dart
OverlayDispatcher.instance.enqueueRequest(context, OverlayRequest(...));
```

* 🧠 Central queue-based overlay executor (one active overlay at a time)
* 🛠 Uses `Queue<(BuildContext, OverlayRequest)>`

### 3. `OverlayRequest`

* 📦 Declarative sealed classes (Dart 3)
* 🧩 Only describes **what** to show, not **how**
* 🧪 Easily testable, no `BuildContext` inside

### 4. `OverlayExtensions`

```dart
context.showSnackbar("Saved!");
context.showPlatformDialog(AlertDialog(...));
```

* ✅ Syntactic sugar API
* ✅ DSL-style API available

---

## 🧩 Extension Usage

### 🟢 **Option 1: Declarative Calls (Laconic)**

```dart
context.showSnackbar("Updated");
context.showPlatformDialog(AlertDialog(...));
context.showBannerOverlay(MyBanner());
```

### 🟢 **Option 2: DSL-style API**

```dart
context.showOverlay(OverlayType.snackbar, message: "Welcome");
context.showOverlay(OverlayType.dialog, child: AlertDialog(...));
```

> ✅ Both APIs use same `OverlayDispatcher` and queue logic under the hood.

---

## 🧩 Request Layer — Sealed Class Design

```dart
sealed class OverlayRequest {
  const OverlayRequest();
  Duration get duration;
}
```

Subtypes:

* `SnackbarRequest`
* `DialogRequest`
* `BannerRequest`
* `LoaderRequest`
* `WidgetRequest`

### Example:

```dart
factory SnackbarRequest.from(String msg) => SnackbarRequest(SnackBar(content: Text(msg)));
```

---

## ⚙️ Dispatcher Execution Flow

```dart
switch (request) {
  case SnackbarRequest(:final snackbar): showSnackBar();
  case DialogRequest(:final dialog): showDialog();
  ...
}
```

* 🧠 Dispatcher centralizes the actual UI rendering
* ✅ Allows switching logic and platform customization in one place

---

## 🧱 `OverlayTask` Pattern (Alternative)

`OverlayTask` — імперативний клас, що **виконує дію самостійно**:

```dart
abstract class OverlayTask {
  Future<void> execute();
}
```

### 🔄 Маппінг `OverlayRequest → OverlayTask`

```dart
extension OverlayTaskFactory on OverlayRequest {
  OverlayTask toTask(BuildContext context) => ...
}
```

---

## 🧮 OverlayRequest vs OverlayTask

| Характеристика                   | OverlayRequest (sealed) | OverlayTask (abstract) |
| -------------------------------- | ----------------------- | ---------------------- |
| ✅ Declarative Intent             | ✔️                      | ❌                      |
| ✅ Testable DTOs                  | ✔️                      | ❌ (context dependency) |
| ❌ Encapsulated Execution Logic   | ❌                       | ✔️                     |
| ✅ Platform Adaption in One Place | ✔️ (dispatcher)         | ❌ (розпорошено)        |
| 🔧 Suitable for Queuing          | ✔️                      | ✔️                     |
| 🚀 Extensibility                 | High (sealed + switch)  | Mid (OOP override)     |

### 🔎 Висновок:

> Use `OverlayRequest` for most cases. Use `OverlayTask` only if you want per-object encapsulated behavior or undo/redo mechanics.

---

## ✅ Benefits Summary

* 🔄 **One entry point** for all overlays
* 📦 Platform-aware rendering
* 🧱 Clean Architecture compliant
* 🚀 Easily testable
* 🔄 Queued execution (no overlap)
* 🎯 DSL- & laconic-friendly APIs

---

## 🧠 Final Advice

> 💡 Use sealed `OverlayRequest` as your primary structure.
> ✅ Dispatcher executes requests based on their type.
> 🧪 Mock or extend overlays easily.
> 🧩 Use `context.showOverlay(...)` or `context.showSnackbar(...)` depending on context.

> Let **context trigger overlays**, let **dispatcher render**, let **queue prevent conflicts**.
