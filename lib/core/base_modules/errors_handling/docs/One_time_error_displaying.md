# 🧯 One-Time Error Feedback in Cubit — Clean & Reliable

---

## 🎯 Purpose

Ensure error feedback (dialogs, banners, snackbars) is **shown only once**, even if the UI rebuilds or user returns to the screen.

> ✅ Fully aligned with the [`Either`](./README.md#📦-overview) error strategy, Clean Architecture, and stateless UI principles.

---

## 🧩 Problem

In `Cubit`/`Bloc`, emitting a `Failure` or `FailureUIModel` can cause:

* repeated dialogs/snackbars after navigation
* feedback shown again on rebuild

To avoid that, we implement **one-shot UI signaling**, using either:

1. **Ephemeral status-based strategy** — via temporary state emission
2. **Consumable model strategy** — via one-time wrappers (`Consumable<T>`) in state

---

## 1️⃣ Ephemeral Status Pattern (Stateless)

### 🧠 Idea

Emit `FormzSubmissionStatus.failure`, then reset it to `initial` in a `Future.microtask`. This gives `BlocListener` enough time to act once, without re-triggers.

### ✅ Use Case

Great for simple forms using `.status` as a change notifier.

### 📦 Cubit Example

```dart
emit(state.copyWith(
  status: FormzSubmissionStatus.failure,
  failure: f.asConsumableUIModel(),
));

Future.microtask(() {
  if (!isClosed) emit(state.copyWith(status: FormzSubmissionStatus.initial));
});
```

### 📦 Listener Example

```dart
BlocListener<MyCubit, MyState>(
  listenWhen: (prev, curr) =>
    prev.status != curr.status && curr.status.isSubmissionFailure,
  listener: (context, state) {
    final model = state.failure?.consume();
    if (model != null) context.overlay.showError(model);
  },
);
```

---

## 2️⃣ Consumable Wrapper Pattern (Stateful)

### 🧠 Idea

Wrap a `FailureUIModel` in a `Consumable`, so it can only be used once — even if state stays the same.

### ✅ Use Case

Works best when the UI state (form, input, etc.) should **persist** after an error.

### 📦 `Consumable<T>` Class

```dart
final class Consumable<T> {
  final T? _value;
  bool _hasBeenConsumed = false;

  Consumable(T value) : _value = value;

  T? consume() {
    if (_hasBeenConsumed) return null;
    _hasBeenConsumed = true;
    return _value;
  }

  bool get isConsumed => _hasBeenConsumed;
}
```

### 📦 In Cubit

```dart
result.fold(
  (f) => emit(state.copyWith(
    status: FormzSubmissionStatus.failure,
    failure: f.asConsumableUIModel(),
  )),
  (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
);
```

### 📦 In Listener

```dart
BlocListener<MyCubit, MyState>(
  listenWhen: (prev, curr) =>
    prev.status != curr.status && curr.status.isSubmissionFailure,
  listener: (context, state) {
    final model = state.failure?.consume();
    if (model != null) {
      context.overlay.showError(model);
      context.read<MyCubit>()
        ..resetStatus()
        ..clearFailure();
    }
  },
);
```

---

## 🧪 Testing Tips

* `Consumable` is testable: check `.isConsumed` or use `.consume()`
* Your UI tests can assert dialog shows once, based on a `failure?.consume()` result

---

## ✅ Strategy Matrix

| Pattern            | When to Use                                                        |
| ------------------ | ------------------------------------------------------------------ |
| Ephemeral Status   | Stateless reset — short flows, `status` triggers one-time feedback |
| Consumable Wrapper | Persistent UI state — form survives error without being cleared    |

> 💡 Use both together: `FormzSubmissionStatus.failure` + `Consumable<FailureUIModel>`

---

## 🛡️ Aligned With:

* ✅ Either: Domain-level `Failure` returned as `Either<Failure, T>`
* ✅ Failure Mapping: `.toUIModel()` for consistent overlays
* ✅ Clean Presentation: `Consumable<FailureUIModel>` in `Cubit`, no business logic in UI
* ✅ Stateless Feedback: UI reads + consumes, never stores failure logic
