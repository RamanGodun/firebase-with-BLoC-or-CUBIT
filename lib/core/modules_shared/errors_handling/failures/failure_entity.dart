import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show sealed;
import '../enums/error_plugins.dart';

part 'failure_subclasses/firebase_failures.dart';
part 'failure_subclasses/network_and_api_failures.dart';
part 'failure_subclasses/usecase_and_cache_failures.dart';
part 'failure_subclasses/generic_failure.dart';
part 'failure_subclasses/unknown_failure.dart';

/// 🔥 [Failure] — Domain abstraction for all app-level errors
/// ✅ Used throughout Either: [Either<Failure, T>]
/// ✅ Base class for all typed error cases in the domain layer

@sealed
abstract class Failure extends Equatable {
  ///-------------------------------------

  final String message; //📝 Human-readable error
  final String? translationKey; //🌐 Optional localization key
  final dynamic statusCode; //🔢 Optional HTTP or plugin code
  final String? code; //🔖 Short string identifier

  const Failure._({
    required this.message,
    this.translationKey,
    this.statusCode,
    this.code,
  });

  @override
  List<Object?> get props => [message, translationKey, statusCode, code];

  //
}
