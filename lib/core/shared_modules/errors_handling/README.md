# 🛡️ Error Handling System — Manual for Developers

---

## 📦 Overview

This module implements a **unified, scalable error handling system** that supports two alternative paradigms:

* 🧊 **AZER** — Classic, explicit and readable error flow using `Either<Failure, T>` and `.fold(...)`
* 🔗 **DSL-like** — Declarative, chainable alternative inspired by functional programming, using `DSLLikeResultHandler` and `matchAsync()` extensions

Each approach is interchangeable and can be selected per feature or team preference.

---

## 🔁 AZER: Explicit (Classic) Style

### ✅ When to Use:

* You want **full control** over success and failure handling
* You prefer **clarity** and **predictable flow**
* Common in Cubit/BLoC state management

### 🧩 Code Example:

```dart
final result = await getUserUseCase();

result.fold(
  (f) => emit(Failed(f)),
  (u) => emit(Loaded(u)),
);
```

---

## 🧪 DSL-like Style

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

### ✨ Advanced Chaining:

```dart
await getUserUseCase()
  .flatMapAsync((u) => checkAccess(u))
  .recover((f) => getGuestUser())
  .mapRightAsync((u) => saveLocally(u))
  .then((r) => DSLLikeResultHandler(r).log());
```

---

## 🧩 Integration in Cubit

### 🧊 AZER-style Cubit Example:

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
├── dsl_like_result/                     # DSL-style result wrappers
│   ├── result_handler.dart              # DSLLikeResultHandler<T>
│   └── result_handler_async.dart        # DSLLikeResultHandlerAsync<T>
│
├── either/                              # Functional Either construct
│   ├── either.dart                      # Core Either<L, R> class
│   ├── unit.dart                        # Functional void-like replacement
│   └── extensions/                      # Helpers for fold/map/etc
│       └── either_x.dart, ...
│
├── failures/                            # Domain-level failure models
│   ├── _failure.dart                    # Base types (ApiFailure, etc.)
│   ├── failure_keys_enum.dart           # i18n keys for localization
│   ├── extensions/                      # UI/logging/source extensions
│   └── handlers/                        # FailureMapper, plugin enums
│       ├── _failure_mapper.dart
│       └── error_plugin_enums.dart
│
├── loggers/                             # Logging and diagnostics
│   ├── i_logger_contract.dart           # Logger interface
│   ├── app_error_logger.dart            # Debug + Crashlytics logger
│   ├── crash_analytics_logger.dart      # FirebaseCrashlytics wrapper
│   └── app_bloc_observer.dart           # BlocObserver with failure tracking
│
└── README.md                            # Developer manual for error system
```

---

## 📊 When to Choose Which

| Criteria                        | AZER (Classic) | DSL-like Handler     |
| ------------------------------- | -------------- | -------------------- |
| ✅ Predictable and explicit      | ✔️ Yes         | ❌ Less explicit     |
| ✅ Declarative & chainable       | ❌ No          | ✔️ Yes               |
| ✅ Requires no extra wrappers    | ✔️ Yes         | ❌ Needs `.then(...)`|
| ✅ Team prefers functional style | ❌ Maybe       | ✔️ Perfect fit       |

> 🧠 **Recommendation:** Use AZER by default for UI state management (Cubit/BLoC). DSL-style is best for expressive chains and functional flows.

---

## 🔚 Conclusion

Both systems are **production-ready**, **testable**, and **aligned with Clean Architecture**. Use either approach per feature preference — but stay consistent within each module.

Always aim for clarity, testability, and clean separation of failure concerns.

---

🧪 Happy error handling & bulletproof code! ☕
