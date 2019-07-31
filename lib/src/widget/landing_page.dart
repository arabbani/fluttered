import 'package:flutter/widgets.dart';
import 'package:fluttered/src/global/public_instance.dart';

/// Directs user to [homeScreen] or [loginScreen] based on
/// whether user is logged in or not.
class LandingPage extends StatelessWidget {
  // final _prefs = Prefs();

  /// The homepage of the application.
  ///
  /// Must not be null.
  final Widget homeScreen;

  /// Whether login is required to access the application.
  final bool requireLogin;

  /// The persistence storage `key` used to store whether
  /// user is logged in.
  final String loggedInKey;

  /// The login screen.
  final Widget loginScreen;

  LandingPage({
    Key key,
    @required this.homeScreen,
    @required this.requireLogin,
    this.loggedInKey,
    this.loginScreen,
  })  : assert(
          !requireLogin || (loggedInKey != null && loginScreen != null),
          'loggedInKey and loginScreen must be provided when requireLogin = true',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) => _getLandingScreen();

  Widget _getLandingScreen() {
    if (requireLogin) {
      var loggedIn = sharedPrefsServiceInstance.get(loggedInKey) ?? false;
      if (!loggedIn) {
        return loginScreen;
      }
    }
    return homeScreen;
  }
}
