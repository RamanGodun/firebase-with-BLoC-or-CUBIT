part of '_app_theme_type.dart.dart';

/// 🔤 [FontFamilyType] — Enhanced enum for supported fonts
/// 🧩 Can be extended to support Google Fonts in future

enum FontFamilyType {
  //----------------

  sfPro('SFProText'),
  aeonik('Aeonik'),
  poppins('Poppins');
  // google => custom dynamic font loading could go here later

  final String value;

  const FontFamilyType(this.value);

  //
}
