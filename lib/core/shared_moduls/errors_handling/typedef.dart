library;

import 'either/either.dart';
import 'either/unit.dart';
import 'failure.dart';
import 'result_handler.dart';

/// Typedefs to match `dartz`-like style
typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
typedef ResultVoid = ResultFuture<Unit>;
typedef Result<T> = ResultHandler<T>;