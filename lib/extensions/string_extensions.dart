// ignore_for_file: unnecessary_this

extension StringExtension on String {
  String getFirstLetter() {
    if (isEmpty) {
      return '';
    } else {
      return this[0];
    }
  }

  String getFirstLetterCapital() {
    if (isEmpty) {
      return '';
    } else {
      final value = this[0].toUpperCase();
      return this.replaceFirst(this[0], value);
    }
  }
}
