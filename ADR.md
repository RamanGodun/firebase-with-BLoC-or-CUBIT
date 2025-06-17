# 📘 Architectural Decision Record

## 🧠 Context

This document outlines key architectural choices made in the project **`firebase_with_bloc_or_cubit`**
— a Flutter foundation for apps powered by Firebase, Clean Architecture, and modular design.
It includes overlay handling, localization, theming, form validation, and state management out-of-the-box.

---

## 🔨 Decision: Clean Architecture (Stateless + UseCase-Driven)

### Rationale

- ✅ Full adherence to **SOLID principles**
- ♻️ **Separation of Concerns** across Domain, Data, and UI
- 🔌 **Use Cases** decouple business logic from Cubits
- 🔁 Facilitates feature-level modularity and testability
- 🧪 UseCase classes allow isolated unit testing without side effects

### Structure Overview

```bash
lib/
├── core/                # App-wide modules: DI, navigation, theme, overlays
├── features/            # Feature modules (SignIn, SignUp, Profile)
│   ├── domain/          # Entities, UseCases, Abstract Repos
│   ├── data/            # DTOs, Repos, DataSources
│   └── presentation/    # Cubits, Views, Widgets
├── shared/              # Shared domain entities, DTOs, extensions
```

---

## 🔐 Decision: Firebase Auth + Firestore (with Sealed Failures)

- 🔐 FirebaseAuth handles sign-in/up, session management
- ☁️ Firestore stores user profiles (`usersCollection`)
- 🔁 `ProfileRemoteDataSource` fetches DTOs → mapped to entities
- 🔐 Failures are encapsulated and surfaced to UI via `FailureUIModel`
- 🔧 FirebaseOptions are loaded from `.env` via `flutter_dotenv`

---

## 📦 Decision: State Management via Cubit + Formz

- 🔁 Stateless Cubits with injected UseCases per feature
- 🧼 All validation handled via `Formz` (custom inputs)
- 🧠 Domain state only — overlays/dialogs triggered via presentation layer
- ⏱️ Debounced field validation for email/name inputs
- ♻️ `Consumable<T>` used for one-time error delivery
- ✅ `HydratedBloc` used for persistent theme state

---

## 🧭 Decision: Navigation via GoRouter

- 🧩 Typed route names via strongly defined constants
- 🔐 Auth-aware redirect guards
- 📦 Routing logic isolated in `core/navigation/`
- 🧼 Navigation driven declaratively via context extensions

---

## 🧩 Decision: Dependency Injection with GetIt

- 🧠 DI container `AppDI` provides feature-based registration
- ✅ Only DI layer knows about concrete implementations
- 🔄 SafeRegistration extensions to prevent hot-reload conflicts
- 🔌 Feature modules register: Cubits, UseCases, Repositories, DataSources

---

## 🧰 Decision: Shared Core Modules

- ✳️ `OverlayEngine` — reusable entry for dialogs/snackbars/banner feedback
- 🈯️ `LocalizationModule` — supports codegen via `easy_localization`
- 🎨 `AppThemes` — Cupertino-like themes using `SFProText`, glassmorphism
- 🔠 `TextType`, `TextWidget`, `Spacing`, `ImagesPaths` all generated via `Spider`
- 🧱 Reusable form system (factory fields, validation logic, focus nodes)

---

## 🧪 Testing Strategy (TDD-Ready)

- ✅ Unit tests planned for all UseCases, Repos, Input Validations
- 💬 `mockito` used for abstract dependency mocking
- 📦 Architecture allows widget/golden tests without business logic entanglement
- ⚙️ CI-ready structure with `very_good_analysis`

---

## 📲 Firebase Environment via `.env`

- 🔒 `flutter_dotenv` loads credentials from `.env`
- 🌐 `EnvFirebaseOptions.currentPlatform` provides platform-aware init
- 🧰 Supports `.env`, `.env.dev`, `.env.staging`, `.env.prod`

---

## ✅ Summary

The project delivers:

- ✅ **Fully decoupled Clean Architecture foundation**
- ✅ **Firebase integration (auth + Firestore)** via abstraction and DI
- ✅ **Cubit state with Formz + failure overlays**
- ✅ **Glassmorphism theming** with Cupertino UX
- ✅ **GoRouter navigation**, responsive layout, and error feedback system
- ✅ **Modular, test-friendly foundation** for scaling features

---

> 📌 See `README.md` for full module list and setup instructions.
