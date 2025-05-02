// 📦 Dependency Injection Container Setup
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/get_it_x.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/presentation/auth/auth_bloc/auth_bloc.dart';
import '../../shared_moduls/theme/theme_cubit/theme_cubit.dart';
import '../../../features/shared_data/repositories/auth_repository.dart';
import '../../../features/shared_data/repositories/profile_repository.dart';

final di = GetIt.instance;

/// 🧱 Initializes and registers all app dependencies
Future<void> initDIContainer() async {
  di
    // 🔗 Firebase Core Services
    ..registerLazySingletonIfAbsent<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingletonIfAbsent<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    )
    // 📦 Repositories (Data Layer)
    ..registerLazySingletonIfAbsent<AuthRepository>(
      () => AuthRepository(
        firestore: di<FirebaseFirestore>(),
        firebaseAuth: di<FirebaseAuth>(),
      ),
    )
    ..registerLazySingletonIfAbsent<ProfileRepository>(
      () => ProfileRepository(firestore: di<FirebaseFirestore>()),
    )
    // 📊 Cubit / BLoC (Presentation Layer)
    ..registerLazySingletonIfAbsent<AuthBloc>(
      () => AuthBloc(authRepository: di()),
    )
    ..registerLazySingletonIfAbsent<AppThemeCubit>(() => AppThemeCubit());
}
