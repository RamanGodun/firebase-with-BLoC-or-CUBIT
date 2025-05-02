import 'dart:async';
import 'package:flutter/material.dart';
import '../either/either.dart';
import '../failure.dart';
import '../result_handler.dart';
import 'either_x.dart';

/// 🧩 [ResultFutureX] — async sugar for `Future<Either<Failure, T>>`
//----------------------------------------------------------------//
extension ResultFutureX<T> on Future<Either<Failure, T>> {
  Future<void> matchAsync({
    required Future<void> Function(Failure) onFailure,
    required Future<void> Function(T) onSuccess,
  }) async => (await this).fold(onFailure, onSuccess);

  Future<void> matchSync({
    required void Function(Failure) onFailure,
    required void Function(T) onSuccess,
  }) async => (await this).fold(onFailure, onSuccess);

  Future<void> handleSnackBar(BuildContext context) async {
    final result = await this;
    if (!context.mounted) return;
    result.handleSnackBar(context);
  }

  Future<void> handleDialog(
    BuildContext context, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  }) async {
    final result = await this;
    if (!context.mounted) return;
    result.handleDialog(
      context,
      title: title,
      buttonText: buttonText,
      onClose: onClose,
    );
  }

  Future<T> getOrElse(T fallback) async =>
      (await this).fold((_) => fallback, (r) => r);

  Future<String?> failureMessageOrNull() async =>
      (await this).fold((f) => f.message, (_) => null);
}

/// 🧩 [ResultFutureChainX] — top-tier chainable API
//----------------------------------------------------------------//
extension ResultFutureChainX<T> on Future<Either<Failure, T>> {
  Future<ResultHandler<T>> onFailure(
    FutureOr<void> Function(Failure f) handler,
  ) async {
    final result = await this;
    if (result.isLeft) await handler(result.leftOrNull!);
    return ResultHandler(result);
  }
}


