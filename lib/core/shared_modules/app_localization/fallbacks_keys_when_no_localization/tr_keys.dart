/// 🧩 [FallbackKeysWhenNoLocalization] — fallback keys when localization is not used.
/// ✅ Used when EasyLocalization is not initialized.
/// ✅ Serves as simple storage of UI fallback strings.
abstract final class FallbackKeysWhenNoLocalization {
  const FallbackKeysWhenNoLocalization._();

  /// 🌐 Language switch confirmations
  static const languageSwitchedToEn = 'Language switched to 🇬🇧 English';
  static const languageSwitchedToUa = 'Мову змінено на 🇺🇦 Українську';
  static const languageSwitchedToPl = 'Język zmieniono na 🇵🇱 Polski';

  /// ⚠️ Overlay error messages
  static const unexpected = 'Something went wrong';
  static const noInternet = 'No internet connection';
  static const timeout = 'Request timeout. Try again.';

  /// ✅ Overlay success messages
  static const saved = 'Saved successfully';
  static const deleted = 'Item deleted';

  /// 🎨 Theme mode
  static const lightModeEnabled = 'Light mode enabled';
  static const darkModeEnabled = 'Dark mode enabled';

  /// 📌 Dialog titles (used in fallback UI only)
  static const dialogTitleError = 'Error occurred';
  static const ok = 'OK';
  static const cancel = 'Cancel';

  ///
}
