import 'package:shared_preferences/shared_preferences.dart';

/// Manage the persistent storage. Used to store simple data
/// as key-value pair.
class SharedPrefsService {
  static SharedPrefsService _instance;
  static SharedPreferences _preferences;

  static Future<SharedPrefsService> getInstance() async {
    if (_instance == null) {
      _instance = SharedPrefsService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  /// Saves the [value] to persistent storage.
  ///
  /// If [value] is null, this wil remove the [key] entry from persistent storage.
  ///
  /// Supported [value] types: `int`, `double`, `String`, `bool` and `List<String>`,
  void set<T>(String key, T value) {
    if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is String) {
      _preferences.setString(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    } else {
      assert(false,
          '(ERROR) Fluttered_SharedPrefsService:: set() => unsupported value type');
    }
    print(
        '(TRACE) Fluttered_SharedPrefsService:: set() => key: $key value: $value');
  }

  T get<T>(String key) {
    return _preferences.get(key);
  }
}
