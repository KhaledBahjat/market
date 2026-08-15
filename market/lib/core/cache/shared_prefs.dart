import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // =========================
  // String
  // =========================

  static Future<bool> setString(
    String key,
    String value,
  ) async {
    return await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  // =========================
  // Bool
  // =========================

  static Future<bool> setBool(
    String key,
    bool value,
  ) async {
    return await _prefs.setBool(key, value);
  }

  static bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  // =========================
  // Int
  // =========================

  static Future<bool> setInt(
    String key,
    int value,
  ) async {
    return await _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // =========================
  // Double
  // =========================

  static Future<bool> setDouble(
    String key,
    double value,
  ) async {
    return await _prefs.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // =========================
  // Remove
  // =========================

  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // =========================
  // Clear
  // =========================

  static Future<bool> clear() async {
    return await _prefs.clear();
  }

  // =========================
  // Check if key exists
  // =========================

  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
