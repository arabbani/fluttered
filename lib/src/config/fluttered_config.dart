import 'package:fluttered/src/config/private_instances.dart';
import 'package:fluttered/src/config/theme_config.dart';
import 'package:fluttered/src/service/shared_prefs_service.dart';

ThemeConfig themeConfig;

/// Set Global configurations for fluttered.
void flutteredConfig({
  ThemeConfig theme,
  bool configureSharedPreferences = false,
}) async {
  themeConfig = theme;

  if (configureSharedPreferences) {
    sharedPrefsServiceInstance = await SharedPrefsService.instance();
  }
}
