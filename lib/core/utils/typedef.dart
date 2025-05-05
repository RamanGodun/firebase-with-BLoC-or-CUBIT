library;

import 'package:flutter/material.dart';

import '../shared_modules/errors_handling/either/either.dart';
import '../shared_modules/errors_handling/either/unit.dart';
import '../shared_modules/errors_handling/failure.dart';
import '../shared_modules/errors_handling/handlers/result_handler.dart';

/// Typedefs to match `dartz`-like style
typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
typedef ResultVoid = ResultFuture<Unit>;
typedef Result<T> = ResultHandler<T>;
typedef SubmitCallback = void Function(BuildContext context);
typedef ExceptionHandler = Failure Function(dynamic error);
