extension StringExtension on String {
  String get removeExceptionTextIfContains {
    if (contains('Exception:')) return replaceFirst('Exception:', '');
    return this;
  }
}

