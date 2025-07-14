part of 'text_theme_factory.dart';

/// 🔤 [AppFontFamily] — Enhanced enum for supported fonts
/// 🧩 Can be extended to support Google Fonts in future

enum AppFontFamily {
  //----------------

  sfPro('SFProText');
  // aeonik('Aeonik'),
  // poppins('Poppins');
  // google => custom dynamic font loading could go here later

  final String value;
  const AppFontFamily(this.value);

  //
}
