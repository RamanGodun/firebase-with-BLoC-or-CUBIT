# 📦 Dependency Injection Pattern with GetIt (Flutter Clean Architecture)

---

## 🌟 Purpose

Provide a **modular**, **scalable**, and **safe** way to register dependencies in Flutter projects using GetIt.
Ensures adherence to **Clean Architecture** principles and avoids duplicate registrations via extension helpers.

---

## 🧱 Base Structure

```txt
lib/
├── core/
│   └── injection/
│       └── injection_container.dart
├── features/
│   └── feature_name/
│       ├── data/
│       ├── domain/
│       └── presentation/
```

---

## 🔧 Extension: SafeRegistration

```dart
extension SafeRegistration on GetIt {
  void registerLazySingletonIfAbsent<T extends Object>(T Function() factory) {
    if (!isRegistered<T>()) registerLazySingleton<T>(factory);
  }

  void registerFactoryIfAbsent<T extends Object>(T Function() factory) {
    if (!isRegistered<T>()) registerFactory<T>(factory);
  }

  void registerSingletonIfAbsent<T extends Object>(T instance) {
    if (!isRegistered<T>()) registerSingleton<T>(instance);
  }
}
```

---

## 🚀 Entry Point for DI

```dart
final sl = GetIt.instance;

Future<void> initDIContainer() async {
  await _initOnBoardingModule();
  await _initAuthModule();
  // add more modules here as needed
}
```

---

## 📦 Pattern: Feature Module Setup

Each feature module follows the **Presentation → Domain → Data** order:

### ✅ Example: `_initAuthModule()`

```dart
Future<void> _initAuthModule() async {
  sl
    // Presentation
    ..registerFactoryIfAbsent<AuthBloc>(() => AuthBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        forgotPasswordUseCase: sl(),
        updateUserUseCase: sl(),
      ))

    // Domain
    ..registerLazySingletonIfAbsent(() => SignInUseCase(sl()))
    ..registerLazySingletonIfAbsent(() => SignUpUseCase(sl()))
    ..registerLazySingletonIfAbsent(() => ForgotPasswordUseCase(sl()))
    ..registerLazySingletonIfAbsent(() => UpdateUserUseCase(sl()))

    // Domain-Data Bridge
    ..registerLazySingletonIfAbsent<AuthRepo>(() => AuthRepoImpl(sl()))

    // Data
    ..registerLazySingletonIfAbsent<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )

    // External
    ..registerLazySingletonIfAbsent(() => FirebaseAuth.instance)
    ..registerLazySingletonIfAbsent(() => FirebaseFirestore.instance)
    ..registerLazySingletonIfAbsent(() => FirebaseStorage.instance);
}
```

### ✅ Example: `_initOnBoardingModule()`

```dart
Future<void> _initOnBoardingModule() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    // Presentation
    ..registerFactoryIfAbsent(() => OnBoardingCubit(
        cacheFirstTimerUseCase: sl(),
        checkUserFirstLaunchStatusUseCase: sl(),
      ))

    // Domain
    ..registerLazySingletonIfAbsent(() => CacheFirstTimerUseCase(sl()))
    ..registerLazySingletonIfAbsent(() => CheckUserFirstLaunchStatusUseCase(sl()))

    // Domain-Data Bridge
    ..registerLazySingletonIfAbsent<OnBoardingRepo>(
      () => OnBoardingRepoImpl(sl()),
    )

    // Data
    ..registerLazySingletonIfAbsent<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(sl()),
    )

    // External
    ..registerLazySingletonIfAbsent(() => prefs);
}
```

---

## 🛍️ Guidelines

### ✅ Register in order:

1. **Presentation** (Bloc, Cubit, Provider)
2. **Domain** (UseCases, Repository Contracts)
3. **Data** (RepoImpl, DataSources)
4. **External clients** (Dio, Firebase, SharedPreferences)

### ✅ Use `IfAbsent` methods

- Prevent accidental duplicate registrations
- Supports safe hot reloads

### ✅ One method per module

- Keeps SRP and separation by feature

### ✅ Use factory for UI

- Avoids persistent Bloc instances

### ✅ Use lazySingleton for UseCases

- Optimized resource usage

---

## 🧰 Abstract Example

