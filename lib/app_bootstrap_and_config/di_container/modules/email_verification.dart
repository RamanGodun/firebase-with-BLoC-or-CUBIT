import 'package:firebase_with_bloc_or_cubit/app_bootstrap_and_config/di_container/get_it_x.dart';
import '../../../features/email_verification/data/email_verification_repo_impl.dart';
import '../../../features/email_verification/data/remote_database_contract.dart';
import '../../../features/email_verification/data/remote_database_impl.dart';
import '../../../features/email_verification/domain/email_verification_use_case.dart';
import '../../../features/email_verification/domain/repo_contract.dart';
import '../../../features/email_verification/presentation/email_verification_cubit/email_verification_cubit.dart';
import '../core/di_module_interface.dart';
import '../di_container.dart';
import 'auth_module.dart';
import 'firebase_module.dart';

final class EmailVerificationModule implements DIModule {
  ///-------------------------------------------------
  //
  @override
  String get name => 'EmailVerificationModule';

  @override
  List<Type> get dependencies => [FirebaseModule, AuthModule];

  @override
  Future<void> register() async {
    di.registerLazySingletonIfAbsent<IUserValidationRemoteDataSource>(
      () => IUserValidationRemoteDataSourceImpl(),
    );
    di.registerLazySingletonIfAbsent<IUserValidationRepo>(
      () => IUserValidationRepoImpl(di()),
    );
    di.registerLazySingletonIfAbsent(() => EmailVerificationUseCase(di()));
    di.registerLazySingletonIfAbsent(() => EmailVerificationCubit(di()));
  }

  @override
  Future<void> dispose() async {
    await di.safeDispose<EmailVerificationCubit>();
  }
}
