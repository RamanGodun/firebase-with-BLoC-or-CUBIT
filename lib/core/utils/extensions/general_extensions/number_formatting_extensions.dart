part of '_general_extensions.dart';

extension NumFormatX on num {
  String toCurrency({String symbol = '₴'}) => '$symbol${toStringAsFixed(2)}';
}
