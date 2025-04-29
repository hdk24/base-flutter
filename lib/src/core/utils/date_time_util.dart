import 'dart:io';

import 'package:intl/intl.dart';

class DateTimeUtil {
  // default locale
  static String locale = Platform.localeName;

  // date time format
  static String DD_MM_YYYY = 'dd/MM/yyyy';
  static String EEE_MMMM_DD_YYYY = "EEE, MMMM dd yyyy";

  // convert date time to string
  static String convertToString(DateTime date, String format) {
    try {
      return DateFormat(format, locale).format(date);
    } catch (e) {
      return "-";
    }
  }
}
