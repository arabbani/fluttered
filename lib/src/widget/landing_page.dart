import 'package:flutter/widgets.dart';

class LandingPage extends StatelessWidget {
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

  const LandingPage({
    Key key,
    @required this.homeScreen,
    @required this.requireLogin,
    this.loggedInKey,
    this.loginScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
