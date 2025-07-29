import '../../../app_bootstrap_and_config/app_configs/constants/timing_config.dart';

part 'cache_items.dart';

/// 🧩 [CacheManager] — Universal, type-safe in-memory cache for repositories
///     ✅ Composition over inheritance
///     ✅ Configurable TTL (time-to-live)
///     ✅ Type-safe (generic for value & key)
///     ✅ Prevents parallel duplicate requests (in-flight cache)
///     ✅ Explicit dependency, perfect for DI & testing
//
final class CacheManager<T, K> {
  ///────────────────────────
  //
  /// Storage for cached values
  final Map<K, _CacheEntry<T>> _storage = {};

  /// Tracks in-progress async operations to avoid duplication
  final Map<K, Future<T>> _inFlightRequests = {};

  /// Cache expiration duration
  final Duration _ttl;

  /// Creates cache manager with optional TTL (default: 5 min)
  CacheManager({Duration? ttl}) : _ttl = ttl ?? AppDurations.min10;
  //

  /// 🚀 Runs async operation with full caching & in-flight protection
  /// - Returns cached value if still valid
  /// - If already fetching: awaits same future
  /// - If forceRefresh: skips cache, forces update
  ///
  Future<T> execute(
    K key,
    Future<T> Function() operation, {
    bool forceRefresh = false,
  }) async {
    if (forceRefresh) {
      _storage.remove(key);
      _inFlightRequests.remove(key);
    }

    final cached = _getCachedValue(key);
    if (cached != null) return cached;

    final inFlight = _inFlightRequests[key];
    if (inFlight != null) return await inFlight;

    final future = operation();
    _inFlightRequests[key] = future;

    try {
      final result = await future;
      _storage[key] = _CacheEntry(result, DateTime.now());
      return result;
    } finally {
      _inFlightRequests.remove(key);
    }
  }

  /// 🕓 Returns cached value for [key] if not expired, else null
  T? _getCachedValue(K key) {
    final entry = _storage[key];
    if (entry == null) return null;

    final isExpired = DateTime.now().difference(entry.timestamp) > _ttl;
    if (isExpired) {
      _storage.remove(key);
      return null;
    }
    return entry.value;
  }

  /// 🛠️ Puts value to cache for [key] (manual)
  void put(K key, T value) =>
      _storage[key] = _CacheEntry(value, DateTime.now());

  /// 🔎 Gets cached value for [key] (manual)
  T? get(K key) => _getCachedValue(key);

  /// ❌ Removes [key] from cache and in-flight map
  void remove(K key) {
    _storage.remove(key);
    _inFlightRequests.remove(key);
  }

  /// ♻️ Clears all cache and in-flight requests
  void clear() {
    _storage.clear();
    _inFlightRequests.clear();
  }

  /// 📊 Debug info: count of items, in-flight, TTL
  CacheStats get stats => CacheStats(
    totalItems: _storage.length,
    inFlightRequests: _inFlightRequests.length,
    ttl: _ttl,
  );

  //
}
