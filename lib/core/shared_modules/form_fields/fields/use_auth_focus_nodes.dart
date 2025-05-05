import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Returns a record with named focus nodes for auth form
({
  FocusNode name,
  FocusNode email,
  FocusNode password,
  FocusNode confirmPassword,
})
useAuthFocusNodes() {
  final name = useFocusNode();
  final email = useFocusNode();
  final password = useFocusNode();
  final confirmPassword = useFocusNode();

  return (
    name: name,
    email: email,
    password: password,
    confirmPassword: confirmPassword,
  );
}
