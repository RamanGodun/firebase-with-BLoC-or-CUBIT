import 'package:flutter/material.dart';
import '../shared_modules/errors_handling/either/either.dart';
import '../shared_modules/errors_handling/either/unit.dart';
import '../shared_modules/errors_handling/failure.dart';
import '../shared_modules/errors_handling/handlers/result_handler.dart';

/// 🧩 [ResultFuture] — Represents async result with [Either<Failure, T>]
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// 🧩 [ResultFuture] — Represents async result with `Either<Failure, T>`
typedef DataMap = Map<String, dynamic>;

/// ✅ [ResultVoid] — Represents async void result (unit)
typedef ResultVoid = ResultFuture<Unit>;

/// 🧰 [Result<T>] — Generic result handler wrapper
typedef Result<T> = ResultHandler<T>;

/// 📤 [SubmitCallback] — Button or form submission callback
typedef SubmitCallback = void Function(BuildContext context);

/// 🛑 [ExceptionHandler] — Maps exception to a typed [Failure]
typedef ExceptionHandler = Failure Function(dynamic error);

/// 🧾 [FieldUiState] — Compact record for field visibility & error display
typedef FieldUiState = ({String? errorText, bool isObscure});
