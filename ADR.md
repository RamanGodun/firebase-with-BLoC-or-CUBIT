# 📘 Architectural Decision Record

## 🧠 Context

This document summarizes architectural decisions made during the development of the
**`firebase_with_bloc_or_cubit`** project — a test-task showcasing a scalable Flutter app integrated with Firebase.

---

## 🔨 Decision: Clean Architecture (Layered)

### Rationale

- ♻️ Promotes maintainable **separation of concerns**
- 🧪 Enables **unit testing** of business logic
- 📈 Scales with future **feature growth**
- ♻️ Follows the "dependency rule": inner layers never depend on outer ones
- ↺ Ensures clear flow: [UI → Cubit → Repository → Firebase]

### Structure Overview

```bash
lib/
├── core/         # Global configs: routing, DI, constants
├── data/         # Firebase access layer (DTOs, repositories)
├── features/     # UI + state logic (BLoCs, Cubits)
├── presentation/ # Shared widgets and screens
```

---

## 🔐 Decision: Firebase Auth + Firestore

- Firebase Auth handles **sign-in/sign-up** and session management
- Firestore stores **user profile data** (e.g. name, rank, points)
- Repositories:
  - `AuthRepository` → authentication logic
  - `ProfileRepository` → Firestore user profile access
- Firebase instances injected via **constructor DI**, not used globally

---

## 📆 Decision: State Management via BLoC/Cubit

- 🌐 `AuthBloc` manages global authentication state
- ✍️ `SignInCubit`, `SignUpCubit`, `ThemeCubit` handle local form logic
- ✅ Input validation via `Formz`
- 🥒 Debouncing implemented for performance
- 📂 Theme state persisted via `HydratedBloc`
- 🧹 Local Cubits instantiated per screen (short-lived)
- ❌ Avoids `BlocProvider.value` for non-singletons to preserve dispose logic

---

## 🤭 Decision: GoRouter for Navigation

- Single source of truth for route definitions
- 🚦 Auth-aware redirection using `AuthBloc.state`
- Declarative structure with support for nested routes

---

## 🥩 Decision: Dependency Injection (GetIt)

- All services registered via `initDependencies()`
- Keeps UI layers **clean**, **pure**, and **testable**
- Ensures **decoupling** and supports mocking for unit tests

---

## 🧱 Design & UX Decisions

- 🧊 Glassmorphism overlays for iOS/macOS feel
- 🎨 Cupertino-style dialogs for Apple platforms
- 📀 Responsive layout via `LayoutBuilder` & `MediaQuery`
- 🌙 Theme toggling via `ThemeCubit`
- ♿️ Accessibility supported (contrast, typography, tap targets)

---

## ⚙️ Environment & Configuration

- 🔐 Secrets managed via `.env`, loaded by `flutter_dotenv`
- 📲 Firebase initialized using `EnvFirebaseOptions`
  - Platform-aware init for iOS/Android/Web
- 🔧 Supports `.env.dev`, `.env.staging`, `.env` (prod)

---

## ✅ Summary

This test project demonstrates:

- ✅ **Scalable Clean Architecture** for real-world Flutter apps
- ✅ **Firebase integration** using DI & abstraction
- ✅ **BLoC/Cubit-based state** with debounced validation and Formz
- ✅ **GoRouter** navigation with dynamic redirect logic
- ✅ **Modern UX**: dark mode, overlays, platform-specific dialogs
- ✅ **Environment-based config** for staging/production setups

### 🔮 Possible Extensions

- 🌍 Localization
- 🔐 Firestore rules enforcement
- 🧪 Integration testing with mocks and CI coverage
