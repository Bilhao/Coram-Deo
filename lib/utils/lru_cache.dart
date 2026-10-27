import 'dart:collection';

/// Implementação leve de Cache LRU (Least Recently Used) em memória
/// baseada em [LinkedHashMap] para consultas instantâneas (0ms).
class LruCache<K, V> {
  final int maxEntries;
  final LinkedHashMap<K, V> _map = LinkedHashMap<K, V>();

  LruCache({this.maxEntries = 24});

  V? get(K key) {
    final value = _map.remove(key);
    if (value != null) {
      _map[key] = value;
    }
    return value;
  }

  void put(K key, V value) {
    _map.remove(key);
    _map[key] = value;
    if (_map.length > maxEntries) {
      _map.remove(_map.keys.first);
    }
  }

  bool containsKey(K key) => _map.containsKey(key);

  void clear() => _map.clear();
}
