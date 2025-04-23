/// regex to find html pattern
RegExp _htmlTagPattern = RegExp(
  r'<([a-z][\w-]*)\b[^>]*>(.*?)<\/\1>',
  caseSensitive: false,
);

RegExp _timePattern = RegExp(r'\b([01]?\d|2[0-3]):[0-5]\d:[0-5]\d\b');

extension StringExtension on String {
  // hardcoded strings annotation
  String get hardcoded => this;

  bool get isValidUrl => Uri.tryParse(this)?.isAbsolute ?? false;

  bool get isHTML => _htmlTagPattern.hasMatch(this);

  bool get isSvg => endsWith('svg');

  String? extractTimeFormat() {
    final match = _timePattern.firstMatch(this);
    return match?.group(0); // Returns the matched time or null if not found
  }

  String toUrl() {
    if (trim().contains('http://') || trim().contains('https://')) {
      return trim();
    } else {
      return 'https://${trim()}';
    }
  }

  String capitalize() =>
      trim().isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  String getFirstLetters({bool isStartEnd = false}) {
    try {
      // Remove leading and trailing whitespace
      final trimmedString = trim();

      // Check if the string is empty or only contains whitespace
      if (trimmedString.isEmpty) {
        return '';
      }

      // Split the string by whitespace
      final words = trimmedString.split(RegExp(r'\s+'));

      // Filter out empty strings after splitting
      final nonEmptyWords = words.where((word) => word.isNotEmpty);

      // Extract the first letter from each word
      final firstLetters = nonEmptyWords
          .map((word) {
            // Handle surrogate pairs for characters outside the BMP
            return word.runes.firstWhere((rune) => rune != 0, orElse: () => 0);
          })
          .where((rune) => rune != 0)
          .map((rune) => String.fromCharCode(rune));

      if (firstLetters.isNotEmpty && isStartEnd && firstLetters.length > 1) {
        return '${firstLetters.first}${firstLetters.last}';
      }

      // Join the first letters together
      return firstLetters.join();
    } catch (_) {
      return '';
    }
  }
}
