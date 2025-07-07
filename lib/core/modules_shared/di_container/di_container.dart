import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get_it/get_it.dart';

import 'package:firebase_with_bloc_or_cubit/core/modules_shared/di_container/di_safe_registration_x.dart';

import '../../../features/auth/data/auth_repository_impl.dart';
import '../../../features/auth/data/data_source_contract.dart';
import '../../../features/auth/data/impl_of_data_source_contract.dart';
import '../../../features/auth/domain/repositories/auth_repo.dart';
import '../../../features/auth/domain/use_cases/ensure_profile_created.dart';
import '../../../features/auth/domain/use_cases/sign_in.dart';
import '../../../features/auth/domain/use_cases/sign_out.dart';
import '../../../features/auth/domain/use_cases/sign_up.dart';
import '../../../features/auth/presentation/sign_out/sign_out_cubit/sign_out_cubit.dart';
import '../../../features/form_fields/utils/_form_validation_service.dart';
import '../../../features/profile/data/_profile_repo_impl.dart';
import '../../../features/profile/data/data_source_contract.dart';
import '../../../features/profile/data/impl_of_data_source_contract.dart';
import '../../../features/profile/domain/load_profile_use_case.dart';
import '../../../features/profile/domain/profile_repository.dart';
import '../../layers_shared/domain_shared/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import '../navigation/core/router_cubit.dart';
import '../overlays/overlay_dispatcher/_overlay_dispatcher.dart';
import '../overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../theme/theme_cubit.dart';

/// 💠 Global [GetIt] instance used as service locator across the app
final di = GetIt.instance;

////

/// 🚀 [DIContainer] — Centralized class for dependency registration
/// ✅ Separates responsibilities by layers: Services, DataSources, UseCases, Blocs

abstract final class DIContainer {
  ///---------------------
  DIContainer._();

  ///

  /// 🎯 Minimal DI — only essential services for splash screen
  static Future<void> initMinimal() async {
    ///
    _registerTheme();

    debugPrint('📦 Minimal DI initialized');

    //
  }

  ///

  /// 🎯 Entry point — call once in `main()`
  static Future<void> initFull() async {
    ///
    // _registerTheme();

    _registerFirebase();

    _registerDataSources();

    _registerRepositories();

    _registerUseCases();

    _authState();

    _registerOverlaysHandlers();

    _registerRouter();

    _registerServices();

    debugPrint('📦 Full DI initialized');

    //
  }

  ///

  /// 🎨 Registers theme
  static void _registerTheme() {
    di.registerLazySingletonIfAbsent(() => AppThemeCubit());
  }

  /// 🔗 Registers core Firebase dependencies
  static void _registerFirebase() {
    di
      ..registerLazySingletonIfAbsent<FirebaseAuth>(() => FirebaseAuth.instance)
      ..registerLazySingletonIfAbsent<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
      );
  }

  /// 📡 Registers all remote data sources
  static void _registerDataSources() {
    di.registerLazySingletonIfAbsent<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(di(), di()),
    );
    di.registerLazySingletonIfAbsent<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(di()),
    );
  }

  /// 🗂️ Registers concrete repositories (data layer)
  static void _registerRepositories() {
    di
      ..registerLazySingletonIfAbsent<AuthRepo>(() => AuthRepoImpl(di()))
      ..registerLazySingletonIfAbsent<ProfileRepo>(() => ProfileRepoImpl(di()));
  }

  /// 🧠 Registers domain-level use cases
  static void _registerUseCases() {
    di
      ..registerLazySingletonIfAbsent(() => SignOutCubit(di<SignOutUseCase>()))
      ..registerLazySingletonIfAbsent(() => SignInUseCase(di()))
      ..registerLazySingletonIfAbsent(() => SignUpUseCase(di()))
      ..registerLazySingletonIfAbsent(() => SignOutUseCase(di()))
      ..registerLazySingletonIfAbsent(() => LoadProfileUseCase(di()))
      ..registerLazySingletonIfAbsent(
        () => EnsureUserProfileCreatedUseCase(di()),
      ); // 👤 Firestore sync
  }

  /// 👤 Registers Auth State Cubit
  static void _authState() {
    di.registerLazySingletonIfAbsent(
      () => AuthCubit(userStream: di<AuthRemoteDataSource>().user),
    );
  }

  /// 🔍 Registers overlay handlers
  static void _registerOverlaysHandlers() {
    di
      ..registerLazySingletonIfAbsent(() => OverlayStatusCubit())
      ..registerLazySingletonIfAbsent(
        () => OverlayDispatcher(
          onOverlayStateChanged: di<OverlayStatusCubit>().updateStatus,
        ),
      );
  }

  static void _registerRouter() {
    di.registerLazySingletonIfAbsent<RouterCubit>(
      () => RouterCubit(di<AuthCubit>()),
    );
  }

  static void _registerServices() {
    di.registerFactoryIfAbsent(() => const FormValidationService());
  }

  //
}
