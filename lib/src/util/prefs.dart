import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  SharedPreferences instance;

  Future<SharedPreferences> _getInstance() async {
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
    prefs.setString(key, value);
  }
}
