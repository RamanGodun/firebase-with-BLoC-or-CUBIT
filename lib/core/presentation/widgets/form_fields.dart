import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

enum FormFieldType {
  confirmPassword,
  password,
  email,
  name,
}

class CustomFormField extends StatelessWidget {
  final FormFieldType type;
  final TextEditingController controller;
  final TextEditingController? confirmController;
  final String? labelText;

  const CustomFormField({
    super.key,
    required this.type,
    required this.controller,
    this.confirmController,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: type == FormFieldType.password ||
            type == FormFieldType.confirmPassword,
        keyboardType: type == FormFieldType.email
            ? TextInputType.emailAddress
            : TextInputType.text,
        autocorrect: type != FormFieldType.email,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          labelText: labelText ?? _getLabelText(),
          prefixIcon: _getIcon(),
        ),
        validator: _getValidator(),
      ),
    );
  }

  // ========== PRIVATE METHODS ========== //

  String _getLabelText() {
    switch (type) {
      case FormFieldType.password:
        return 'Password';
      case FormFieldType.confirmPassword:
        return 'Confirm password';
      case FormFieldType.email:
        return 'Email';
      case FormFieldType.name:
        return 'Name';
    }
  }

  Icon _getIcon() {
    switch (type) {
      case FormFieldType.password:
      case FormFieldType.confirmPassword:
        return const Icon(Icons.lock);
      case FormFieldType.email:
        return const Icon(Icons.email);
      case FormFieldType.name:
        return const Icon(Icons.account_box);
    }
  }

  String? Function(String?) _getValidator() {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return '${_getLabelText()} required';
      }

      switch (type) {
        case FormFieldType.password:
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          break;
        case FormFieldType.confirmPassword:
          if (confirmController == null) {
            return 'Confirm password controller is missing';
          }
          if (confirmController!.text != value) {
            return 'Passwords do not match';
          }
          break;
        case FormFieldType.email:
          if (!isEmail(value.trim())) {
            return 'Enter a valid email';
          }
          break;
        case FormFieldType.name:
          if (value.length < 2 || value.length > 12) {
            return 'Name must be between 2 and 12 characters long';
          }
          break;
      }
      return null;
    };
  }
}
