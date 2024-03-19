import 'package:intl/intl.dart';

String kFormatDate(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}
