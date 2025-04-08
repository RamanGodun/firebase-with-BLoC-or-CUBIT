import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/auth_bloc/auth_bloc.dart';
import '../../features/profile/profile_cubit/profile_cubit.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../features/theme/theme_cubit/theme_cubit.dart';

final appSingleton = GetIt.instance;

Future<void> initDependencies() async {
  // Firebase Core dependencies
  appSingleton.registerLazySingleton(() => FirebaseAuth.instance);
  appSingleton.registerLazySingleton(() => FirebaseFirestore.instance);

  /// Repositories
  appSingleton.registerLazySingleton<AuthRepository>(
    () =>
        AuthRepository(firestore: appSingleton(), firebaseAuth: appSingleton()),
  );

  appSingleton.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(firestore: appSingleton()),
  );

  /// Cubits / BLoCs
  appSingleton.registerLazySingleton<AuthBloc>(
    () => AuthBloc(authRepository: appSingleton()),
  );

  appSingleton.registerFactory(
    () => ProfileCubit(profileRepository: appSingleton()),
  );

  appSingleton.registerFactory(() => AppThemeCubit());
}
