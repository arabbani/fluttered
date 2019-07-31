import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPrefs _instance;
  static SharedPreferences _preferences;

  static Future<SharedPrefs> getInstance() async {
    if (_instance == null) {
      _instance = SharedPrefs();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }
}
