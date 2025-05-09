import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'core/app_config/bootstrap/bootstrap.dart';
import 'core/app_config/bootstrap/di_container.dart';
import 'core/shared_modules/localization/_localization_config.dart';
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
  runApp(AppLocalization.wrap(const RootProviders()));

  ///
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
	ResultX Використати .match або .emitStates у Cubit, замінити .fold

  ResultFutureX Додати в UseCase, Service, Cubit для чистішої логіки

 EitherGetters Замінити result.fold(...) на result.leftOrNull?.log() тощо
 
DSLLikeResultHandler Замінити .fold в Cubit на DSL-підхід




? DSLLikeResultHandlerAsync   Доречно в UI або async flows з overlay або chain 
 



 */