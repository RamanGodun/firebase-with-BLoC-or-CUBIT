# 🛡️ Error Handling System — Manual for Developers

---

## 📦 Overview

This module implements a **unified, scalable error handling system** that supports two alternative paradigms:

* 🧨 **AZER** — Classic, explicit and readable error flow using `Either<Failure, T>` and `.fold(...)`
* 🔗 **DSL-like** — Declarative, chainable alternative inspired by functional programming, using `DSLLikeResultHandler`, `.match()` and `.matchAsync()` extensions

Each approach is interchangeable and can be selected per feature or team preference.

---

## 🤁 AZER: Explicit (Classic) Style

### ✅ When to Use:

* You want **full control** over success and failure handling
* You prefer **clarity** and **predictable flow**
* Common in Cubit/BLoC state management

### 🤩 Code Example:

```dart
final result = await getUserUseCase();

result.fold(
  (f) => emit(Failed(f)),
  (u) => emit(Loaded(u)),
);
```

---

## 🧚 DSL-like Style

### ✅ When to Use:

* You prefer a **chainable API** with fluent handlers
* You want to reduce boilerplate (fold logic repeated often)
* Great for services, reactive flows, or advanced orchestration

### ✳️ Variant 1 — `matchAsync()` Extension:

```dart
await getUserUseCase().matchAsync(
  onFailure: (f) => emit(Failed(f)),
  onSuccess: (u) => emit(Loaded(u)),
);
```

### ✳️ Variant 2 — `DSLLikeResultHandler`:

```dart
await getUserUseCase().then((r) => DSLLikeResultHandler(r)
  .onFailure((f) => emit(Failed(f)))
  .onSuccess((u) => emit(Loaded(u))));
```

### ✳️ Variant 3 — `match()` (sync style for `Either<Failure, T>`):

```dart
final result = await getUserUseCase();
result.match(
  onFailure: (f) => emit(Failed(f)),
  onSuccess: (u) => emit(Loaded(u)),
);
```

### ✨ Advanced Chaining:

```dart
await getUserUseCase()
  .flatMapAsync((u) => checkAccess(u))
  .recover((f) => getGuestUser())
  .mapRightAsync((u) => saveLocally(u))
  .then((r) => DSLLikeResultHandler(r).log());
```

---

## 🧹 Integration in Cubit

### 🧨 AZER-style Cubit Example:

```dart
Future<void> fetchUser() async {
  emit(Loading());
  final result = await getUserUseCase();
  result.fold(
    (f) => emit(Failed(f)),
    (u) => emit(Loaded(u)),
  );
}
```

### 🔗 DSL-style Cubit Example:

```dart
Future<void> fetchUser() async {
  emit(Loading());
  await getUserUseCase().then((r) => DSLLikeResultHandler(r)
    .onFailure((f) => emit(Failed(f)))
    .onSuccess((u) => emit(Loaded(u))));
}
```

---

## 📂 Folder Structure

```plaintext
errors_handling/
│
├── either_for_data/                       # Core functional primitives
│   ├── either.dart                        # Either<L, R> implementation
│   ├── unit.dart                          # Unit type
│   ├── _eithers_facade.dart               # Exports commonly used extensions
│   └── either_x/                          # DSL-like and utility extensions
│       ├── either_async_x.dart
│       ├── either_getters_x.dart
│       ├── either_test_x.dart
│       ├── either_x.dart
│       ├── result_logger_x.dart
│       └── result_navigation_x.dart
│
├── failures_for_domain_and_presentation/ # Domain + UI error types
│   ├── enums.dart                         # FailureKey, ErrorPlugin
│   ├── failure_for_domain.dart            # Failure base types
│   ├── failure_ui_model.dart              # FailureUIModel
│   └── failure_x/                         # Extensions
│       ├── failure_diagnostics_x.dart
│       ├── failure_logger_x.dart
│       ├── failure_navigation.dart
│       └── ui_failures_x.dart
│
├── utils/                                 # Additional helpers
│   ├── consumable.dart                    # Consumable<T> wrapper
│   ├── dsl_result_handler.dart            # DSLLikeResultHandler
│   ├── dsl_result_handler_async.dart      # Async version
│   └── failure_mapper.dart                # Exception to Failure mapper
│
├── Errors_Handling_FLOW.md               # Visualized flow diagram (optional)
├── One_time_error_displaying.md          # Additional strategy pattern for UI
└── README.md                              # Developer manual for error system
```

---

## 📊 When to Choose Which

| Criteria                        | AZER (Classic) | DSL-like Handler     |
| ------------------------------- | -------------- | -------------------- |
| ✅ Predictable and explicit      | ✔️ Yes         | ❌ Less explicit      |
| ✅ Declarative & chainable       | ❌ No           | ✔️ Yes               |
| ✅ Requires no extra wrappers    | ✔️ Yes         | ❌ Needs `.then(...)` |
| ✅ Team prefers functional style | ❌ Maybe        | ✔️ Perfect fit       |

> 🧠 **Recommendation:** Use AZER by default for UI state management (Cubit/BLoC). DSL-style is best for expressive chains and functional flows.

---

## 🔚 Conclusion

Both systems are **production-ready**, **testable**, and **aligned with Clean Architecture**. Use either approach per feature preference — but stay consistent within each module.

Always aim for clarity, testability, and clean separation of failure concerns.

---

🧪 Happy error handling & bulletproof code! ☕️
