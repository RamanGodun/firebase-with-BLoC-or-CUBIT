import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/x_on_get_it.dart';
import '../../firebase_config/user_auth_cubit/auth_cubit.dart';
import '../../../features/email_verification/data/email_verification_repo_impl.dart';
import '../../../features/email_verification/data/remote_database_contract.dart';
import '../../../features/email_verification/data/remote_database_impl.dart';
import '../../../features/email_verification/domain/email_verification_use_case.dart';
import '../../../features/email_verification/domain/repo_contract.dart';
import '../../../features/email_verification/presentation/email_verification_cubit/email_verification_cubit.dart';
import '../core/di_module_interface.dart';
import '../di_container_init.dart';
import 'auth_module.dart';
import 'firebase_module.dart';

final class EmailVerificationModule implements DIModule {
  ///-------------------------------------------------
  //
  @override
  String get name => 'EmailVerificationModule';

  ///
  @override
  List<Type> get dependencies => [FirebaseModule, AuthModule];

  ///
  @override
  Future<void> register() async {
    //
    /// Data sources
    di.registerFactoryIfAbsent<IUserValidationRemoteDataSource>(
      () => IUserValidationRemoteDataSourceImpl(),
    );

    /// Repositories
    di.registerFactoryIfAbsent<IUserValidationRepo>(
      () => IUserValidationRepoImpl(di()),
    );

    /// Usecases
    di.registerFactoryIfAbsent(() => EmailVerificationUseCase(di()));

    /// Email Verification Cubit
    di.registerFactoryIfAbsent<EmailVerificationCubit>(
      () => EmailVerificationCubit(
        di<EmailVerificationUseCase>(),
        di<AuthCubit>(),
      ),
    );

    //
  }

  ///
  @override
  Future<void> dispose() async {
    await di.safeDispose<EmailVerificationCubit>();
  }

  //
}
