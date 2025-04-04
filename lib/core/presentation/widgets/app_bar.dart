import 'package:flutter/material.dart';
import '../../../widgets/text_widget.dart';

/// **Custom App Bar**
/// - A reusable and consistent AppBar widget.
/// - Supports optional actions and customization.
/// - Uses `TextWidget` for styling.

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(title, TextType.titleMedium),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
