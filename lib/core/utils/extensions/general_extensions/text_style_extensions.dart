part of '_general_extensions.dart';

extension TextStyleX on TextStyle {
  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}
