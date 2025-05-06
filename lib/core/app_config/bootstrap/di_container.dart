import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/data/data_source.dart';
import '../../../features/auth/data/impl_of_data_source.dart';
import '../../../features/auth/data/auth_repository_impl.dart';
import '../../../features/auth/domain/repositories/auth_repo.dart';
import '../../../features/auth/domain/use_cases/ensure_profile_created.dart';
import '../../../features/auth/domain/use_cases/sign_in.dart';
import '../../../features/auth/domain/use_cases/sign_out.dart';
import '../../../features/auth/domain/use_cases/sign_up.dart';
import '../../../features/auth/presentation/auth_bloc/auth_bloc.dart';

import '../../../features/profile/data/data_source.dart';
import '../../../features/profile/data/impl_of_data_source.dart';
import '../../../features/profile/data/_profile_repo_impl.dart';
import '../../../features/profile/domain/profile_repository.dart';
import '../../../features/profile/domain/load_profile_use_case.dart';

import '../../services/show_dialog.dart';
import '../../shared_modules/theme/theme_cubit/theme_cubit.dart';
import '../../utils/extensions/general_extensions/get_it_safe_di_x.dart';

/// 💡 di_container.dart — All app-wide dependency registrations
final di = GetIt.instance;

/// 🧱 Registers all app-level dependencies via GetIt
Future<void> initDIContainer() async {
  di
    // 🔗 Firebase core services
    ..registerLazySingletonIfAbsent<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingletonIfAbsent<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    )
    ///
    // 🚀 Services
    ..registerLazySingletonIfAbsent<IShowDialog>(
      () => const MaterialDialogService(),
    )
    ///
    // 📡 Remote data sources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () =>
          AuthRemoteDataSourceImpl(di<FirebaseAuth>(), di<FirebaseFirestore>()),
    )
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(di<FirebaseFirestore>()),
    )
    ///
    // 📦 Repository implementations
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepositoryImpl(di<AuthRemoteDataSource>()),
    )
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(di<ProfileRemoteDataSource>()),
    )
    ///
    // 🧠 Use cases
    ..registerLazySingleton<SignInUseCase>(() => SignInUseCase(di<AuthRepo>()))
    ..registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(di<AuthRepo>()))
    ..registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(di<AuthRepo>()),
    )
    ..registerLazySingleton<EnsureUserProfileCreatedUseCase>(
      () => EnsureUserProfileCreatedUseCase(di<AuthRepo>()),
    )
    ..registerLazySingleton<LoadProfileUseCase>(
      () => LoadProfileUseCase(di<ProfileRepository>()),
    )
    ///
    // 📊 BLoC / Cubits
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        signOutUseCase: di<SignOutUseCase>(),
        userStream: di<AuthRemoteDataSource>().user,
      ),
    )
    ..registerLazySingleton<AppThemeCubit>(() => AppThemeCubit());
}
