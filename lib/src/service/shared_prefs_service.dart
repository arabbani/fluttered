import 'package:shared_preferences/shared_preferences.dart';

/// Manage the persistent storage. Used to store simple data
/// as key-value pair.
class SharedPrefsService {
  static SharedPrefsService _singleton;
  static SharedPreferences _preferences;

  /// Get an instance of this service.
  static Future<SharedPrefsService> instance() async {
    if (_singleton == null) {
      _singleton = SharedPrefsService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _singleton;
  }

  /// Saves the [value] to persistent storage.
  ///
  /// If [value] is null, this wil remove the [key] entry from persistent storage.
  ///
  /// Supported [value] types: [int], [double], [String], [bool] and [List<String>],
  Future<bool> set<T>(String key, T value) async {
    print(
        '(TRACE) Fluttered_SharedPrefsService:: set() => key: $key, value: $value');
    bool success;
    if (value is int) {
      success = await _preferences.setInt(key, value);
    } else if (value is double) {
      success = await _preferences.setDouble(key, value);
    } else if (value is String) {
      success = await _preferences.setString(key, value);
    } else if (value is bool) {
      success = await _preferences.setBool(key, value);
    } else if (value is List<String>) {
      success = await _preferences.setStringList(key, value);
    } else {
      assert(false,
          '(ERROR) Fluttered_SharedPrefsService:: set() => unsupported value type');
    }
    if (!success) {
      assert(false,
          '(ERROR) Fluttered_SharedPrefsService:: set() => unable to store key: $key, value: $value');
    }
    return success;
  }

  dynamic get(String key) => _preferences.get(key);

  /// Removes an entry from persistent storage.
  Future<bool> remove(String key) async {
    print('(TRACE) Fluttered_SharedPrefsService:: remove() => key: $key');
    var removed = await _preferences.remove(key);
    if (!removed) {
      assert(false,
          '(ERROR) Fluttered_SharedPrefsService:: remove() => unable to remove key: $key');
    }
    return removed;
  }

  /// Clear the persistent storage.
  Future<bool> clear() => _preferences.clear();
}
