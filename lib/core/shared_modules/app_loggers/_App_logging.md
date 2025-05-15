# 📘 Loggers Module — README for Error Logging System

---

## 🧭 Purpose

This module provides a **centralized, scalable, and pluggable error logging system** across the entire Flutter application. It encapsulates all exception and `Failure` logging — from raw SDK errors to mapped domain errors and Bloc/Cubit lifecycle exceptions.

> ✅ SOLID-compliant, DI-compatible, and Crashlytics-ready.

---

## 🗂 Files Included

```bash
loggers/
├── i_logger_contract.dart          # Abstract logging interface
├── crash_analytics_logger.dart     # Crashlytics-based implementation
├── app_error_logger.dart           # Static entrypoint for all layers
├── app_bloc_observer.dart          # BLoC lifecycle observer with logging
├── failure_logger_x.dart           # Extensions for `Failure.log()` and raw errors
└── README.md                       # This file
```


---



## 🔌 How to Connect (Dependency Injection)

### 1️⃣ Register `ILogger` in DI

Register the logger inside your DI container class `AppDI`:

```dart
void _registerLoggers() {
  di.registerLazySingletonIfAbsent<ILogger>(() => CrashlyticsLogger());
}
```

Make sure this happens early — ideally before using `AppErrorLogger` or logging any exceptions.

### 2️⃣ Set up `AppBlocObserver` in `AppBootstrap`

To capture and log `Cubit`/`Bloc`-related errors, initialize the observer in your `AppBootstrap` class:

```dart
static void _initBlocObserver() {
  Bloc.observer = const AppBlocObserver();
}
```

This observer will automatically route all state-layer errors to `AppErrorLogger.logBlocError(...)`.

### 3️⃣ Finalize in `main()`

Ensure both DI and Bloc observer initialization happen in `main()`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppBootstrap.initialize(); // 👁️ Initializes BlocObserver
  await AppDI.init();              // 🔧 Registers ILogger + dependencies

  runApp(const RootProviders());
}
```


---



## 🛠 Usage Guide

### 🔁 In `FailureMapper`

```dart
RawErrorLogger.log(error, stackTrace);
```

### 🧱 In Domain/Presentation Layers

```dart
failure.log();
```

### 🧨 In `BlocObserver`

```dart
AppErrorLogger.logBlocError(
  error: error,
  stackTrace: stackTrace,
  origin: bloc.runtimeType.toString(),
);
```

---

## 🔍 Integration Points by Layer

| Layer        | Integration Example                                                      |
| ------------ | ------------------------------------------------------------------------ |
| Data Layer   | `FailureMapper.from(exception)` logs raw exceptions via `RawErrorLogger` |
| Domain Layer | Any `Failure` calls `.log()` directly                                    |
| State Layer  | Bloc/Cubit errors logged inside `AppBlocObserver.onError()`              |
| UI Layer     | Optional: trigger `Failure.log()` manually in critical paths             |

---

## 🧩 Example: Logging in Cubit

```dart
try {
  final user = await fetchUserFromApi();
  emit(Success(user));
} catch (e, s) {
  final failure = FailureMapper.from(e, s);
  failure.log();
  emit(Error(failure));
}
```

---

## ✅ Benefits

| Feature         | Advantage                                                     |
| --------------- | ------------------------------------------------------------- |
| 🔄 Centralized  | Unified entry point for all logging                           |
| 🔒 Clean Arch   | No logic duplication or scattered `debugPrint`                |
| 🧪 Testable     | `ILogger` easily mockable                                     |
| 📡 Remote Ready | Crashlytics support + extensibility for Sentry, Remote APIs   |
| 🔄 Maintainable | Open/Closed for future destinations (email logger, file etc.) |

---

## 🚀 Future Extensions

* [ ] Add console-only logger for unit tests
* [ ] Add `logWarning()`/`logInfo()` levels
* [ ] Add retry queue for offline log persistence
* [ ] Add remote log dashboard exporter

---

> 💡 **Tip**: Keep `FailureMapper` focused on conversion — logging belongs to this logger module.

Happy debugging! 🐞