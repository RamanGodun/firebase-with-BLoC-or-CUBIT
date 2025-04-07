/*
!app_config.dart – Глобальні параметри додатку
!У цьому файлі можуть бути:
	•	Назва додатку
	•	Версія додатку
	•	Вимоги до minSdk
	•	Глобальні таймаути
 */

class AppConfig {
  static const String appName = "Firebase with BLoC/Cubit";
  static const String version = "1.0.0";
  static const int minSdkVersion = 24;

  static const Duration requestTimeout = Duration(seconds: 10);
}
