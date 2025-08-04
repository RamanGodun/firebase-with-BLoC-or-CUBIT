import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/observers/result_loggers/result_logger_x.dart';
import '../../../../core/utils_shared/type_definitions.dart';
import '../repo_contracts.dart';

/// 📦 [SignInUseCase] — Handles user authentication logic, using [ISignInRepo]
//
final class SignInUseCase {
  ///-------------------
  //
  final ISignInRepo authRepo;
  const SignInUseCase(this.authRepo);
  //
  /// 🔐 Signs in with provided credentials
  ResultFuture<void> call({required String email, required String password}) =>
      authRepo.signIn(email: email, password: password)
        ..log()
        ..logSuccess('SignInUseCase success');
  //
}
