
import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/x_on_get_it.dart';

import '../../../features/change_or_reset_password/data/password_actions_repo_impl.dart';
import '../../../features/change_or_reset_password/data/remote_database_contract.dart';
import '../../../features/change_or_reset_password/data/remote_database_impl.dart';
import '../../../features/change_or_reset_password/domain/password_actions_use_case.dart';
import '../../../features/change_or_reset_password/domain/repo_contract.dart';
import '../core/di_module_interface.dart';
import '../di_container_initializaion.dart';

/// 🔐 [PasswordModule] — Registers dependencies for password-related features
/// ✅ Includes remote DB, repository, and use cases for reset/change password flows
///
final class PasswordModule implements DIModule {
  ///----------------------------------------
  //
  @override
  String get name => 'PasswordModule';

  ///
  @override
  List<Type> get dependencies => const [];

  ///
  @override
  Future<void> register() async {
    //
    // 📡 Remote Database
    di.registerLazySingletonIfAbsent<IPasswordRemoteDatabase>(
      () => PasswordRemoteDatabaseImpl(),
    );

    // 📦 Repository
    di.registerFactoryIfAbsent<IPasswordRepo>(
      () => PasswordRepoImpl(di()),
    );

    // 🧠 Use Cases
    di.registerFactoryIfAbsent(
      () => PasswordRelatedUseCases(di()),
    );
  }

  /// 🧼 Clean-up (not used yet, placeholder)
  @override
  Future<void> dispose() async {
    // No disposable resources for PasswordModule yet
  }

  //
}