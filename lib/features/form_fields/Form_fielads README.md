# 📑 Form Fields Module Guide (Formz + Clean Architecture)

---

## 🌟 Purpose

This module provides a **clean, reusable, and UX-optimized** form field infrastructure using `Formz` and `Bloc/Cubit`,
tightly aligned with **Clean Architecture**, **SRP**, and **Flutter UX best practices**.
It supports **sign-in**, **sign-up**, and any custom forms with:

- ✅ Declarative validation logic
- 🎯 Semantic UI feedback
- 📱 iOS-like focus transitions
- ♻️ Reactive state updates

---

## 🧱 Structure Overview

```
core/
└── shared_modules/
    └── form_fields/
        ├── input_validation/       # Pure validation logic with Formz
        ├── extensions/             # Formz status extensions
        ├── widgets/                # Input factories & custom widgets
        └── use_auth_focus_nodes.dart
```

---

## 🧠 Input Validations

### Each field is encapsulated in a `FormzInput` subclass:

- `EmailInputValidation`
- `NameInputValidation`
- `PasswordInput`
- `ConfirmPasswordInput`

Each class:

- Validates independently
- Exposes `.errorText` for UI
- Provides `.uiError` for `BlocSelector` rendering

### Example:

```dart
final email = EmailInputValidation.dirty('some@email');
if (email.isValid) doSomething();
```

### Confirm Password:

```dart
final confirm = ConfirmPasswordInput.dirty(password: pwd, value: repeat);
```

Use `updatePassword()` to sync if password changes dynamically.

---

## 🔁 Status Extension: `FormzStatusX`

Located at `extensions/formz_status_x.dart`:

```dart
if (status.canSubmit && isValidated) doSubmit();
```

Adds clear aliases:

- `isLoading`, `isIdle`, `isValidated`
- `canSubmit` = safe trigger condition

---

## 🧩 Widget System — InputFieldFactory

Centralized `InputFieldFactory.create(...)` builds unified UI across all forms:

```dart
InputFieldFactory.create(
  type: InputFieldType.email,
  focusNode: focusNode,
  errorText: uiError,
  onChanged: onChange,
  onSubmitted: () => nextFocus.requestFocus(),
);
```

Supports:

- Field switching
- Password toggle
- Auto-localized labels
- Keyboard types & validation UX

> ✨ Seamless, iOS-native UX.

---

## 🧱 Widget: AppTextField

A styled abstraction over `TextField`:

- Supports labels, prefix/suffix icons
- Integrates with localization
- Manages keyboard types
- Auto-dismisses keyboard on submit

---

## 🧪 Reusable Form Button: `FormSubmitButton`

Button auto-connects with `Cubit` and handles:

- Status rendering
- Disable when invalid
- Auto-loading indicator

```dart
FormSubmitButton<SignInCubit, SignInState>(
  text: 'Sign In',
  onSubmit: (_) => context.read<SignInCubit>().submit(),
  statusSelector: (s) => s.status,
  isValidatedSelector: (s) => s.isValid,
)
```

> 🔄 Includes animation, Hero tag, and rounded styling.

---

## 👁️ Password Visibility

Use `ObscureToggleIcon` to attach eye-toggle functionality.

```dart
suffixIcon: ObscureToggleIcon(
  isObscure: state.isObscure,
  onPressed: toggleCallback,
)
```

---

## 🎛 Focus Management: `useAuthFocusNodes()`

```dart
final focus = useAuthFocusNodes();
```

Returns named tuple of `FocusNode`s:

```dart
(
  name: ..., email: ..., password: ..., confirmPassword: ...
)
```

- Used in all forms
- Enables field traversal and improved mobile UX

---

## 🔁 State Integration

Each `Cubit` exposes `updateWith(...)` extension to maintain immutability and centralized validation:

```dart
emit(state.updateWith(password: newPassword));
```

Extensions like `SignInStateValidationX`, `SignUpStateValidationX` validate automatically with:

```dart
validateWith(...) → bool
```

---

## 🧩 Example Integration in SignInPage

```dart
BlocSelector<SignInCubit, SignInPageState, String?>(
  selector: (state) => state.email.uiError,
  builder: (context, errorText) {
    return InputFieldFactory.create(
      type: InputFieldType.email,
      focusNode: focus.email,
      errorText: errorText,
      onChanged: context.read<SignInCubit>().emailChanged,
      onSubmitted: () => focus.password.requestFocus(),
    );
  },
)
```

> ✅ Ensures rebuild only when validation message changes.

---

## ✅ Summary Benefits

| Feature                  | Purpose                                    |
| ------------------------ | ------------------------------------------ |
| `FormzInput` Validations | SRP-compliant, unit testable logic         |
| `FormzStatusX`           | Clean submission status handling           |
| `AppTextField`           | Unified form design & UX                   |
| `FocusNodes Hook`        | Native-like keyboard control               |
| `FormSubmitButton`       | Animated submit + validation awareness     |
| `ObscureToggleIcon`      | Reusable show/hide for passwords           |
| `State Extensions`       | Clean state mutation + validation layering |

---

## 🧠 Final Thought

This module transforms form logic from scattered widgets into a **centralized, declarative, and user-centric system**
that is easy to maintain and extend across a modern Flutter project.

> 🚀 **Declarative. Composable. User-First.**
