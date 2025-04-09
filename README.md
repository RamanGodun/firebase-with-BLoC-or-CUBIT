# 📦 Firebase with BLoC/Cubit

A test-task project showcasing a production-grade Firebase integration in Flutter, built with Clean Architecture and BLoC/Cubit state management.

---

## ✨ Overview

This app demonstrates a robust authentication flow using **Firebase Auth** + **Cloud Firestore**, structured using **Clean Architecture**, scalable **BLoC/Cubit** state management, and **GoRouter** for declarative navigation.

The codebase simulates a real-world setup to validate **mid-to-senior Flutter engineering skills** through modularity, maintainability, and production-level conventions.

---

## 🔥 Features

- ✅ Firebase Email/Password Authentication
- ☁️ User profile creation & persistence in Firestore
- 🔐 AuthBloc + SignInCubit / SignUpCubit for auth state
- 🧠 Clean Architecture (Core / Data / Features / Presentation)
- 🎨 Theme switching with ThemeCubit (light/dark)
- 🧭 GoRouter navigation with auth-aware redirection
- 💡 Centralized validation, error handling, overlays
- 📁 Modular file structure with dependency injection

---

## 🧠 Architecture

The project follows **Clean Architecture principles**:

```bash
lib/
├── core/           # App-wide configs, DI, routing, theming, utilities
├── data/           # Firebase access, DTOs, Repositories
├── features/       # Feature-based Cubits, AuthBloc, Profile
├── presentation/   # Shared widgets and screens
```

### Key Principles

- ❌ No business logic in UI layer
- ✅ `core/di/` provides dependency injection via GetIt
- ✅ Cubits and BLoCs receive repositories via constructor injection
- ✅ `data/` layer isolates Firebase APIs behind abstractions

---

## 🚀 Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/<your-username>/firebase_with_bloc_or_cubit
cd firebase_with_bloc_or_cubit
```

### 2. Set Up Firebase

- Create a Firebase project
- Add Android/iOS apps
- Download and place:
  - `google-services.json` for Android
  - `GoogleService-Info.plist` for iOS

### 3. Configure .env

Create an `.env` file with your Firebase credentials:

```env
FIREBASE_API_KEY=...
FIREBASE_APP_ID=...
FIREBASE_PROJECT_ID=...
FIREBASE_STORAGE_BUCKET=...
FIREBASE_MESSAGING_SENDER_ID=...
FIREBASE_AUTH_DOMAIN=...
FIREBASE_IOS_BUNDLE_ID=...
```

### 4. Run the App

```bash
flutter pub get
flutter run
```

---

## 🧩 Tech Stack

| Layer      | Technology                          |
| ---------- | ----------------------------------- |
| State      | `flutter_bloc`, `hydrated_bloc`     |
| Firebase   | `firebase_auth`, `cloud_firestore`  |
| Routing    | `go_router`                         |
| DI         | `get_it`                            |
| Theming    | `ThemeCubit`, `SF Pro Text`         |
| Validation | `formz`, custom validators          |
| UI/UX      | Cupertino-style, Hero, OverlayEntry |

---

## 📁 Folder Highlights

- `lib/core/navigation/router.dart` → Declarative GoRouter with auth redirects
- `lib/features/auth_bloc/` → Global authentication state
- `lib/features/sign_in/` & `sign_up/` → Auth forms and Cubits
- `lib/data/repositories/` → Firebase logic decoupled via repositories
- `lib/core/config/env.dart` → Environment switching & secrets loader
- `lib/core/utils_and_services/` → Error dialogs, debounce, overlays

---

## 🧪 Testing & Quality

While automated tests were not required for the test task, the structure is ready for:

- ✅ Unit testing of Cubits and Repositories
- ✅ Mocking via injected interfaces
- ✅ Golden/UI testing for presentation layer

---

## ⚖️ License

MIT License © 2025 [Roman Godun](mailto:4l.roman.godun@gmail.com)
