/*
!app_config.dart – Глобальні параметри додатку
!У цьому файлі можуть бути:
	•	Назва додатку
	•	Версія додатку
	•	Вимоги до minSdk
	•	Глобальні таймаути
 */

class AppConfig {
  static const String appName = "ToDo on Riverpod";
  static const String version = "1.0.0";
  static const int minSdkVersion = 23;

  static const Duration requestTimeout = Duration(seconds: 10);
}
