import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/get_it_safe_di_x.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/auth/data/data_source_contract.dart';
import '../../../features/auth/data/impl_of_data_source_contract.dart';
import '../../../features/auth/data/auth_repository_impl.dart';
import '../../../features/auth/domain/repositories/auth_repo.dart';
import '../../../features/auth/domain/use_cases/ensure_profile_created.dart';
import '../../../features/auth/domain/use_cases/sign_in.dart';
import '../../../features/auth/domain/use_cases/sign_out.dart';
import '../../../features/auth/domain/use_cases/sign_up.dart';
import '../../../features/auth/presentation/auth_bloc/auth_bloc.dart';

import '../../../features/profile/data/data_source_contract.dart';
import '../../../features/profile/data/impl_of_data_source_contract.dart';
import '../../../features/profile/data/_profile_repo_impl.dart';
import '../../../features/profile/domain/profile_repository.dart';
import '../../../features/profile/domain/load_profile_use_case.dart';

import '../../shared_modules/loggers/crash_analytics_logger.dart';
import '../../shared_modules/loggers/i_logger_contract.dart';
import '../../shared_modules/overlay/core/overlay_dispatcher/_overlay_dispatcher.dart';
import '../../shared_modules/overlay/core/overlay_dispatcher/overlay_dispatcher_contract.dart';
import '../../shared_modules/theme/theme_cubit/theme_cubit.dart';

/// 💠 Global instance of GetIt DI container
final di = GetIt.instance;

/// 🚀 [AppDI] — Centralized class for dependency registration
/// ✅ Separates responsibilities by layers: Services, DataSources, UseCases, Blocs
///-----------------------------------------------------------------------------
final class AppDI {
  AppDI._();

  /// 🎯 Entry point — call once in `main()`
  static Future<void> init() async {
    _registerSharedModules();
    _registerFirebase();
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
    _registerBlocs();
  }

  /// 🔍 Registers global logging services (e.g., Crashlytics, Console).
  /// Used across all layers via [AppErrorLogger] abstraction.
  static void _registerSharedModules() {
    di.registerLazySingletonIfAbsent<ILogger>(() => CrashlyticsLogger());
    di.registerLazySingletonIfAbsent<IOverlayDispatcher>(
      () => OverlayDispatcher(),
    );
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
    di
      ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(di(), di()),
      )
      ..registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(di()),
      );
  }

  /// 🗂️ Registers concrete repositories (data layer)
  static void _registerRepositories() {
    di
      ..registerLazySingleton<AuthRepo>(() => AuthRepositoryImpl(di()))
      ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(di()),
      );
  }

  /// 🧠 Registers domain-level use cases
  static void _registerUseCases() {
    di
      ..registerLazySingleton(() => SignInUseCase(di()))
      ..registerLazySingleton(() => SignUpUseCase(di()))
      ..registerLazySingleton(() => SignOutUseCase(di()))
      ..registerLazySingleton(
        () => EnsureUserProfileCreatedUseCase(di()),
      ) // 👤 Firestore sync
      ..registerLazySingleton(() => LoadProfileUseCase(di())); // 📄 Get profile
  }

  /// 🎛️ Registers all Cubits and BLoCs (presentation layer)
  static void _registerBlocs() {
    di
      ..registerLazySingleton(
        () => AuthBloc(
          signOutUseCase: di(),
          userStream: di<AuthRemoteDataSource>().user,
        ),
      )
      ..registerLazySingleton(() => AppThemeCubit());
  }

  ///
}
