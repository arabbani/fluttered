import 'package:fluttered/src/global/private_instance.dart';
import 'package:fluttered/src/global/public_instance.dart';
import 'package:fluttered/src/model/theme_config.dart';
import 'package:fluttered/src/service/shared_prefs_service.dart';

/// Set Global configurations for fluttered.
Future<void> flutteredConfig({
  ThemeConfig theme,
  bool configureSharedPreferences = false,
}) async {
  themeConfig = theme;
  if (configureSharedPreferences) {
    sharedPrefsServiceInstance = await SharedPrefsService.instance();
  }
}
