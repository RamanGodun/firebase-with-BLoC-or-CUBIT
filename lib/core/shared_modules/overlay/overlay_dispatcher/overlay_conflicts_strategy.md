# 🧭 Overlay Conflict Strategies in Flutter

This guide describes two professional architectural strategies for managing overlay conflict resolution in a scalable Flutter application.

---

## 🧩 Problem Context

When building UI overlays (SnackBars, Dialogs, Loaders, Banners) in a queued system, we often need to define **how new overlays interact with currently active ones**:

* Should the new overlay wait its turn?
* Should it cancel the current one?
* What if it's a more critical message (like an error)?

This problem leads us to define **Overlay Conflict Resolution Strategies**.

---

## ✅ Strategy 1 — `sealed class + conflictStrategy getter`

### 📄 Overview

Each `OverlayUIEntry` subclass defines its conflict logic via a `conflictStrategy` getter inside the class itself.

### 🛠 Example

```dart
final class SnackbarOverlayEntry extends OverlayUIEntry {
  @override
  OverlayConflictStrategy get conflictStrategy => const OverlayConflictStrategy(
    priority: OverlayPriority.normal,
    policy: OverlayReplacePolicy.waitQueue,
  );
}
```

### ✅ Pros

* **Encapsulation**: each class owns its own behavior.
* **Modular**: adding/removing overlays doesn't touch shared logic.
* **Open/Closed**: Dispatcher remains untouched.

### ❌ Cons

* **Scattered configuration**: conflict rules spread across many files.
* **Harder bulk updates**: changing a rule (e.g., for all SnackBars) requires touching all entries.
* **Some duplication**: same strategy can repeat across entries.

---

## ✅ Strategy 2 — `abstract class + OverlayConflictResolver`

### 📄 Overview

Each `OverlayUIEntry` subclass implements an abstract base class, while a centralized resolver defines logic for each overlay type.

### 🛠 Example

```dart
abstract class OverlayUIEntry {
  OverlayConflictStrategy get conflictStrategy =>
    OverlayConflictResolver.resolve(this);
}

final class BannerOverlayEntry extends OverlayUIEntry {
  // no need to define strategy manually
}

final class OverlayConflictResolver {
  static OverlayConflictStrategy resolve(OverlayUIEntry entry) {
    return switch (entry) {
      SnackbarOverlayEntry => OverlayConflictStrategy(...),
      DialogOverlayEntry => OverlayConflictStrategy(...),
      _ => const OverlayConflictStrategy(),
    };
  }
}
```

### ✅ Pros

* **Centralized**: All conflict rules live in one place.
* **Easy to refactor**: Changing logic for all banners/snackbars is simple.
* **Cleaner UIEntry classes**: less boilerplate.

### ❌ Cons

* **Indirect behavior**: hard to know an entry's behavior without checking the resolver.
* **Violates inversion slightly**: external component determines behavior of UIEntry.

---

## 🧪 Summary Comparison

| Feature                         | Strategy 1 (sealed + getter) | Strategy 2 (resolver) |
| ------------------------------- | ---------------------------- | --------------------- |
| Open/Close principle            | ✅                            | ✅                     |
| Encapsulation in OverlayUIEntry | ✅                            | ❌                     |
| Centralized configuration       | ❌                            | ✅                     |
| Ease of global refactor         | ❌                            | ✅                     |
| Local readability (in class)    | ✅                            | ❌                     |
| Modularity                      | ✅                            | ✅                     |

---

## 🧭 Decision

> We choose **Strategy 2 (resolver-based)** for now due to its scalability and centralized configuration. This makes global changes, policy testing, and feature experimentation significantly easier.

---

## 🔮 Future Consideration

If at any point code readability or per-entry customization becomes more critical than central control, **Strategy 1** could be reintroduced incrementally, starting with priority overlays.

---
