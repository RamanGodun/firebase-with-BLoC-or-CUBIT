import 'package:flutter/material.dart';
import '../base_modules/errors_handling/either/either.dart';
import '../base_modules/errors_handling/failures/failure_entity.dart';

/// 🧩 [ResultFuture] — Represents async result with [Either<Failure, T>]
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// 🧩 [FailureOr<T>] — Sync `Either<Failure, T>`
typedef FailureOr<T> = Either<Failure, T>;

/// 🔁 [VoidEither] — Sync `Either<Failure, void>`
typedef VoidEither = Either<Failure, void>;

/// 📦 [DataMap] — For JSON-style dynamic map (used for DTO, serialization, Firestore docs...)
typedef DataMap = Map<String, dynamic>;

/// 🧾 [FieldUiState] — Compact record for field visibility & error display
typedef FieldUiState = ({String? errorText, bool isObscure});

/// 📤 [SubmitCallback] — Button or form submission callback
typedef SubmitCallback = void Function(BuildContext context);

/// 📡 [ListenFailureCallback] — optional handler when failure is caught
typedef ListenFailureCallback = void Function(Failure failure);

///
typedef UseCase<T, P> = ResultFuture<T> Function(P params);
typedef UseCaseNoParams<T> = ResultFuture<T> Function();