```dart
Future<void> _initExampleModule() async {
  sl
    ..registerFactoryIfAbsent(() => ExampleCubit(sl()))
    ..registerLazySingletonIfAbsent(() => DoSomethingUseCase(sl()))
    ..registerLazySingletonIfAbsent<ExampleRepo>(() => ExampleRepoImpl(sl()))
    ..registerLazySingletonIfAbsent<ExampleDataSource>(() => ExampleDataSourceImpl(sl()));
}
```

---

## 📂 Injectable + GetIt (Alternative)

If you're using code generation:

```dart
@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
```

Use `@injectable`, `@lazySingleton`, `@module` to define dependencies:

```dart
@lazySingleton
class AuthService {
  final Dio client;
  AuthService(this.client);
}
```

```dart
@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(...));
}
```

Then generate with:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Pros:**

- Clean & automatic
- No boilerplate for manual `register...`

**Cons:**

- Harder to debug
- Slower iteration cycles

---

## 📃 Summary

| Level | Layer               | Example                        |
| ----- | ------------------- | ------------------------------ |
| 1     | UI                  | `AuthBloc`, `OnBoardingCubit`  |
| 2     | Use Case            | `SignInUseCase`                |
| 3     | Repo Contract       | `AuthRepo`, `OnBoardingRepo`   |
| 4     | Repo Implementation | `AuthRepoImpl`                 |
| 5     | Data Source         | `AuthRemoteDataSource`         |
| 6     | External Clients    | `FirebaseAuth`, `Dio`, `Prefs` |

> 🧠 Use this pattern across all features to maintain clarity, scalability and testability.

# 📦 Dependency Injection Setup — Clean Architecture

---

## 🎯 Purpose

Establish a scalable, modular, and testable dependency graph using `GetIt`, following **Clean Architecture** and **Dependency Inversion Principle**.

---

## 🧱 Structure by Layers

```text
Presentation  <-- depends on --  UseCases (Domain)  <-- depends on --  Abstractions (Interfaces)
                                                       ^
                                                       |
                                                Implementations (Data)
```

---

## ⚙️ DI Initialization (`init()`)

```dart
final di = GetIt.instance;

Future<void> init() async {
  di
    // 🧩 Cubit / State Management
    ..registerFactoryIfAbsent<AuthenticationCubit>(
      () => AuthenticationCubit(
        createUser: di(),
        getUsers: di(),
      ),
    )

    // 🧩 UseCases (Domain)
    ..registerLazySingletonIfAbsent<CreateUserUseCase>(
      () => CreateUserUseCase(di()),
    )
    ..registerLazySingletonIfAbsent<GetUsersUseCase>(
      () => GetUsersUseCase(di()),
    )

    // 🧩 Repositories (Data)
    ..registerLazySingletonIfAbsent<AuthenticationRepository>(
      () => AuthRepositoryImplementation(di()),
    )

    // 🧩 Remote Data Source (Data)
    ..registerLazySingletonIfAbsent<AuthRemoteDataSource>(
      () => AuthRemoteDataSrcImplementation(di()),
    )

    // 🧩 External dependencies
    ..registerLazySingletonIfAbsent<http.Client>(() => http.Client());
}
```

---

## 🔁 Extension for Safe Registration

```dart
extension SafeRegistration on GetIt {
  void registerLazySingletonIfAbsent<T extends Object>(T Function() factory) {
    if (!isRegistered<T>()) {
      registerLazySingleton<T>(factory);
    }
  }

  void registerFactoryIfAbsent<T extends Object>(T Function() factory) {
    if (!isRegistered<T>()) {
      registerFactory<T>(factory);
    }
  }

  void registerSingletonIfAbsent<T extends Object>(T instance) {
    if (!isRegistered<T>()) {
      registerSingleton<T>(instance);
    }
  }
}
```

---

## ✅ Benefits

- **Separation of concerns** (no cross-layer knowledge)
- **Easy mocking** for unit tests
- **Flexible & decoupled** infrastructure
- **Automatic reusability** across features

---

## 🧪 Example (Unit Test)

```dart
setUp(() {
  di.registerLazySingleton<AuthenticationRepository>(() => MockAuthRepo());
  di.registerLazySingleton(() => CreateUserUseCase(di()));
});
```

---

## 📦 Summary

> Only the DI container knows about concrete implementations. All other layers rely on abstractions.
