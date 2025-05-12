import 'package:flutter/material.dart';

import 'overlay_dispatcher_contract.dart';
import '../overlay_types.dart';

class MockOverlayDispatcher implements IOverlayDispatcher {
  final List<OverlayUIEntry> calls = [];
  @override
  void enqueueRequest(BuildContext context, OverlayUIEntry request) {
    calls.add(request);
  }

  @override
  void clearAll() => calls.clear();

  @override
  void clearByContext(BuildContext context) {}

  @override
  Future<void> dismissCurrent({bool clearQueue = false}) async {}
}
