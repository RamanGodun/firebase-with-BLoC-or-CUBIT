part of 'email_verification_cubit.dart';

enum EmailVerificationStatus {
  initial,
  loading,
  verified,
  unverified,
  resent,
  failure,
}

class EmailVerificationState extends Equatable {
  final EmailVerificationStatus status;
  final User? user;
  final Consumable<Failure>? failure;

  const EmailVerificationState({
    this.status = EmailVerificationStatus.initial,
    this.user,
    this.failure,
  });

  EmailVerificationState copyWith({
    EmailVerificationStatus? status,
    User? user,
    Consumable<Failure>? failure,
  }) {
    return EmailVerificationState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, user, failure];
}
