import 'package:get_it/get_it.dart';

/// 🔁 Extension for Safe Registration
extension SafeRegistration on GetIt {
  void registerLazySingletonIfAbsent<T extends Object>(T Function() factory) {
    if (!isRegistered<T>()) registerLazySingleton<T>(factory);
  }

  void registerFactoryIfAbsent<T extends Object>(T Function() factory) {
    if (!isRegistered<T>()) registerFactory<T>(factory);
  }

  void registerSingletonIfAbsent<T extends Object>(T instance) {
    if (!isRegistered<T>()) registerSingleton<T>(instance);
  }
}
