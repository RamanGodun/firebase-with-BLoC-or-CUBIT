import 'package:flutter/material.dart';

import 'requests.dart';

final class OverlayQueueItem {
  final BuildContext context;
  final OverlayRequest request;
  const OverlayQueueItem({required this.context, required this.request});
}
