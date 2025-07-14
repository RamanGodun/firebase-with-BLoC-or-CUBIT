part of 'router_cubit.dart';

class GoRouterRefresher extends ChangeNotifier {
  GoRouterRefresher(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
