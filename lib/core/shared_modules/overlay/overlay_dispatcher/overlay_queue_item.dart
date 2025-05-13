import 'package:flutter/material.dart';

import '../core/overlay_entries.dart';

final class OverlayQueueItem {
  final BuildContext context;
  final OverlayUIEntry request;
  const OverlayQueueItem({required this.context, required this.request});
}
