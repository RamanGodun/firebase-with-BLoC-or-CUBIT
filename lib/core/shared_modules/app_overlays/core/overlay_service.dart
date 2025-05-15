import 'package:flutter/material.dart';

final class OverlayService {
  const OverlayService._();

  static Future<void> showAddItemDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Add item'),
            content: const TextField(),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  /* save */
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  static void showPlainBanner(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  ///
}
