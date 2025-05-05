import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

/// 📧 [EmailInput] — Validates email format & presence
class EmailInput extends FormzInput<String, String> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    if (value.trim().isEmpty) return 'Email is required';
    if (!isEmail(value.trim())) return 'Invalid email';
    return null;
  }

  /// 🧠 Converts raw error to displayable string
  @override
  String? get displayError => isPure || isValid ? null : error;
}
