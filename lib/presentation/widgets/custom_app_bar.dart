import 'package:flutter/material.dart';
import 'text_widget.dart';

/// 🎨 CustomAppBar with flexible icon/widgets in actions
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<IconData>? actionIcons;
  final List<VoidCallback>? actionCallbacks;
  final bool? isCenteredTitle;
  final bool? isNeedPaddingAfterActionIcon;

  /// 👉 Use this when you want to pass custom widgets instead of icon+callback
  final bool? isUseActionWidget;
  final List<Widget>? actionWidgets;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actionIcons,
    this.actionCallbacks,
    this.isCenteredTitle,
    this.isNeedPaddingAfterActionIcon,
    this.isUseActionWidget,
    this.actionWidgets,
  });

  @override
  Widget build(BuildContext context) {
    if (isUseActionWidget != true &&
        (actionIcons?.length ?? 0) != (actionCallbacks?.length ?? 0)) {
      throw ArgumentError(
        'Icons and callbacks must be the same length if using actionIcons!',
      );
    }

    return AppBar(
      centerTitle: isCenteredTitle ?? false,
      title: TextWidget(
        title,
        TextType.bodyLarge,
        alignment: isCenteredTitle == true ? TextAlign.center : TextAlign.start,
      ),
      leading:
          leadingIcon != null
              ? IconButton(icon: Icon(leadingIcon), onPressed: onLeadingPressed)
              : null,
      actions:
          isUseActionWidget == true
              ? actionWidgets
              : [
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
