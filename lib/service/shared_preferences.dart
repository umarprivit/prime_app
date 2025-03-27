import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  // Singleton instance
  static final SharedPrefService _instance = SharedPrefService._internal();
  factory SharedPrefService() => _instance;
  SharedPrefService._internal();

  static SharedPreferences? _prefs;

  // Keys
  static const String _isGuestKey = "isGuest";
  static const String _isLoggedInKey = "isLoggedIn";
  static const String _deviceIdKey = "deviceId";

  // Initialize SharedPreferences (Call this in main.dart before using)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Setters
  Future<void> setIsGuest(bool value) async {
    await _prefs?.setBool(_isGuestKey, value);
  }

  Future<void> setIsLoggedIn(bool value) async {
    await _prefs?.setBool(_isLoggedInKey, value);
  }

  Future<void> setDeviceId(String id) async {
    await _prefs?.setString(_deviceIdKey, id);
  }

  // Getters
  bool getIsGuest() => _prefs?.getBool(_isGuestKey) ?? false;

  bool getIsLoggedIn() => _prefs?.getBool(_isLoggedInKey) ?? false;

  String? getDeviceId() => _prefs?.getString(_deviceIdKey) ?? "";

  // Clear all stored data (optional utility method)
  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
