part of 'reset_password_cubit.dart';

/// 📄 [ResetPasswordState] — Stores reset form values and validation status
/// ✅ Used by [ResetPasswordCubit] to manage reactive UI state
//
final class ResetPasswordState extends Equatable {
  ///------------------------------------
  //
  final EmailInputValidation email;
  final FormzSubmissionStatus status;
  final bool isValid;
  final Consumable<Failure>? failure;

  const ResetPasswordState({
    this.email = const EmailInputValidation.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.failure,
  });

  /// 🔁 Returns new state with updated fields
  ResetPasswordState _copyWith({
    final EmailInputValidation? email,
    final FormzSubmissionStatus? status,
    final bool? isValid,
    final Consumable<Failure>? failure,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [email, status, isValid, failure];

  //
}

////
////

/// 🧩 [ResetPasswordStateValidationX] — Adds validation/update logic to [ResetPasswordState]
/// ✅ Ensures clean field validation and consistent `isValid` flag management
//
extension ResetPasswordStateValidationX on ResetPasswordState {
  //
  /// ✅ Validates [email] using [Formz]
  bool validateWith({final EmailInputValidation? email}) {
    return Formz.validate([email ?? this.email]);
  }

  /// 🔁 Returns updated state with revalidated `isValid` flag
  ResetPasswordState updateWith({
    final EmailInputValidation? email,
    final FormzSubmissionStatus? status,
    final Consumable<Failure>? failure,
  }) {
    final updated = _copyWith(email: email, status: status, failure: failure);
    return updated._copyWith(isValid: updated.validateWith());
  }

  //
}
