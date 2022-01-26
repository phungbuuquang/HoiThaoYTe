import 'package:intl/intl.dart';

class DateUtil {
  static String strDatetoStr(String dateStr,
      {String format = 'EEEE dd/MM/yyyy'}) {
    final date = DateUtil.stringToDate(dateStr);
    final DateFormat formatter = DateFormat(
      format,
      'vi',
    );
    return formatter.format(date);
  }

  static DateTime stringToDate(
    String input, {
    String format = 'MM/dd/yyyy HH:mm:ss a',
  }) {
    final DateFormat formatter = DateFormat(format);
    return formatter.parse(input);
  }
}
