import 'package:example/src/screen/home_page.dart';
import 'package:example/src/screen/login_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage(title: 'Home'));
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error page'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
