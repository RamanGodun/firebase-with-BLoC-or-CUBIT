import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import '../../../core/shared_domain_layer/auth_state_refresher/auth_state_cubit/auth_cubit.dart';
import '../../../features/auth/data/auth_repo_implementations/sign_in_repo_impl.dart';
import '../../../features/auth/data/auth_repo_implementations/sign_out_repo_impl.dart';
import '../../../features/auth/data/auth_repo_implementations/sign_up_repo_impl.dart';
import '../../../features/auth/data/data_source_contract.dart';
import '../../../features/auth/data/data_source_impl.dart';
import '../../../features/auth/domain/repo_contracts.dart';
import '../../../features/auth/domain/use_cases/sign_in.dart';
import '../../../features/auth/domain/use_cases/sign_out.dart';
import '../../../features/auth/domain/use_cases/sign_up.dart';
import '../../../features/auth/presentation/sign_out/sign_out_cubit/sign_out_cubit.dart';
import '../core/di_module_interface.dart';
import '../di_container.dart';
import 'firebase_module.dart';

final class AuthModule implements DIModule {
  ///------------------------------------
  //
  @override
  String get name => 'AuthModule';

  ///
  @override
  List<Type> get dependencies => [FirebaseModule];
  //

  ///
  @override
  Future<void> register() async {
    //
    // Data Sources
    di.registerLazySingleton<IAuthRemoteDatabase>(
      () => AuthRemoteDatabaseImpl(),
    );

    // Repositories
    di.registerLazySingleton<ISignInRepo>(() => SignInRepoImpl(di()));
    di.registerLazySingleton<ISignOutRepo>(() => SignOutRepoImpl(di()));
    di.registerLazySingleton<ISignUpRepo>(() => SignUpRepoImpl(di()));

    // Use Cases
    di.registerLazySingleton(() => SignInUseCase(di()));
    di.registerLazySingleton(() => SignUpUseCase(di()));
    di.registerLazySingleton(() => SignOutUseCase(di()));

    // AuthStreamCubit
    di.registerLazySingleton<AuthCubit>(
      () => AuthCubit(userStream: di<FirebaseAuth>().authStateChanges()),
    );

    // Sign out Cubit
    di.registerLazySingleton(() => SignOutCubit(di<SignOutUseCase>()));
    //
  }

  ////

  ///
  @override
  Future<void> dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}
