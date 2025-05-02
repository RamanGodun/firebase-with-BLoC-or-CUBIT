/// 🧩 [injection.dart] — Dependency Injection (DI) configuration
///
/// Registers all singletons/lazy singletons for:
///   - Firebase core services
///   - Repositories (Data Layer)
///   - BLoC / Cubit state managers (Presentation Layer)
///
/// Use `appSingleton<T>()` to resolve dependencies anywhere in the app.
library;

import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/auth_bloc/auth_bloc.dart';
import '../../features/theme/theme_cubit/theme_cubit.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/profile_repository.dart';

final appSingleton = GetIt.instance;

/// * 🧱 Initializes and registers all app dependencies
Future<void> initDependencies() async {
  ///
  // ────────────────────────────────────────────────────────────────
  // 🔗 Firebase Core Services
  // ────────────────────────────────────────────────────────────────
  appSingleton.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  appSingleton.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  /// ────────────────────────────────────────────────────────────────
  /// 📦 Repositories (Data Layer)
  // ────────────────────────────────────────────────────────────────
  appSingleton.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      firestore: appSingleton<FirebaseFirestore>(),
      firebaseAuth: appSingleton<FirebaseAuth>(),
    ),
  );

  appSingleton.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(firestore: appSingleton<FirebaseFirestore>()),
  );

  /// ────────────────────────────────────────────────────────────────
  /// 📊 BLoC / Cubit (Presentation Layer)
  // ────────────────────────────────────────────────────────────────
  appSingleton.registerLazySingleton<AuthBloc>(
    () => AuthBloc(authRepository: appSingleton()),
  );

  appSingleton.registerLazySingleton<AppThemeCubit>(() => AppThemeCubit());
}
