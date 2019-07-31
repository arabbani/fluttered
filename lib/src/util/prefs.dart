import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences instance;

  static Future<SharedPreferences> _getInstance() async {
    if (instance == null) {
      instance = await SharedPreferences.getInstance();
    }
    return instance;
  }

  Future<String> getString(String key) async {
    var prefs = await _getInstance();
    return prefs.getString(key);
  }

  void setString(String key, String value) async {
    var prefs = await _getInstance();
    var t = await prefs.setString(key, value);
    print(t.toString());
  }

  Future<bool> getBool(String key) async {
    var prefs = await _getInstance();
    return prefs.getBool(key);
  }

  void setBool(String key, bool value) async {
    var prefs = await _getInstance();
    prefs.setBool(key, value);
  }
}
