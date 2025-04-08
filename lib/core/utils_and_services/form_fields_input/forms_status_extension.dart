// 📄 lib/core/utils_and_services/formfileld_inputs/formz_status_extensions.dart
import 'package:formz/formz.dart';

extension FormzStatusX on FormzSubmissionStatus {
  bool get isInitial => this == FormzSubmissionStatus.initial;
  bool get isInProgress => this == FormzSubmissionStatus.inProgress;
  bool get isSuccess => this == FormzSubmissionStatus.success;
  bool get isFailure => this == FormzSubmissionStatus.failure;

  bool get isSubmissionInProgress => isInProgress;
  bool get isSubmissionFailure => isFailure;
  bool get isSubmissionSuccess => isSuccess;

  bool get isValidated => this == FormzSubmissionStatus.initial;
}
