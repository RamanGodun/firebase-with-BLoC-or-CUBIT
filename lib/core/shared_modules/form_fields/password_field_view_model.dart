library;

/// 📦 Generic ViewModel for obscurable fields (used in BlocSelector)
//------------------------------------------------------------------

class ObscurableFieldVM {
  final String? errorText;
  final bool isObscure;

  const ObscurableFieldVM({required this.errorText, required this.isObscure});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObscurableFieldVM &&
          errorText == other.errorText &&
          isObscure == other.isObscure;

  @override
  int get hashCode => Object.hash(errorText, isObscure);
}
