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
	•	overlay.banner.custom(...)
	•	overlay.dialog.confirmAsync(...)
	•	overlay.toast(...)
 */

/*
part of '_failure_x_imports.dart';

/// 🧾 [FailureUI] — provides structured, detailed error formatting for diagnostics/UI.
//-------------------------------------------------------------------------------------

extension FailureUI on Failure {
  //
  /// 🧾 Returns detailed debug message (code + plugin name)
  String get formattedMessage => switch (this) {
    GenericFailure(:final plugin, :final code, :final message) =>
      '$message\n\nCode: $code\nSource: ${plugin.name}',
    ApiFailure(:final statusCode, :final message) =>
      '$message\n\nStatus Code: $statusCode',
    _ => message,
  };

  /// 🌍 Returns localized message if possible, otherwise fallback to raw `message`
  String uiMessageOrRaw([BuildContext? context, Map<String, String>? params]) {
    try {
      if (context != null && translationKey != null) {
        final localizations = AppLocalizations.of(context);
        final translated = localizations?.translate(translationKey!, params);
        if (translated != null && translated.trim().isNotEmpty) {
          return translated;
        }
      }
    } catch (_) {
      // 🔒 Safely ignore localization's errors
    }
    return message.isNotEmpty ? message : 'Something went wrong';
  }

  // 🔁 Method with UI (to use in UI layer)
  String uiMessage(BuildContext context) => uiMessageOrRaw(context);

  /// 📌 Contextual icon for overlay usage (e.g. showError)
  IconData get overlayIcon => switch (this) {
    ApiFailure() => Icons.cloud_off,
    FirebaseFailure() => Icons.fireplace,
    UseCaseFailure() => Icons.settings,
    GenericFailure(:final plugin) => switch (plugin) {
      ErrorPlugin.httpClient => Icons.wifi_off,
      ErrorPlugin.firebase => Icons.fire_extinguisher,
      ErrorPlugin.useCase => Icons.build,
      _ => Icons.error_outline,
    },
    _ => Icons.error_outline,
  };

  ///
}

/// 🧩 [FailureOverlayX] — Adds conversion from [Failure] to [OverlayMessageKey]
//------------------------------------------------------------
extension FailureOverlayX on Failure {
  OverlayMessageKey? toOverlayMessageKey() {
    if (translationKey == null) return null;
    return StaticOverlayMessageKey(translationKey!, fallback: message);
  }

  /// 🪧 Banner overlay for UX-friendly failures
  OverlayRequest overlayThemeBanner(BuildContext context) {
    final key = toOverlayMessageKey();
    return ThemeBannerRequest(
      key?.localize(context) ?? message,
      overlayIcon,
      messageKey: key,
    );
  }
}

 */