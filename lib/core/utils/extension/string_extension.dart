extension StringExtension on String {
  // hardcoded strings annotation
  String get hardcoded => this;


  bool get isValidUrl => Uri.tryParse(this)?.isAbsolute ?? false;
}
