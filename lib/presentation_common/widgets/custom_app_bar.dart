import 'package:flutter/material.dart';
import 'text_widget.dart';

/// 🎨 CustomAppBar with flexible icon/widgets in actions
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<IconData>? actionIcons;
  final List<VoidCallback>? actionCallbacks;
  final bool isCenteredTitle;
  final bool isNeedPaddingAfterActionIcon;
  final List<Widget>? actionWidgets;

  /// ✅ All parameters in single `const` constructor
  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actionIcons,
    this.actionCallbacks,
    this.actionWidgets,
    this.isCenteredTitle = false,
    this.isNeedPaddingAfterActionIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    // 🔐 Runtime validation
    if (actionWidgets == null &&
        (actionIcons?.length != actionCallbacks?.length)) {
      throw FlutterError(
        '❗️actionIcons and actionCallbacks must be the same length when using icon-based actions.',
      );
    }


    return AppBar(
      centerTitle: isCenteredTitle,
      title: TextWidget(
        title,
        TextType.titleSmall,
        alignment: isCenteredTitle ? TextAlign.center : TextAlign.start,
      ),
      leading:
          leadingIcon != null
              ? IconButton(icon: Icon(leadingIcon), onPressed: onLeadingPressed)
              : null,
      actions:
          actionWidgets ??
          [
            if (actionIcons != null && actionCallbacks != null)
              for (int i = 0; i < actionIcons!.length; i++)
                IconButton(
                  icon: Icon(actionIcons![i]),
                  onPressed: actionCallbacks![i],
                ),
            if ((actionIcons?.isNotEmpty ?? false) &&
                isNeedPaddingAfterActionIcon)
              const SizedBox(width: 18),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
