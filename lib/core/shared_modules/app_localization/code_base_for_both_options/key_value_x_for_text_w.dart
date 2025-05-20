import 'package:flutter/material.dart';
import 'text_widget.dart';

/// 🔑 [KeyValueTextWidget] — Combines a localized key with a dynamic value in a single line,
/// with baseline alignment for visual consistency across label-value pairs.
///----------------------------------------------------------------

final class KeyValueTextWidget extends StatelessWidget {
  final String labelKey;
  final String value;

  // 🅰️ Style for localized label
  final TextType labelTextType;

  // 🅱️ Optional style override for value
  final TextType? valueTextType;

  const KeyValueTextWidget({
    super.key,
    required this.labelKey,
    required this.value,
    required this.labelTextType,
    this.valueTextType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,

        children: [
          /// 🏷️ Localized label
          TextWidget(
            labelKey,
            labelTextType,
            alignment: TextAlign.start,
            fontWeight: FontWeight.w300,
          ),

          const SizedBox(width: 8),

          /// 🧾 Dynamic value
          Expanded(
            child: TextWidget(
              value,
              valueTextType ?? TextType.titleSmall,
              alignment: TextAlign.start,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
