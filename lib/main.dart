import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'core/app_config/bootstrap/bootstrap.dart';
import 'core/app_config/bootstrap/di_container.dart';
import 'features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'core/shared_modules/theme/theme_cubit/theme_cubit.dart';

/// 🟢 Initializes environment, DI, and runs app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔌 Firebase + HydratedBloc + Bloc Observer
  await AppBootstrap.initialize();

  /// 📦 Initializes all app dependencies via GetIt
  await AppDI.init();

  /// 🚀 Run App
  runApp(const RootProviders());
}

/// 🌐 [RootProviders] — Wraps global Blocs for app-wide access
final class RootProviders extends StatelessWidget {
  const RootProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di<AuthBloc>()), // 🔐 Auth State
        BlocProvider.value(value: di<AppThemeCubit>()), // 🎨 Theme State
      ],
      child: const AppRootView(),
    );
  }
}

/*

Уніфікація відображення помилок у UI: Проведіть ревізію всіх місць у застосунку, де відображаються повідомлення про помилки. 
Переконайтеся, що всюди використовується централізований Overlay Notification Service. Якщо десь використовувалися альтернативні підходи (SnackBar безпосередньо, AlertDialog тощо), 
рефакторіть ці місця, щоб вони теж користувалися OverlayService. Це гарантує єдиний стиль сповіщень. 
Також розгляньте можливість зробити OverlayService більш гнучким: наприклад, він може сам вирішувати,
 як саме показувати повідомлення (Toast, Banner, Popup) залежно від типу помилки або контексту.
 Статус “stateless” у сервісі важливо зберегти – нехай він отримує всі потрібні дані при виклику. 
Якщо потрібно, можна передавати контекст або ключ навігатора для показу Overlay.of(...). 
Документуйте використання сервісу, щоби всі розробники команди розуміли: цей спосіб є канонічним для помилок у UI.

 */
