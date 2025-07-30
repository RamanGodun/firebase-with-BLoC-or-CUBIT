import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/x_on_get_it.dart';
import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/modules/auth_module.dart';
import '../../../features/profile/data/implementation_of_profile_fetch_repo.dart';
import '../../../features/profile/data/remote_database_contract.dart';
import '../../../features/profile/data/remote_database_impl.dart';
import '../../../features/profile/domain/fetch_profile_use_case.dart';
import '../../../features/profile/domain/repo_contract.dart';
import '../../../features/profile/presentation/cubit/profile_page_cubit.dart';
import '../core/di_module_interface.dart';
import '../di_container_init.dart';
import 'firebase_module.dart';

final class ProfileModule implements DIModule {
  ///---------------------------------------
  //
  @override
  String get name => 'ProfileModule';

  ///
  @override
  List<Type> get dependencies => [FirebaseModule, AuthModule];
  //

  ///
  @override
  Future<void> register() async {
    //
    // Data Sources
    di.registerLazySingletonIfAbsent<IProfileRemoteDatabase>(
      () => ProfileRemoteDatabaseImpl(
        di<CollectionReference<Map<String, dynamic>>>(),
        di<FirebaseAuth>(),
      ),
    );

    // Repositories
    di.registerLazySingletonIfAbsent<IProfileRepo>(() => ProfileRepoImpl(di()));

    // Use Cases
    di.registerLazySingletonIfAbsent(() => FetchProfileUseCase(di()));

    // Global Profile cubit
    di.registerLazySingletonIfAbsent<ProfileCubit>(
      () => ProfileCubit(di<FetchProfileUseCase>()),
    );

    //
  }

  ///
  @override
  Future<void> dispose() async {
    // No resources to dispose for this DI module yet.
  }

  //
}
