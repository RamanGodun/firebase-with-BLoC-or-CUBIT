import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/auth_bloc/auth_bloc.dart';
import '../../features/profile/profile_bloc/profile_cubit.dart';
import '../../features/sign_in/sign_in_bloc/signin_cubit.dart';
import '../../features/sign_up/signup_bloc/signup_cubit.dart';
import '../../features/auth/auth_repository.dart';
import '../../features/profile/data/profile_repository.dart';
import '../../features/theme/theme_cubit/theme_cubit.dart';

final appSingleton = GetIt.instance;

Future<void> initDependencies() async {
  // Firebase Core dependencies
  appSingleton.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  appSingleton.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Repositories
  appSingleton.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      firebaseFirestore: appSingleton(),
      firebaseAuth: appSingleton(),
    ),
  );

  appSingleton.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(firebaseFirestore: appSingleton()),
  );

  // Cubits / BLoCs
  appSingleton.registerLazySingleton<AuthBloc>(
    () => AuthBloc(authRepository: appSingleton()),
  );
  appSingleton.registerFactory(
    () => SigninCubit(authRepository: appSingleton()),
  );
  appSingleton.registerFactory(
    () => SignupCubit(authRepository: appSingleton()),
  );
  appSingleton.registerFactory(
    () => ProfileCubit(profileRepository: appSingleton()),
  );
  appSingleton.registerFactory(() => AppThemeCubit());
}
