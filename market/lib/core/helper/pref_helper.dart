import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  PrefHelper() : _prefsFuture = SharedPreferences.getInstance();

  final Future<SharedPreferences> _prefsFuture;

  // set User data
  Future<void> setUserData(String key, String value) async {
    final prefs = await _prefsFuture;
    await prefs.setString(key, value);
  }

  // get User data
  Future<String?> getUserData(String key) async {
    final prefs = await _prefsFuture;
    return prefs.getString(key);
  }
}