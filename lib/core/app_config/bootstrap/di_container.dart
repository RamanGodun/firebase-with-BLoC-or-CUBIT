import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/presentation/auth/auth_bloc/auth_bloc.dart';
import '../../../features/profile/data/data_sources/data_source.dart';
import '../../../features/profile/data/data_sources/impl_of_data_source.dart';
import '../../../features/profile/data/repositories/profile_repo_impl.dart';
import '../../../features/profile/domain/use_cases/load_profile_use_case.dart';
import '../../../features/profile/domain/repositories/profile_repository.dart';
import '../../shared_modules/theme/theme_cubit/theme_cubit.dart';
import '../../../features/auth/data/repo/auth_repository_impl.dart';
import '../../../core/utils/extensions/general_extensions/get_it_x.dart';

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
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(di<FirebaseFirestore>()),
    )
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(di<ProfileRemoteDataSource>()),
    )
    ..registerLazySingletonIfAbsent<AuthRepository>(
      () => AuthRepository(
        firestore: di<FirebaseFirestore>(),
        firebaseAuth: di<FirebaseAuth>(),
      ),
    )
    // 📂 Use Cases (Domain Layer)
    ..registerLazySingletonIfAbsent(
      () => LoadProfileUseCase(di<ProfileRepository>()),
    )
    // 📊 Cubit / BLoC (Presentation Layer)
    ..registerLazySingletonIfAbsent<AuthBloc>(
      () => AuthBloc(authRepository: di()),
    )
    ..registerLazySingletonIfAbsent<AppThemeCubit>(() => AppThemeCubit());
}
