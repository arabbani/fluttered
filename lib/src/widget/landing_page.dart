import 'package:flutter/widgets.dart';

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
          'loggedInKey and loginScreen mustr be provided when requireLogin = true',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) => _getLandingScreen();

  Widget _getLandingScreen() {
    return homeScreen;
    // if (!requireLogin) {
    // }
    // var loggedIn = await _prefs.getBool(loggedInKey);
  }
}
