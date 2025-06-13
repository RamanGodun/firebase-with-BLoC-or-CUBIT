import 'package:flutter/material.dart';
import '../shared_modules/errors_handling/either/either.dart';
import '../shared_modules/errors_handling/failures/failure_entity.dart';
import '../shared_modules/errors_handling/utils/dsl_result_handler.dart';
import '../shared_modules/overlays/overlays_presentation/overlay_presets/overlay_presets.dart';

/// 🧩 [ResultFuture] — Represents async result with [Either<Failure, T>]
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// 🧩 [ResultFuture] — Represents async result with `Either<Failure, T>`
typedef DataMap = Map<String, dynamic>;

/// 🧰 [Result<T>] — Generic result handler wrapper
typedef Result<T> = ResultHandler<T>;

/// 📤 [SubmitCallback] — Button or form submission callback
typedef SubmitCallback = void Function(BuildContext context);

/// 🛑 [ExceptionHandler] — Maps exception to a typed [Failure]
typedef ExceptionHandler = Failure Function(dynamic error);

/// 🧾 [FieldUiState] — Compact record for field visibility & error display
typedef FieldUiState = ({String? errorText, bool isObscure});

/// 📦 Wraps child with EasyLocalization widget
typedef LocalizationWrapper = Widget Function(Widget child);

///
typedef OverlayBannerFactory = Widget Function(OverlayUIPresets, String);
