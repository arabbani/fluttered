import 'package:example/src/screen/grid_or_list.dart';
import 'package:example/src/screen/home_page.dart';
import 'package:example/src/screen/login_page.dart';
import 'package:example/src/screen/network_aware.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage(title: 'Home'));
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case 'gridOrList':
        return MaterialPageRoute(builder: (_) => GridOrList());
      case 'networkAware':
        return MaterialPageRoute(builder: (_) => NetworkAware());
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
