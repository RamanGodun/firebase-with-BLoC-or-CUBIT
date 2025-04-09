// 📄 password_input.dart
import 'package:formz/formz.dart';

class PasswordInput extends FormzInput<String, String> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password too short';
    return null;
  }
}
