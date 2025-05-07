import 'package:flutter/material.dart';

abstract interface class INotificationService {
  ///
  void showError(BuildContext context, String message);
  void showSuccess(BuildContext context, String message);
  void showInfo(BuildContext context, String message);
  void showLoading(BuildContext context);
  void dismiss();

  ///
}
