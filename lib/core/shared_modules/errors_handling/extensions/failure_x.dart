import '../failure.dart';

extension FailureLogger on Failure {
  ///
  void log() => logFailureToCrashlytics(this);
  String get uiMessage => message.isNotEmpty ? message : 'Something went wrong';

  ///
}

extension FailureUI on Failure {
  ///
  String get formattedMessage {
    if (this is GenericFailure) {
      final error = (this as GenericFailure).error;
      return '${error.message}\n\nCode: ${error.code}\nSource: ${error.plugin.name}';
    }
    if (this is ApiFailure) {
      return '$message\n\nStatus Code: $statusCode';
    }
    return message;
  }
}
