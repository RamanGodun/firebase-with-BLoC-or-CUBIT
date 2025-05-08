import 'package:flutter/material.dart';

import 'overlay_requests.dart';

final class OverlayQueueItem {
  final BuildContext context;
  final OverlayRequest request;
  const OverlayQueueItem({required this.context, required this.request});
}
