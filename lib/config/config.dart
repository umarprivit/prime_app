import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
// import 'package:device_info_plus/device_info_plus.dart';

class Config {
  static const String FONT_FAMILY = 'Kumbh Sans';
  static const Color GREY_COLOR = Color.fromRGBO(82, 82, 82, 1);
  static const Color GREY_COLOR_40 = Color.fromRGBO(82, 82, 82, 0.4);

  // Future<String?> getDeviceId() async {
  //   final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     return androidInfo.id; // Unique device ID
  //   } else if (Platform.isIOS) {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     return iosInfo.identifierForVendor; // Unique ID for iOS devices
  //   }
  //   return "unknown_device";
  // }
  Future<String> getDeviceId() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('deviceId');

    if (deviceId == null) {
      print("_______________________________________________________________________UUID RANN");
      var uuid = Uuid();
      deviceId = uuid.v4(); // Generate a new UUID
      await prefs.setString(
          'deviceId', deviceId); // Store it locally for future use
    }

    return deviceId!;
  }

// Future<String?> getDeviceId() async {
//   try {
//     // Use Firebase Installation ID (unique per app install)
//     return await FirebaseInstallations.id;
//   } catch (e) {
//     debugPrint("Error getting Firebase ID: $e");
//     throw Exception("Failed to get unique device ID");
//   }
// }
}
