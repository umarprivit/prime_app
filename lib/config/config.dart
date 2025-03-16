import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';

class Config {
  static const String FONT_FAMILY = 'Kumbh Sans';
  static const Color GREY_COLOR = Color.fromRGBO(82, 82, 82, 1);
  static const Color GREY_COLOR_40 = Color.fromRGBO(82, 82, 82, 0.4);

  Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Unique device ID
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // Unique ID for iOS devices
    }
    return "unknown_device";
  }
}
