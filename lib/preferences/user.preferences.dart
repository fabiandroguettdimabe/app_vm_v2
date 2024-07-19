import 'package:app_vm/features/auth/domain/login.dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<SharedPreferences?> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future set(String key, dynamic value) async {
    var prefs = await _instance;
    if (value is int) {
      await prefs!.setInt(key, value);
    } else if (value is String) {
      await prefs!.setString(key, value);
    } else if (value is bool) {
      await prefs!.setBool(key, value);
    } else if (value is List<String>) {
      await prefs!.setStringList(key, value);
    }
  }

  static Future<dynamic> get(String key) async {
    var prefs = await _instance;
    return prefs!.get(key);
  }

  static Future<int?> getInt(String key) async {
    var prefs = await _instance;
    return prefs!.getInt(key);
  }

  static Future<String?> getString(String key) async {
    var prefs = await _instance;
    return prefs!.getString(key);
  }

  static Future<bool?> getBool(String key) async {
    var prefs = await _instance;
    return prefs!.getBool(key);
  }

  static Future<List<String>?> getStringList(String key) async {
    var prefs = await _instance;
    return prefs!.getStringList(key);
  }

  static Future remove(String key) async {
    var prefs = await _instance;
    await prefs!.remove(key);
  }

  static Future clear() async {
    var prefs = await _instance;
    await prefs!.clear();
  }

  static Future login(LoginResponseDto? model) async {
    try {
      if (model == null) return;
      var data = {
        'token': model.accessToken,
        'refreshToken': model.refreshToken,
        'userId': model.userId,
        'userName': model.userName,
        'userEmail': model.userEmail,
        'userFullName': model.userFullName,
      };
      for (var entry in data.entries) {
        await set(entry.key, entry.value);
      }
    } catch (e) {
      print('Error setting login: $e');
    }
  }

  getStringSync(String key) {
    return _prefsInstance?.getString(key);
  }

  getIntSync(String key) {
    return _prefsInstance?.getInt(key);
  }

  getBoolSync(String key) {
    return _prefsInstance?.getBool(key);
  }

  getListStringSync(String key) {
    return _prefsInstance?.getStringList(key);
  }
}
