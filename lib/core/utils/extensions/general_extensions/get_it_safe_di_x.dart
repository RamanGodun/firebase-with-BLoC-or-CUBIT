import 'package:get_it/get_it.dart';

/// 🧩 [SafeRegistration] — Extension on [GetIt] for safe DI registration
/// ✅ Prevents double registration crashes in shared or reloaded environments (like tests, hot reload)
//----------------------------------------------------------------

extension SafeRegistration on GetIt {
  /// 💤 Registers a lazy singleton if not already registered
  /// - `T`: the type to register
  void registerLazySingletonIfAbsent<T extends Object>(T Function() factory) {
    if (!isRegistered<T>()) registerLazySingleton<T>(factory);
  }

  /// 🏭 Registers a factory if not already registered
  /// - Use when a new instance is needed on each `get<T>()` call
  void registerFactoryIfAbsent<T extends Object>(T Function() factory) {
    if (!isRegistered<T>()) registerFactory<T>(factory);
  }

  /// 📦 Registers a singleton instance if not already registered
  /// - Use for immutable/global services
  void registerSingletonIfAbsent<T extends Object>(T instance) {
    if (!isRegistered<T>()) registerSingleton<T>(instance);
  }

  ///
}
