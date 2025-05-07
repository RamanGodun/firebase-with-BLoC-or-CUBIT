# 🎯 Error Feedback in Cubit — One-Time Error Display (Ephemeral vs. Consumable)

---

## 🧩 Goal

Prevent duplicate error dialogs or snackbars in Flutter apps when the UI rebuilds or user returns to the screen.

---

## ✅ Strategy Overview

When using `Cubit` or `Bloc`, emitting an error state can cause repeated UI feedback (e.g., dialog shown again) if the same error state remains active.

To prevent this, use **one of two robust patterns**:

---

## 1️⃣ Ephemeral Error State (Emit → Reset)

### 🧠 Concept

Emit an error state (e.g., `FormzSubmissionStatus.failure`) **temporarily**, then **immediately reset** to a neutral state (e.g., `initial`).

> ⏱️ `Future.microtask()` ensures the reset happens *after the listener has already processed the error*. This avoids triggering the same feedback again on rebuild.

### ✅ Use Case

Works well when error is displayed via `BlocListener` reacting to a field like `status`.

### 📦 Example (Cubit logic)

```dart
result.fold(
  (f) {
    emit(state.copyWith(status: FormzSubmissionStatus.failure, failure: f));

    // Reset state in next microtask to avoid duplicate feedback
    Future.microtask(() {
      if (!isClosed) {
        emit(state.copyWith(status: FormzSubmissionStatus.initial));
      }
    });
  },
  (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
);
```

### 📦 BlocListener

```dart
BlocListener<MyCubit, MyState>(
  listenWhen: (prev, curr) =>
    prev.status != curr.status && curr.status.isSubmissionFailure,
  listener: (context, state) {
    context.showFailureDialog(state.failure!);
  },
);
```

---

## 2️⃣ Consumable Event Wrapper (Single Use)

### 🧠 Concept

Store the failure as a one-time `Consumable<Failure>` event in state. UI **consumes** it only once.

> ✅ Excellent fit when using `ResultHandler` / `.match()` pattern — avoids the need to reset state.

### ✅ Use Case

Preferred when state stays unchanged after error (e.g., form remains filled).

### 📦 Helper Class

```dart
class Consumable<T> {
  T? _value;
  bool _isConsumed = false;

  Consumable(T value) : _value = value;

  T? consume() {
    if (_isConsumed) return null;
    _isConsumed = true;
    return _value;
  }

  bool get isConsumed => _isConsumed;
}
```

### 📦 Cubit Usage

```dart
result.fold(
  (f) => emit(state.copyWith(
    status: FormzSubmissionStatus.failure,
    failureEvent: Consumable(f),
  )),
  (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
);
```

### 📦 BlocListener

```dart
BlocListener<MyCubit, MyState>(
  listener: (context, state) {
    final failure = state.failureEvent?.consume();
    if (failure != null) {
      context.showFailureDialog(failure);
    }
  },
);
```

---

## 🔬 Testing Notes

* `Consumable` is unit-testable — simply check `.isConsumed` or call `.consume()` in tests.
* You can mock `Consumable<Failure>` easily for Cubit/Notifier testing.

---

## ✅ Summary

| Pattern            | When to Use                                               |
| ------------------ | --------------------------------------------------------- |
| Ephemeral State    | Stateless reset; simple forms; no persistent state needed |
| Consumable Wrapper | Complex forms; reusable state; error shouldn’t reappear   |

Both strategies are production-ready and used in top-tier apps. Choose based on **UI needs and state lifecycle**.

> 💡 Tip: You can even combine both if needed (e.g., use `status` + `Consumable<Failure>`).
