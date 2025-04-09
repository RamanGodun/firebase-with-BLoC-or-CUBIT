# 📘 Architectural Decision Record (ADR.md)

## 🧠 Context

This document summarizes architectural decisions made during the development of the **`firebase_with_bloc_or_cubit`** project — a test-task showcasing a scalable and production-aligned Flutter app integrated with Firebase.

---

## 🔨 Decision: Clean Architecture (Layered)

### Rationale

- 🔁 Promotes maintainable **separation of concerns**
- 🧪 Enables **unit testing** of business logic
- 📈 Scales with future **feature growth**

### Structure Overview

```
lib/
├── core/        # Global configs: routing, DI, constants
├── data/        # Firebase access layer (DTOs, repositories)
├── features/    # UI + state logic (BLoCs, Cubits)
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

## 📦 Decision: State Management via BLoC/Cubit

- 🌐 `AuthBloc` manages global authentication state
- ✍️ `SignInCubit`, `SignUpCubit`, `ThemeCubit` handle local form logic
- ✅ Input validation via `Formz`
- 🕒 Debouncing implemented for performance
- 💾 Theme state persisted via `HydratedBloc`

---

## 🧭 Decision: GoRouter for Navigation

- Single source of truth for route definitions
- 🚦 Auth-aware redirection using `AuthBloc.state`
- Declarative structure with support for nested routes

---

## 🧩 Decision: Dependency Injection (GetIt)

- All core services registered in `initDependencies()`
- UI layers remain clean and testable
- Ensures **decoupling** and easy **mocking in tests**

---

## 🧱 Design & UX Decisions

- 🧊 **Glassmorphism overlays** for modern iOS/macOS-inspired UI
- 🎨 Cupertino-style dialogs on Apple platforms
- 📐 Responsive layout using `MediaQuery`
- 🌙 Theme switching via `ThemeCubit`

---

## ⚙️ Environment & Configuration

- 🔐 Secrets managed via `.env` files and `flutter_dotenv`
- 📲 Firebase initialized using `EnvFirebaseOptions`
  - Platform-aware config selection
- Environments supported:
  - `dev`, `staging`, `prod`

---

## ✅ Summary

This test project demonstrates:

- 🔹 **Production-ready architecture** using Clean Architecture
- 🔹 **Firebase integration** with DI & abstraction layers
- 🔹 **State management** via BLoC/Cubit + Formz + HydratedBloc
- 🔹 **GoRouter navigation** with dynamic auth-aware routing
- 🔹 **Modern UI practices** (accessibility, theme, overlays)

### 🔮 Possible Extensions

- 🌍 Localization
- 🔐 Firestore rules enforcement
- 🧪 Integration testing with mocks and coverage tracking
