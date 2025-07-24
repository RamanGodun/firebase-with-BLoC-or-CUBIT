part of 'sign_out_cubit.dart';

final class SignOutState extends Equatable {
  ///-------------------------------------
  //
  final SignOutStatus status;
  const SignOutState({this.status = SignOutStatus.initial});

  ///
  SignOutState copyWith({SignOutStatus? status}) {
    return SignOutState(status: status ?? this.status);
  }

  ///
  @override
  List<Object?> get props => [status];

  //
}

////

////

/// 🧾 [SignOutState] — Represents the state of sign-out process
enum SignOutStatus { initial, loading, success, failure }
