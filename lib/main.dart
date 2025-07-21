import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/base_modules/localization/app_localization.dart';
import 'core/shared_domain_layer/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import 'core/base_modules/navigation/core/router_cubit.dart';
import 'core/base_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import 'core/base_modules/theme/theme_cubit.dart';
import 'root_view_shell.dart';
import 'app_bootstrap_and_config/app_bootstrap.dart';
import 'app_bootstrap_and_config/di_container/di_container.dart';

/// 🏁 Entry point of the application
void main() async {
  ///
  final appBootstrap = const AppBootstrap(
    // ? Here can be plugged in custom dependencies (e.g.  "localStorage: IsarLocalStorage()," )
  );

  /// 🚀 Runs all startup logic (localization, Firebase, full DI container, debug tools, local storage, etc).
  await appBootstrap.initAllServices();

  /// 🏁 Launches app
  runApp(const AppLocalizationShell());
  //
}

////

////

/// 🌍✅ [AppLocalizationShell] — Ensures the entire app tree is properly localized before rendering the root UI.

final class AppLocalizationShell extends StatelessWidget {
  ///----------------------------------------------
  const AppLocalizationShell({super.key});

  @override
  Widget build(BuildContext context) {
    //
    /// Injects localization context into the widget tree.
    /// Provides all supported locales and translation assets to [child].
    return AppLocalization.configure(const GlobalProviders());
  }
}

////

////

/// 📦 [GlobalProviders] — Wraps all global Blocs with providers for the app

final class GlobalProviders extends StatelessWidget {
  ///--------------------------------------------
  const GlobalProviders({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<AuthCubit>()),
        BlocProvider.value(value: di<RouterCubit>()),
        BlocProvider.value(value: di<AppThemeCubit>()),
        BlocProvider.value(value: di<OverlayStatusCubit>()),
      ],
      child: const AppRootViewShell(),
    );
  }
}


/*

видалити сервіси, логіка в UseCases, 


2. 
Вже є OverlayDispatcher, FailureUIEntity та Consumable. Це означає, що можна легко додати retry-флоу за аналогією з твоїм Riverpod-проєктом.

final class SignInUseCase {
  final IAuthRepo _repo;
  final EnsureUserProfileCreatedUseCase _ensure;

  const SignInUseCase(this._repo, this._ensure);

  ResultFuture<void> call({
    required String email,
    required String password,
  }) async {
    final signInResult = await _repo.signIn(email: email, password: password);
    if (signInResult.isLeft) return Left(signInResult.leftOrThrow());

    final user = signInResult.rightOrThrow().user;
    if (user == null) return Left(UnknownFailure(message: 'User is null'));

    return _ensure(user);
  }
}



!! Впровадьте Repository Pattern з cache layer для офлайн підтримки



 */


