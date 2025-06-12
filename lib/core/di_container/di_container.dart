import 'package:firebase_with_bloc_or_cubit/core/di_container/di_safe_registration_x.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/auth/data/data_source_contract.dart';
import '../../features/auth/data/impl_of_data_source_contract.dart';
import '../../features/auth/data/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repo.dart';
import '../../features/auth/domain/use_cases/ensure_profile_created.dart';
import '../../features/auth/domain/use_cases/sign_in.dart';
import '../../features/auth/domain/use_cases/sign_out.dart';
import '../../features/auth/domain/use_cases/sign_up.dart';
import '../../features/auth/presentation/auth_bloc/auth_bloc.dart';

import '../../features/profile/data/data_source_contract.dart';
import '../../features/profile/data/impl_of_data_source_contract.dart';
import '../../features/profile/data/_profile_repo_impl.dart';
import '../../features/profile/domain/profile_repository.dart';
import '../../features/profile/domain/load_profile_use_case.dart';

import '../shared_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../shared_modules/overlays/overlay_dispatcher/_overlay_dispatcher.dart';
import '../shared_modules/theme/theme_cubit/theme_cubit.dart';

/// 💠 Global [GetIt] instance used as service locator across the app
final di = GetIt.instance;

/// 🚀 [AppDI] — Centralized class for dependency registration
/// ✅ Separates responsibilities by layers: Services, DataSources, UseCases, Blocs
///-----------------------------------------------------------------------------
abstract final class AppDI {
  AppDI._();

  /// 🎯 Entry point — call once in `main()`
  static Future<void> init() async {
    _registerOverlaysHandlers();
    _registerTheme();

    _registerFirebase();
    _registerProfile();
    _registerUseCases();
    _registerRepositories();
    _registerDataSources();
  }

  /// 🔍 Registers overlay handlers
  static void _registerOverlaysHandlers() {
    di
      ..registerLazySingleton(() => OverlayStatusCubit())
      ..registerLazySingleton(
        () => OverlayDispatcher(
          onOverlayStateChanged: di<OverlayStatusCubit>().updateStatus,
        ),
      );
  }

  /// 🎨 Registers theme
  static void _registerTheme() {
    di.registerLazySingleton(() => AppThemeCubit());
  }

  /// 🔗 Registers core Firebase dependencies
  static void _registerFirebase() {
    di
      ..registerLazySingletonIfAbsent<FirebaseAuth>(() => FirebaseAuth.instance)
      ..registerLazySingletonIfAbsent<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
      );
  }

  /// 🎛️ Registers all Cubits and BLoCs (presentation layer)
  static void _registerProfile() {
    di
      ..registerLazySingleton(
        () => AuthBloc(
          signOutUseCase: di(),
          userStream: di<AuthRemoteDataSource>().user,
        ),
      )
      ..registerLazySingleton(() => LoadProfileUseCase(di())); // 📄 Get profile
  }

  /// 🧠 Registers domain-level use cases
  static void _registerUseCases() {
    di
      ..registerLazySingleton(() => SignInUseCase(di()))
      ..registerLazySingleton(() => SignUpUseCase(di()))
      ..registerLazySingleton(() => SignOutUseCase(di()))
      ..registerLazySingleton(
        () => EnsureUserProfileCreatedUseCase(di()),
      ); // 👤 Firestore sync
  }

  /// 🗂️ Registers concrete repositories (data layer)
  static void _registerRepositories() {
    di
      ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(di()))
      ..registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(di()));
  }

  /// 📡 Registers all remote data sources
  static void _registerDataSources() {
    di.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(di(), di()),
    );
    di.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(di()),
    );
  }

  ///
}
