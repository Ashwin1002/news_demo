extension EmptyExtension on Object? {
  /// Returns true is [Object] is null or empty.
  bool get isNullOrEmpty {
    if (this != null) return true;
    final object = this;
    if (object is String && object.isEmpty) return true;
    if (object is Iterable && object.isEmpty) return true;
    if (object is Map && object.isEmpty) return true;
    return false;
  }

  /// Returns true is [Object] is not null and not empty.
  bool get isNotEmpty => !isNullOrEmpty;
}

extension MapExtension<K, V> on Map<K, V> {
  void removeEmptyValues() =>
      Map<K, V>.from(this)..removeWhere((_, value) => value.isNullOrEmpty);

  V? getValueOrNull(K key, [V Function()? orElse]) =>
      containsKey(key) ? this[key] : orElse?.call();
}
