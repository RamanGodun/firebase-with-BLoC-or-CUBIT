import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import '../core/app_configs/constants/platform_requirements.dart';

/// 🛡️ [PlatformValidationUtil] — Util for platform/environment pre-checks.

final class PlatformValidationUtil {
  ///----------------------------
  const PlatformValidationUtil._();

  ///📱 Check minimum platform support (e.g., Android SDK, IOS version)
  /// Throws [UnsupportedError] if platform version is below required.

  static Future<void> run() async {
    //
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < PlatformConstants.minSdkVersion) {
        throw UnsupportedError(
          'Android SDK ${androidInfo.version.sdkInt} is not supported. '
          'Minimum is ${PlatformConstants.minSdkVersion}',
        );
      }
    }

    if (Platform.isIOS) {
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      final versionStr = iosInfo.systemVersion;
      final minIosVersion = PlatformConstants.minIOSMajorVersion;

      // Parse major version numbers (e.g., "14.2" → 14)
      int? major = int.tryParse(versionStr.split('.').first);
      int? requiredMajor = int.tryParse(minIosVersion.split('.').first);

      if (major != null && requiredMajor != null && major < requiredMajor) {
        throw UnsupportedError(
          'iOS version $versionStr is not supported. '
          'Minimum is $minIosVersion',
        );
      }
    }
    // Add check for Web/other platforms, if needed.
  }
}
