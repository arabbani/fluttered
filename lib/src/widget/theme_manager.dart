import 'package:flutter/material.dart';
import 'package:fluttered/src/config/theme_config.dart';

typedef _ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData themeData);

class ThemeManager extends StatefulWidget {
  /// Build a widget tree based on the [themeData].
  ///
  /// Must not be null.
  final _ThemedWidgetBuilder builder;

  const ThemeManager({Key key, @required this.builder})
      : assert(builder != null, 'child must not be null'),
        super(key: key);

  @override
  ThemeManagerState createState() => ThemeManagerState();

  static ThemeManagerState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<ThemeManager>());
  }
}

class ThemeManagerState extends State<ThemeManager> {
  ThemeData _theme;

  @override
  void initState() {
    setTheme(themeConfig.defaultTheme);
    super.initState();
  }

  void setTheme(String name) {
    setState(() {
      _theme = themeConfig.availableThemes[name];
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _theme);
  }
}
