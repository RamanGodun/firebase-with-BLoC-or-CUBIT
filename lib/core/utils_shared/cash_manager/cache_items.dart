part of 'cache_manager.dart';

/// 📦 [_CacheEntry] — Cache value + timestamp wrapper (internal use only)
//
final class _CacheEntry<T> {
  ///--------------------
  //
  /// Cached value
  final T value;
  //  When value was saved
  final DateTime timestamp;
  //
  const _CacheEntry(this.value, this.timestamp);
  //
}

////
////

/// 📊 [CacheStats] — Cache state for monitoring/debugging
//
final class CacheStats {
  ///----------------
  //
  final int totalItems;
  final int inFlightRequests;
  final Duration ttl;

  const CacheStats({
    required this.totalItems,
    required this.inFlightRequests,
    required this.ttl,
  });

  ///
  @override
  String toString() =>
      'CacheStats(items: $totalItems, inFlight: $inFlightRequests, ttl: $ttl)';

  //
}
