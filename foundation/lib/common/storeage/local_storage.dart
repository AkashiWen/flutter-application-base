import 'package:shared_preferences/shared_preferences.dart';

class ALocalStorage {
  static late SharedPreferences _preferences;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool containsKey(String key) {
    return _preferences.containsKey(key);
  }

  static dynamic getValue(String key) {
    return _preferences.get(key);
  }

  static Future<bool> setValue(String key, dynamic value) {
    if (value is bool) {
      return _preferences.setBool(key, value);
    } else if (value is int) {
      return _preferences.setInt(key, value);
    } else if (value is double) {
      return _preferences.setDouble(key, value);
    } else if (value is String) {
      return _preferences.setString(key, value);
    } else if (value is List<String>) {
      return _preferences.setStringList(key, value);
    }
    return Future.value(false);
  }

  static Future<bool> removeValue(String key) {
    return _preferences.remove(key);
  }

  static Future<bool> clear() {
    return _preferences.clear();
  }
}
