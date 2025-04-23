extension EmptyExtension on Object? {
  /// Returns true is [Object] is null or empty.
  bool get isNullOrEmpty {
    final object = this;
    if (object is String && object.isEmpty) return true;
    if (object is Iterable && object.isEmpty) return true;
    if (object is Map && object.isEmpty) return true;
    if (this == null) return true;
    return false;
  }

  /// Returns true is [Object] is not null and not empty.
  bool get isNotEmpty => !isNullOrEmpty;
}

extension IterableJoinExtension<T> on Iterable<T> {
  /// Joins the elements into a single string.
  ///
  /// [separator] is used to separate all but the last element.
  /// [end] is an optional string that is inserted between the second-to-last
  /// and the last element. If not provided, [separator] is used for all elements.
  String joinWithSeparator(String separator, {String? end}) {
    final list = toList();

    // Handle empty list
    if (list.isEmpty) return '';

    // For a single element, just return its string representation
    if (list.length == 1) return list.first.toString();

    // If an end separator is provided and there's more than one element
    if (end != null) {
      // Join all elements except the last one using the provided separator.
      final allButLast = list
          .sublist(0, list.length - 1)
          .map((e) => e.toString())
          .join(separator);
      // Return a string with the [end] separator preceding the last element.
      return '$allButLast $end ${list.last}';
    }

    // If no [end] separator is provided, join all elements with the standard separator.
    return list.map((e) => e.toString()).join(separator);
  }
}

extension MapExtension<K, V> on Map<K, V> {
  void removeEmptyValues([bool checkEmptyNum = true]) => removeWhere(
    (_, value) =>
        value.isNullOrEmpty ||
        (!checkEmptyNum ? true : value is num && value < 0),
  );

  V? getValueOrNull(K key, [V Function()? orElse]) =>
      containsKey(key) ? this[key] : orElse?.call();
}
