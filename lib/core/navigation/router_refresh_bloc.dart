import 'dart:async';
import 'package:flutter/foundation.dart';

class GoRouterRefreshBloc extends ChangeNotifier {
  GoRouterRefreshBloc(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
