import '../domain/use_cases/sign_up.dart';
import '../../../core/general_utils/typedef.dart';

/// ⚠️ Currently unused: retained for potential future orchestration

/// 🧩 [SignUpService] — Handles full sign-up flow with logging
/// ✅ Wraps [SignUpUseCase] to encapsulate clean business logic
/// !  [SignUpService] will be needed if sign-up logic grows to include multiple use cases or orchestration

final class SignUpService {
  //----------------------

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

    /*

final result = await _signUp(...);
if (result.isRight) {
  await _sendAnalyticsEvent();
  await _sendWelcomeEmail();
}
    result.leftOrNull?.log(); // ❌ Log failure if exists

 */

    return result;
  }

  //
}
