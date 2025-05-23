# 📦 firebase_with_bloc_or_cubit

A **modular Firebase starter project** powered by **Flutter + BLoC/Cubit**, Clean Architecture. Might be as
base for little apps with built-in support for **localization**, **themability**, **GoRouter navigation**, and more.

---

## ✨ Overview

This project acts as a robust foundation for Flutter apps that require:

- ✅ Firebase Authentication (Email/Password)
- ✅ Profile creation and storage in Firestore
- ✅ Fully structured Clean Architecture
- ✅ BLoC/Cubit state management with separation of concerns
- ✅ Ready-to-use systems: overlay, theming, localization, error handling
- ✅ Scalable modularity and dependency injection via GetIt

> Perfect for rapid prototyping or extending into a complex production app.

---

## 🔥 Features

- 🔐 **Authentication**: Email/Password SignIn & SignUp
- 📄 **User Profile**: Saved and fetched from Firestore
- 🎯 **State Management**: Cubit + BlocObserver lifecycle tracking
- 🎨 **Theme System**: SF Pro Text, dark/light theme, persistent state
- 🌐 **Localization**: Code-generated with `easy_localization`
- 🧭 **Navigation**: `GoRouter` with auth-aware redirect
- 🧰 **Overlays**: Snackbars, dialogs, banners via overlay engine
- 🛠 **Form System**: Validated, declarative inputs with custom field factory
- 🧱 **Core Modules**: Logging, routing, DI, overlays, error handling
- 🧪 **Firebase Config**: via `.env` + `flutter_dotenv`
- 🧬 **Code Generation**: `Freezed`, `JsonSerializable`, `Spider`, `EasyLocalization`, etc.

---

## 🧠 Architecture

The app is built with strict **Clean Architecture**, following AMC principles:

```
lib/
├── core/                     # Global systems (di, overlays, navigation, theme, etc)
│   └── shared_modules/       # Reusable modules: errors, localization, form, etc
├── features/                 # Feature-driven modular structure (auth, profile...)
│   └── feature_name/         # Follows Domain → Data → Presentation layering
├── resources/                # Spider-generated assets paths
└── main.dart                 # App entry point with DI + observers setup
```

### Key Architectural Contracts

| Layer            | Responsibility                                                |
| ---------------- | ------------------------------------------------------------- |
| **Presentation** | Stateless views, Cubit listeners, overlay flows only          |
| **Domain**       | Entities, UseCases, repository interfaces                     |
| **Data**         | DTOs, repositories, data sources, Firebase/firestore handling |

> All Cubits use UseCases only. No direct repo or data access.

---

## ⚙️ Firebase Configuration

1. **Set up Firebase project** in [console](https://console.firebase.google.com)
2. Add **Android/iOS** apps
3. Add platform-specific files:

   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`

4. Create `.env` file:

```env
FIREBASE_API_KEY=...
FIREBASE_APP_ID=...
FIREBASE_PROJECT_ID=...
FIREBASE_MESSAGING_SENDER_ID=...
FIREBASE_STORAGE_BUCKET=...
FIREBASE_AUTH_DOMAIN=...
FIREBASE_IOS_BUNDLE_ID=...
```

5. Install deps and configure:

```bash
flutter pub get
flutterfire configure --project=<your_project_id>
```

---

## 🧩 Tech Stack

| Layer        | Library / Tool                            |
| ------------ | ----------------------------------------- |
| State        | `flutter_bloc`, `hydrated_bloc`           |
| Routing      | `go_router`                               |
| Overlay      | Custom overlay engine with context mixins |
| Theming      | `ThemeCubit`, `SFProText`, `GoogleFonts`  |
| Validation   | `formz`, custom `Input` classes           |
| Localization | `easy_localization`, `.json` + `.g.dart`  |
| Firebase     | `firebase_auth`, `cloud_firestore`        |
| DI           | `get_it` + safe registration extensions   |
| Codegen      | `freezed`, `json_serializable`, `spider`  |

---

## 📄 Highlights

- 🧠 **`core/shared_modules/`** — overlay, theme, error, form, localization engines
- 📁 **`core/app_config/bootstrap/di_container.dart`** — centralized GetIt setup
- 🧭 **`core/navigation/app_router.dart`** — GoRouter setup + redirect logic
- ✨ **`features/profile/`**, **`features/auth/`** — full BLoC + UseCase examples
- 🧰 **`form_fields/widgets/`** — reusable input components with validation

---

## 🧪 Testing Strategy

Designed with the testing pyramid in mind:

- ✅ **Unit tests**: UseCases, Repos, Cubits (via injected mocks)
- 🧩 **Widget tests**: Stateless widgets & UI behavior
- 🔁 **Integration tests**: Can be added progressively

---

## 🧾 ADR / Architecture Philosophy

See [`ADR.md`](./ADR.md) for:

- Clean Architecture rationale
- Why overlays never live in Cubit/UseCase
- DI via GetIt vs Riverpod discussion
- Testing strategies & best practices

---

## 🛠 Getting Started

```bash
git clone https://github.com/yourname/firebase_with_bloc_or_cubit.git
cd firebase_with_bloc_or_cubit
flutter pub get
flutter run
```

For localization/codegen:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## ⚖️ License

[MIT License](./LICENSE) © 2025 [Roman Godun](mailto:4l.roman.godun@gmail.com)

> Built with ❤️ for clean, scalable Flutter apps.
