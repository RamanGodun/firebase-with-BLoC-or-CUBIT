import 'package:flutter/material.dart';

import 'overlay_types.dart';

final class OverlayQueueItem {
  final BuildContext context;
  final OverlayUIEntry request;
  const OverlayQueueItem({required this.context, required this.request});
}
