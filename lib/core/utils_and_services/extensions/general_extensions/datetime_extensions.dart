part of '_general_extensions.dart';

extension DateTimeX on DateTime {
  String toFormatted([String format = 'yyyy-MM-dd']) =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}
