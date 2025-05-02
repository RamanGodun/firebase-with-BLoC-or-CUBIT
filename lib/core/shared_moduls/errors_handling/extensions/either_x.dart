import 'package:flutter/material.dart';
import '../either/either.dart';
import '../failure.dart';
import 'failure_x.dart';

/// 🧩 [ResultX] — sync sugar for `Either<Failure, T>`
//----------------------------------------------------------------//
extension ResultX<T> on Either<Failure, T> {
  void match({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
  }) => fold(onFailure, onSuccess);

  T getOrElse(T fallback) => fold((_) => fallback, (r) => r);

  String? get failureMessage => fold((f) => f.message, (_) => null);

  void handleSnackBar(BuildContext context) {
    if (!context.mounted) return;
    fold(
      (f) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(f.uiMessage))),
      (_) {},
    );
  }

  void handleDialog(
    BuildContext context, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  }) {
    if (!context.mounted) return;
    fold(
      (f) => showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text(title ?? 'Oops...'),
              content: Text(f.uiMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onClose?.call();
                  },
                  child: Text(buttonText ?? 'OK'),
                ),
              ],
            ),
      ),
      (_) {},
    );
  }
}
