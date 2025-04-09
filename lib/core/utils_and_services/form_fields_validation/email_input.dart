// 📄 email_input.dart
import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

class EmailInput extends FormzInput<String, String> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!isEmail(value)) return 'Invalid email';
    return null;
  }
}
