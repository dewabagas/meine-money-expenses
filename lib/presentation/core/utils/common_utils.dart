import 'dart:math';

import 'package:intl/intl.dart';

String trimText(String name, int maxLength) {
  if (name.length <= maxLength) {
    return name;
  } else {
    return '${name.substring(0, maxLength - 3)}...';
  }
}

String formatPrice(double price) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: '',
    decimalDigits: 0,
  );
  return formatter.format(price);
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input;

  final sentences = input.split(RegExp(r'(?<=[.!?])\s+'));
  final capitalizedSentences = sentences.map((sentence) {
    if (sentence.isEmpty) return sentence;
    return sentence[0].toUpperCase() + sentence.substring(1);
  }).join(' ');

  return capitalizedSentences;
}

DateTime? parseDateString(String? dateString) {
  if (dateString == null || dateString.isEmpty) return null;
  return DateTime.tryParse(dateString);
}

String formatDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  DateFormat dateFormat =
      DateFormat('d MMMM yyyy'); // 'id' is the locale for Indonesian
  return dateFormat.format(date);
}

String formatDateDash(String date) {
  final DateTime parsedDate = DateTime.parse(date);
  return DateFormat('yyyy-MM-dd').format(parsedDate);
}

String formatRupiah(int value) {
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
  return formatter.format(value);
}

String formatPriceInput(String value) {
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
  return formatter.format(int.parse(value.replaceAll('.', '')));
}

String capitalizeEachWord(String input) {
  if (input.isEmpty) return input;

  return input.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}

String formatErrorMessage(String errorMessage) {
  return errorMessage.replaceAll(RegExp(r'[\{\}]'), '');
}

String formatFullDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  DateFormat formatter = DateFormat('EEEE, d MMMM yyyy', 'en_US');
  return formatter.format(date);
}
