import 'package:example/src/screen/home_page.dart';
import 'package:example/src/screen/login_page.dart';
import 'package:example/src/util/route_generator.dart';
import 'package:example/src/util/storage_key.dart';
import 'package:example/src/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/fluttered.dart';

void main() async {
  await flutteredConfig();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LifecycleManager(
      onPaused: () => print('PAUSED'),
      onResumed: () => print('RESUMED'),
      child: ThemeManager(
        availableThemes: availableThemes,
        defaultTheme: defaultTheme,
        builder: (context, theme) => MaterialApp(
          title: 'Fluttered',
          theme: theme,
          onGenerateRoute: RouteGenerator.generateRoute,
          home: LandingPageManager(
            homeScreen: HomePage(title: 'Home'),
            loggedInKey: loggedInKey,
            loginScreen: LoginPage(),
          ),
        ),
      ),
    );
  }
}
