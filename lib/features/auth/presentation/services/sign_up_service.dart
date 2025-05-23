import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either_for_data/either_x/either_getters_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_logger_x.dart';
import '../../domain/use_cases/sign_up.dart';
import '../../../../core/utils/typedef.dart';

/// 🧩 [SignUpService] — Handles full sign-up flow with logging
/// ✅ Wraps [SignUpUseCase] to encapsulate clean business logic
//----------------------------------------------------------------

final class SignUpService {
  final SignUpUseCase _signUp;
  const SignUpService(this._signUp);

  /// 🚀 Executes sign-up and logs any failure
  ResultFuture<void> execute({
    required String name,
    required String email,
    required String password,
  }) async {
    ///
    final result = await _signUp(name: name, email: email, password: password);

    result.leftOrNull?.log(); // ❌ Log failure if exists

    return result;
  }

  ///
}
