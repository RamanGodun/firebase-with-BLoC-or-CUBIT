part of '_either_x_imports.dart';

/// 🧩 [ResultX<T>] — sync sugar for `Either<Failure, T>`
/// ✅ Enables UI handling, fallback values, and null-safe failure/message access.
//-------------------------------------------------------------------------

extension ResultX<T> on Either<Failure, T> {
  /// 🔁 Match (fold) sync logic
  void match({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
  }) => fold(onFailure, onSuccess);

  /// 🎯 Returns value or fallback
  T getOrElse(T fallback) => fold((_) => fallback, (r) => r);

  /// 🧼 Returns failure message or null
  String? get failureMessage => fold((f) => f.message, (_) => null);

  /// 💬 Shows SnackBar if Failure
  void handleSnackBar(BuildContext context) {
    if (!context.mounted) return;
    fold(
      (f) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(f.uiMessage))),
      (_) {},
    );
  }

  /// 💬 Shows Dialog if Failure
  void handleDialog(
    BuildContext context, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  }) {
    if (!context.mounted) return;
    fold(
      (f) => di<IShowDialog>().alertOnError(
        context,
        f,
        title: title,
        buttonText: buttonText,
        onClose: onClose,
      ),
      (_) {},
    );
  }

  ///
}
