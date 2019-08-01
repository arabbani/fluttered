import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttered/src/global/public_instance.dart';

/// Directs user to [homeScreen] or [loginScreen] based on
/// whether user is logged in or not.
class LandingPageManager extends StatelessWidget {
  /// The homepage of the application.
  ///
  /// Must not be null.
  final Widget homeScreen;

  /// The persistence storage `key` used to store whether
  /// user is logged in. Use the same key throughout your
  /// application.
  final String loggedInKey;

  /// The login screen.
  final Widget loginScreen;

  /// Directs user to [homeScreen] or [loginScreen] based on
  /// whether user is logged in or not.
  LandingPageManager({
    Key key,
    @required this.homeScreen,
    @required this.loggedInKey,
    @required this.loginScreen,
  })  : assert(homeScreen != null, 'homeScreen must not be null'),
        assert(loggedInKey != null, 'loggedInKey must not be null'),
        assert(loginScreen != null, 'loginScreen must not be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var loggedIn = sharedPrefsServiceInstance.get(loggedInKey) ?? false;
    return !loggedIn ? loginScreen : homeScreen;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('loggedInKey', loggedInKey));
  }
}
