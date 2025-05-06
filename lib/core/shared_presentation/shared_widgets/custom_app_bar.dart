import 'package:flutter/material.dart';
import 'text_widget.dart';

/// 🎨 CustomAppBar with flexible icon/widgets in actions
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  ///
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<IconData>? actionIcons;
  final List<VoidCallback>? actionCallbacks;
  final List<String>? tooltips;
  final bool isCenteredTitle;
  final bool isNeedPaddingAfterActionIcon;
  final List<Widget>? actionWidgets;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actionIcons,
    this.actionCallbacks,
    this.tooltips,
    this.actionWidgets,
    this.isCenteredTitle = false,
    this.isNeedPaddingAfterActionIcon = false,
    this.backgroundColor,
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
      backgroundColor:
          backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      title: TextWidget(
        title,
        TextType.titleSmall,
        alignment: isCenteredTitle ? TextAlign.center : TextAlign.start,
      ),
      leading:
          leadingIcon != null
              ? IconButton(icon: Icon(leadingIcon), onPressed: onLeadingPressed)
              : null,
      actions: _buildActions(),
    );
  }

  /// 🔧 Generates the `actions` section of the AppBar
  List<Widget> _buildActions() {
    if (actionWidgets != null) return actionWidgets!;

    if (actionIcons != null && actionCallbacks != null) {
      return [
        for (int i = 0; i < actionIcons!.length; i++)
          IconButton(
            icon: Icon(actionIcons![i]),
            onPressed: actionCallbacks![i],
            tooltip:
                tooltips != null && i < tooltips!.length ? tooltips![i] : null,
          ),
        if (isNeedPaddingAfterActionIcon) const SizedBox(width: 18),
      ];
    }

    return [];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  ///
}
