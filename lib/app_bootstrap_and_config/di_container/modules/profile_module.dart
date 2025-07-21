import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference;
import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/modules/auth_module.dart';

import '../../../features/profile/data/_profile_repo_impl.dart';
import '../../../features/profile/data/data_source_contract.dart';
import '../../../features/profile/data/data_source_imp.dart';
import '../../../features/profile/domain/fetch_profile_use_case.dart';
import '../../../features/profile/domain/i_repo.dart';
import '../core/di_module_interface.dart';
import '../di_container.dart';
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
    di.registerLazySingleton<IProfileRemoteDatabase>(
      () => ProfileRemoteDataSourceImpl(
        di<CollectionReference<Map<String, dynamic>>>(),
      ),
    );

    // Repositories
    di.registerLazySingleton<IProfileRepo>(() => ProfileRepoImpl(di()));

    // Use Cases
    di.registerLazySingleton(() => FetchProfileUseCase(di()));

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
