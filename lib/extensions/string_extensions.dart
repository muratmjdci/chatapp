
extension StringNullableExtensions on String? {
  bool parseBool() => this?.toLowerCase() == 'true';

  bool get isValidUrl {
    try {
      return Uri.parse(this!).host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}