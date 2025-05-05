import 'package:formz/formz.dart';

/// 🔒 [PasswordInput] — Validates presence and minimum length
class PasswordInput extends FormzInput<String, String> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 'Password is required';
    if (trimmed.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  String? get displayError => isPure || isValid ? null : error;
}
