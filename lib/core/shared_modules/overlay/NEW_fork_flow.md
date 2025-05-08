# 📦 Overlay DSL System — README

A lightweight, extensible, and production-grade DSL-style API for showing UI overlays (Snackbar, Banner, Dialog, Loader) across the app via `BuildContext.overlay`.

---

## 🧭 Purpose

This module provides a clean and intuitive way to display overlay notifications using a **domain-specific language (DSL)** approach. It's designed for:

* 🚀 **Scalability** – easily extendable to support new types (e.g., `Banner`, `CustomWidget`)
* 🔁 **Reusability** – use across the app consistently
* 💬 **Localization** – central support for localizing error messages (via `OverlayMessageKey`)
* ✅ **Error Handling Integration** – works seamlessly with `FailureNotifier`

---

## 🔧 DSL Entry Point

Every overlay is triggered from context:

```dart
context.overlay.snackbar('Operation complete');
context.overlay.dialog(...);
context.overlay.loader(...);
context.overlay.themeBanner(...);
context.overlay.showBanner(...);
context.overlay.showBannerWidget(...);
```

---

## 🧱 Structure

```dart
extension OverlayDSL on BuildContext {
  OverlayController get overlay => OverlayController(this);
}

final class OverlayController {
  void snackbar(String message);
  void dialog({ ... });
  void loader({ ... });
  void showBanner({ required OverlayKind kind, required String message });
  void showBannerWidget(Widget banner);
  void themeBanner({ required OverlayMessageKey key, required IconData icon });
}
```

---

## 🧩 OverlayKind

Used to semantically define the style of banner overlays:

```dart
OverlayKind.success
OverlayKind.error
OverlayKind.info
OverlayKind.warning
OverlayKind.confirm
```

```dart
context.overlay.showBanner(
  kind: OverlayKind.error,
  message: AppStrings.operationFailed.translate(),
);
```

---

## 💬 Localization

* Regular overlays use `.translate()` from `AppStrings`
* For error handling, `OverlayMessageKey` is still supported:

```dart
final key = OverlayMessageKeys.timeout;
context.overlay.dialog(
  title: 'Error',
  content: key.localize(context),
);
```

Only `FailureNotifier` uses `OverlayMessageKey` directly.

---

## 🧪 FailureNotifier Example

```dart
FailureNotifier.handle(context, failure.asConsumable());
```

Internally uses `OverlayMessageKey` + context.overlay DSL.

---

## ✅ Benefits

* 💡 Clear and expressive DSL syntax
* 💥 Full support for async queueing via `OverlayDispatcher`
* 🌐 Clean localization model for both UI & error overlays
* 🔁 Easily extendable for custom widgets or new types
* 🧩 Plug-and-play with Clean Architecture and SOLID

---

## 🔄 Future Enhancements

* `showBannerWithWidget(Widget)`
* `OverlayToast` / `OverlaySheet`
* Custom transitions

---

## 📌 Summary

This system defines a clean boundary between presentation & behavior. All overlays are now declarative, testable, and consistent across the app via:

```dart
context.overlay // → OverlayController
```

Use it. Extend it. Own it.

---
