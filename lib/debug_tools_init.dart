import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/rendering.dart' show debugRepaintRainbowEnabled;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;

import 'core/app_configs/constants/platform_requirements.dart';
import 'core/modules_shared/logging/for_bloc/bloc_observer.dart';

/// 🧪 [IDebugTools] — abstraction for debug and platform support tools.
/// ✅ Allows to configure debug options and validate platform support.

abstract interface class IDebugTools {
  ///------------------------------
  //
  Future<void> validatePlatformSupport();
  //
  void configure();
  //
}

////

////

/// 🧪 [DefaultDebugTools] — production implementation.

final class DefaultDebugTools implements IDebugTools {
  ///----------------------------------------------
  const DefaultDebugTools();

  ///📱 Checks minimum platform support (e.g., Android SDK, IOS version)
  @override
  Future<void> validatePlatformSupport() async {
    //
    debugPrint('🧪 Checking platform requirements...');
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      debugPrint('🧪 Android SDK: ${androidInfo.version.sdkInt}');
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
      debugPrint('🧪 iOS version: $versionStr');

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
    debugPrint('🧪 Platform requirements OK');

    // Add check for Web/other platforms if needed.
  }

  ////

  /// Configures Flutter-specific debug tools.
  @override
  void configure() {
    debugPrint('🧪 Configuring debug tools (Bloc observer, repaint) ...');
    //👁️ Registers Bloc observer for global event tracking
    Bloc.observer = const AppBlocObserver();
    // Controls visual debugging options (e.g., repaint highlighting).
    debugRepaintRainbowEnabled = false;
    debugPrint('🧪 Debug tools configured.');
  }

  //
}
