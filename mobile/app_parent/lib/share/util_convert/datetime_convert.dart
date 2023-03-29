import 'package:intl/intl.dart';

String dateTimeConvertString(
    {required DateTime dateTime, required String dateType}) {
  return DateFormat(dateType, "vi_VN").format(dateTime);
}

DateTime? utcToLocalDateTime(DateTime? dateTime) {
  if (dateTime == null) return null;
  return dateTime.add(DateTime.now().timeZoneOffset);
}
