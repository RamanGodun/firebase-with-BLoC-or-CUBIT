import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:flutter_bloc/flutter_bloc.dart';

/// 🔍 [AppBlocObserver] — Global observer for BLoC/Cubit lifecycle events.
/// Logs key transitions to help debug and track state changes, includes:
///           - 🟢 onCreate
///           - 📨 onEvent (only for BLoC)
///           - 🔄 onChange
///           - ➡️ onTransition (only for BLoC)
///           - ❌ onError
///           - 🔴 onClose
///-----------------------------------------------------------------------------

final class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  /// 🕒 Returns the current time for consistent log entries.
  String _timestamp() => DateTime.now().toIso8601String();

  /// 🟢 Called when a BLoC or Cubit is created.
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('🟢 [${_timestamp()}] Created → ${bloc.runtimeType}');
  }

  /// 📨 Called when an event is added (only in BLoC).
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('📨 [${_timestamp()}] Event → ${bloc.runtimeType}: $event');
  }

  /// 🔄 Called on Cubit/BLoC state changes.
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('🔄 [${_timestamp()}] State → ${bloc.runtimeType}: $change');
  }

  /// ➡️ Called on BLoC transition (event → state).
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(
      '➡️ [${_timestamp()}] Transition → ${bloc.runtimeType}: $transition',
    );
  }

  /// ❌ Called when an error occurs inside BLoC/Cubit.
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    final type = error.runtimeType;
    final origin = bloc.runtimeType.toString();
    if (kDebugMode) {
      debugPrint('❌ [${_timestamp()}] [BLoC][$origin][$type] $error');
      debugPrint(stackTrace.toString());
    }
    // 🧩 You may also send to CrashlyticsLogger if needed:
    // CrashlyticsLogger.blocError(error: error, stackTrace: stackTrace, origin: origin);
    super.onError(bloc, error, stackTrace);
  }

  /// 🔴 Called when BLoC/Cubit is closed/disposed.
  @override
  void onClose(BlocBase bloc) {
    debugPrint('🔴 [${_timestamp()}] Closed → ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
