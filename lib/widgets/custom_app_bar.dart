import 'package:flutter/material.dart';
import 'text_widget.dart';

/// 🎨 **[CustomAppBar]
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<IconData>? actionIcons;
  final List<VoidCallback>? actionCallbacks;
  final bool? isCenteredTitle;
  final bool? isNeedPaddingAfterActionIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actionIcons,
    this.actionCallbacks,
    this.isCenteredTitle,
    this.isNeedPaddingAfterActionIcon,
  });

  @override
  Widget build(BuildContext context) {
    if ((actionIcons?.length ?? 0) != (actionCallbacks?.length ?? 0)) {
      throw ArgumentError(
        'The icons length and  callbacks length must be equal !',
      );
    }

    return AppBar(
      centerTitle: isCenteredTitle ?? false,

      title: TextWidget(
        title,
        TextType.bodyLarge,
        alignment:
            (isCenteredTitle == true) ? TextAlign.center : TextAlign.start,
      ),

      leading:
          leadingIcon != null
              ? IconButton(icon: Icon(leadingIcon), onPressed: onLeadingPressed)
              : null,

      actions: [
        if (actionIcons != null && actionCallbacks != null)
          for (int i = 0; i < actionIcons!.length; i++)
            IconButton(
              icon: Icon(actionIcons![i]),
              onPressed: actionCallbacks![i],
            ),
        if ((actionIcons?.isNotEmpty ?? false) &&
            isNeedPaddingAfterActionIcon == true)
          const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
