DateTime get now => DateTime.now();

extension StringDateExtensions on String {
  DateTime? get date {
    try {
      return DateTime.parse(this);
    } catch (e, s) {
      return null;
    }
  }
}
