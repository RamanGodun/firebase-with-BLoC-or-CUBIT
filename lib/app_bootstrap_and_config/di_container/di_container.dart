import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get_it/get_it.dart';

import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/get_it_x.dart';

import '../../features/auth/data/auth_repository_impl.dart';
import '../../features/auth/data/i_data_source.dart';
import '../../features/auth/data/data_source_impl.dart';
import '../../features/auth/domain/i_repo.dart';
import '../../features/auth/domain/use_cases/ensure_profile_created.dart';
import '../../features/auth/domain/use_cases/sign_in.dart';
import '../../features/auth/domain/use_cases/sign_out.dart';
import '../../features/auth/domain/use_cases/sign_up.dart';
import '../../features/auth/presentation/sign_out/sign_out_cubit/sign_out_cubit.dart';
import '../../features/form_fields/utils/_form_validation_service.dart';
import '../../features/profile/data/_profile_repo_impl.dart';
import '../../features/profile/data/data_source_contract.dart';
import '../../features/profile/data/impl_of_data_source_contract.dart';
import '../../features/profile/domain/fetch_profile_use_case.dart';
import '../../features/profile/domain/i_repo.dart';
import '../../core/shared_domain_layer/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import '../../core/base_modules/navigation/core/router_cubit.dart';
import '../../core/base_modules/overlays/overlay_dispatcher/_overlay_dispatcher.dart';
import '../../core/base_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../../core/base_modules/theme/theme_cubit.dart';

/// 💠 Global [GetIt] instance used as service locator across the app
final di = GetIt.instance;

////
////

/// 🚀 [DIContainer] — Centralized class for dependency registration
/// ✅ Separates all responsibilities by layers: Services, DataSources, UseCases, Blocs, etc.
///    - Call [initNecessaryForAppSplashScreen] first for splash/loader dependencies.
///    - Call [initFull] for all core app dependencies after the splash.

abstract final class DIContainer {
  ///---------------------
  DIContainer._();
  //

  ////

  /// 🎯  Registers all core dependencies for the main app tree
  static Future<void> initFull() async {
    ///
    _registerTheme();
    //
    _registerFirebase();
    //
    _registerDataSources();
    //
    _registerRepositories();
    //
    _registerUseCases();
    //
    _authState();
    //
    _registerOverlaysHandlers();
    //
    _registerServices();
    //
    _registerRouter();

    debugPrint('📦 Full DI initialized');
    //
  }

  ////

  ////

  /// 🎨 Registers theme Cubit for loader (and later, the main app).
  static void _registerTheme() {
    ///
    di.registerLazySingletonIfAbsent(() => AppThemeCubit());
  }

  ////

  /// 🔗 Registers core Firebase dependencies
  static void _registerFirebase() {
    ///
    di
      ..registerLazySingletonIfAbsent<FirebaseAuth>(() => FirebaseAuth.instance)
      ..registerLazySingletonIfAbsent<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
      );
  }

  ////

  /// 📡 Registers all remote data sources for auth/profile.
  static void _registerDataSources() {
    ///
    di.registerLazySingletonIfAbsent<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(di(), di()),
    );
    di.registerLazySingletonIfAbsent<IProfileRemoteDatabase>(
      () => ProfileRemoteDataSourceImpl(di()),
    );
  }

  ////

  /// 🗂️ Registers data layer repositories.
  static void _registerRepositories() {
    ///
    di
      ..registerLazySingletonIfAbsent<IAuthRepo>(() => AuthRepoImpl(di()))
      ..registerLazySingletonIfAbsent<IProfileRepo>(
        () => ProfileRepoImpl(di()),
      );
  }

  ////

  /// 🧠 Registers all domain-level use cases (auth, profile, etc).
  static void _registerUseCases() {
    ///
    di
      ..registerLazySingletonIfAbsent(() => SignOutCubit(di<SignOutUseCase>()))
      ..registerLazySingletonIfAbsent(() => SignInUseCase(di()))
      ..registerLazySingletonIfAbsent(() => SignUpUseCase(di()))
      ..registerLazySingletonIfAbsent(() => SignOutUseCase(di()))
      ..registerLazySingletonIfAbsent(() => FetchProfileUseCase(di()))
      ..registerLazySingletonIfAbsent(
        () => EnsureUserProfileCreatedUseCase(di()),
      ); // 👤 Firestore sync
  }

  ////

  /// 👤 Registers the Auth State Cubit (streams user auth state).
  static void _authState() {
    ///
    di.registerLazySingletonIfAbsent(
      () => AuthCubit(userStream: di<AuthRemoteDataSource>().user),
    );
  }

  ////

  /// 🔍 Registers overlays, overlay status Cubit, and dispatcher.
  static void _registerOverlaysHandlers() {
    ///
    di
      ..registerLazySingletonIfAbsent(() => OverlayStatusCubit())
      ..registerLazySingletonIfAbsent(
        () => OverlayDispatcher(
          onOverlayStateChanged: di<OverlayStatusCubit>().updateStatus,
        ),
      );
  }

  ////

  /// 🧭🚦 Registers the router Cubit (navigation logic).
  static void _registerRouter() {
    ///
    di.registerLazySingletonIfAbsent<RouterCubit>(
      () => RouterCubit(di<AuthCubit>()),
    );
  }

  ////

  ///  🔐 Registers form validation service
  static void _registerServices() {
    ///
    di.registerLazySingletonIfAbsent(() => const FormValidationService());
  }

  ////

  /// 🎯 Registers only the minimal DI needed for the splash/loader (e.g. theme cubit).
  static Future<void> initNecessaryForAppSplashScreen() async {
    ///
    _registerTheme();
    debugPrint('📦 Minimal DI initialized (currently: Theme Cubit) ');
    //
  }

  //
}
