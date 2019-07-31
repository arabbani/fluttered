import 'package:example/src/screen/home_page.dart';
import 'package:example/src/screen/login_page.dart';
import 'package:example/src/util/route_generator.dart';
import 'package:example/src/util/storage_key.dart';
import 'package:example/src/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/fluttered.dart';

void main() async {
  await flutteredConfig(
    theme: ThemeConfig(
      availableThemes: availableThemes,
      defaultTheme: defaultTheme,
    ),
    configureSharedPreferences: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LifecycleManager(
      onPaused: () => print('PAUSED'),
      onResumed: () => print('RESUMED'),
      child: ThemeManager(
        builder: (context, theme) => MaterialApp(
          title: 'Fluttered',
          theme: theme,
          onGenerateRoute: RouteGenerator.generateRoute,
          home: LandingPage(
            homeScreen: HomePage(title: 'Fluttered'),
            requireLogin: true,
            loggedInKey: loggedInKey,
            loginScreen: LoginPage(),
          ),
        ),
      ),
    );
  }
}
