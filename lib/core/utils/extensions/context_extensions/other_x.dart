part of '_context_extensions.dart';

extension OtherContextX on BuildContext {
  void unfocusKeyboard() => FocusScope.of(this).unfocus();
}