/*

[ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: Bad state: ❌ Circular dependency or missing dependencies detected!
Remaining modules: AuthModule, ProfileModule, NavigationModule, OverlaysModule
Missing dependencies: FirebaseModule, AuthModule, ThemeModule, NavigationModule
Registered modules: DIModule
#0      ModuleManager.registerModules (package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/core/di_module_manager.dart:58:9)

#1      DIContainer.initFull (package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/di_container.dart:30:5)

#2      AppBootstrap.initGlobalDIContainer (package:firebase_with_bloc_or_cubit/app_bootstrap_and



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

  /// 🎯  Registers all core dependencies for the main app tree
  static Future initFull() async {
    await ModuleManager.registerModules([
      //
      ThemeModule(),

      FirebaseModule(),
      AuthModule(),
      ProfileModule(),

      NavigationModule(),

      OverlaysModule(),

      FormFieldsModule(),

      //
    ]);
    debugPrint('📦 Full DI initialized with modules');
  }

  ////

  /// 🎯 Registers only the minimal DI needed for the splash/loader (e.g. theme cubit).
  static Future initNecessaryForAppSplashScreen() async {
    await ModuleManager.registerModules([ThemeModule()]);
    debugPrint('📦 Minimal DI initialized (currently: Theme Cubit) ');
  }

  //
}




/// 🎨 Registers theme Cubit for loader (and later, the main app).
//
final class ThemeModule implements DIModule {
  ///-------------------------------------
  //
  @override
  String get name => 'ThemeModule';

  ///
  @override
  List get dependencies => const [];

  ///
  @override
  Future register() async {
    di.registerLazySingleton(() => AppThemeCubit());
  }

  ///
  @override
  Future dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}



final class FirebaseModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'FirebaseModule';

  ///
  @override
  List get dependencies => const [];

  ///
  @override
  Future register() async {
    di.registerLazySingleton(() => FirebaseAuth.instance);
    di.registerLazySingleton(
      () => FirebaseFirestore.instance,
    );
    di.registerLazySingleton>>(
      () => FirebaseFirestore.instance.collection('users'),
    );
    di.registerLazySingleton>>(
      () => FirebaseFirestore.instance.collection('users'),
      instanceName: 'usersCollection',
    );
  }

  ///
  @override
  Future dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}



final class AuthModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'AuthModule';

  ///
  @override
  List get dependencies => [FirebaseModule];
  //

  ///
  @override
  Future register() async {
    //
    // Data Sources
    di.registerLazySingleton(
      () => AuthRemoteDataSourceImpl(),
    );

    // Repositories
    di.registerLazySingleton(() => SignInRepoImpl(di()));
    di.registerLazySingleton(() => SignOutRepoImpl(di()));
    di.registerLazySingleton(() => SignUpRepoImpl(di()));

    // Use Cases
    di.registerLazySingleton(() => SignInUseCase(di()));
    di.registerLazySingleton(() => SignUpUseCase(di()));
    di.registerLazySingleton(() => SignOutUseCase(di()));

    // AuthStreamCubit
    di.registerLazySingleton(
      () => AuthCubit(userStream: di().authStateChanges()),
    );

    // Sign out Cubit
    di.registerLazySingleton(() => SignOutCubit(di()));
    //
  }

  ////

  ///
  @override
  Future dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}



final class ProfileModule implements DIModule {
  ///---------------------------------------
  //
  @override
  String get name => 'ProfileModule';

  ///
  @override
  List get dependencies => [FirebaseModule, AuthModule];
  //

  ///
  @override
  Future register() async {
    //
    // Data Sources
    di.registerLazySingleton(
      () => ProfileRemoteDataSourceImpl(
        di>>(),
      ),
    );

    // Repositories
    di.registerLazySingleton(() => ProfileRepoImpl(di()));

    // Use Cases
    di.registerLazySingleton(() => FetchProfileUseCase(di()));

    //
  }

  ////

  ///
  @override
  Future dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}



/// 🧭🚦 Registers the router Cubit (navigation logic).
//
final class NavigationModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'NavigationModule';

  ///
  @override
  List get dependencies => const [AuthModule];

  ///
  @override
  Future register() async {
    di.registerLazySingleton(() => RouterCubit(di()));
  }

  ///
  @override
  Future dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}



final class OverlaysModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'OverlaysModule';

  ///
  @override
  List get dependencies => const [ThemeModule, NavigationModule];

  ///
  @override
  Future register() async {
    di
      ..registerLazySingletonIfAbsent(() => OverlayStatusCubit())
      ..registerLazySingletonIfAbsent(
        () => OverlayDispatcher(
          onOverlayStateChanged: di().updateStatus,
        ),
      );
  }

  ///
  @override
  Future dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}



///  🔐 Registers form validation service
//
final class FormFieldsModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'FormFieldsModule';

  ///
  @override
  List get dependencies => const [];

  ///
  @override
  Future register() async {
    di.registerLazySingleton(() => const FormValidationService());
  }

  ///
  @override
  Future dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}

 */