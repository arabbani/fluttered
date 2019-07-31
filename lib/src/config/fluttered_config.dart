import 'package:fluttered/src/global/public_instance.dart';
import 'package:fluttered/src/service/shared_prefs_service.dart';

/// Set Global configurations for fluttered.
Future<void> flutteredConfig() async {
  // Manadatory
  sharedPrefsServiceInstance = await SharedPrefsService.instance();
}
