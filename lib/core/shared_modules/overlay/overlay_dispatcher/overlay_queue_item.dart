import 'package:flutter/material.dart';

import '../presentation/overlay_entries/_overlay_entries.dart';

final class OverlayQueueItem {
  final BuildContext context;
  final OverlayUIEntry request;
  const OverlayQueueItem({required this.context, required this.request});
}
