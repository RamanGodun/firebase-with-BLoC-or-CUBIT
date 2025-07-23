import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 🧠 [useSignUpFocusNodes] — Hook that returns a named record of [FocusNode]s
/// for use in authentication forms (e.g. sign up, login).
/// Ensures consistent focus handling across fields.

({
  FocusNode name,
  FocusNode email,
  FocusNode password,
  FocusNode confirmPassword,
})
useSignUpFocusNodes() {
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

////

////

({FocusNode email, FocusNode password}) useSignInFocusNodes() {
  final email = useFocusNode();
  final password = useFocusNode();

  return (email: email, password: password);
}
