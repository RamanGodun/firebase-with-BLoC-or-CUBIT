import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either/either.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/extensions/failure_x.dart';
import '../domain/use_cases/sign_up.dart';
import '../../../core/utils/typedef.dart';

/// 🧩 [SignUpService] — Handles full sign-up flow with validation & logging
/// 🧼 Encapsulates logic previously inside [SignUpCubit]
class SignUpService {
  final SignUpUseCase _signUp;

  SignUpService(this._signUp);

  /// 🚀 Executes sign-up, validates and logs result
  ResultFuture<void> execute({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await _signUp(name: name, email: email, password: password);

    result.leftOrNull?.log();

    return result;
  }
}
