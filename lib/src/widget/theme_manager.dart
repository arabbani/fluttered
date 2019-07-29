import 'package:flutter/material.dart';
import 'package:fluttered/src/config/theme_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef _ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData theme);

class ThemeManager extends StatefulWidget {
  /// Build a widget tree based on the selected [theme].
  ///
  /// Must not be null.
  final _ThemedWidgetBuilder builder;

  /// Manages the app theme.
  const ThemeManager({Key key, @required this.builder})
      : assert(builder != null, 'child must not be null'),
        super(key: key);

  @override
  ThemeManagerState createState() => ThemeManagerState();

  static ThemeManagerState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<ThemeManagerState>());
  }
}

class ThemeManagerState extends State<ThemeManager> {
  ThemeData _theme;

  @override
  void initState() {
    assert(themeConfig != null,
        'themeConfig cannot be null. See docs how to config ThemeManager');
    initTheme();
    super.initState();
  }

  initTheme() async {
    var theme = await getThemePref();
    setTheme(theme ?? themeConfig.defaultTheme);
  }

  /// Set the theme named `name`
  void setTheme(String name) {
    setState(() {
      _theme = themeConfig.availableThemes[name];
    });
    setThemePref(name);
  }

  Future<String> getThemePref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme');
  }

  void setThemePref(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', name);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _theme);
  }
}
