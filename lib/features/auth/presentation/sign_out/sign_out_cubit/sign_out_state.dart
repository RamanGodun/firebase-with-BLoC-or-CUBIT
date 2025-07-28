part of 'sign_out_cubit.dart';

/// 🧾 [SignOutState] — Represents the state of sign-out process
enum SignOutStatus { initial, loading, success, failure }

////

////

final class SignOutState extends Equatable {
  ///-----------------------------------
  //
  final SignOutStatus status;
  final Consumable<Failure>? failure;

  const SignOutState({this.status = SignOutStatus.initial, this.failure});

  ///
  SignOutState copyWith({
    SignOutStatus? status,
    Consumable<Failure>? failure,
  }) => SignOutState(status: status ?? this.status, failure: failure);

  ///
  @override
  List<Object?> get props => [status, failure];

  //
}
