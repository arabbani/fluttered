import 'package:flutter/material.dart';
import 'package:fluttered/src/config/theme_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef _ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData theme);

// TODO: Replace SharedPreferences with custom implementation.

/// Manages the app theme.
class ThemeManager extends StatefulWidget {
  /// Build a widget tree based on the selected [_theme].
  ///
  /// Must not be null.
  final _ThemedWidgetBuilder builder;

  /// Manages the app theme.
  ///
  /// The parameter `builder` must not be null.
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
  String _theme;

  @override
  void initState() {
    super.initState();
    assert(themeConfig != null,
        'themeConfig cannot be null. See docs how to config ThemeManager');
    if (mounted) {
      _initTheme();
    }
  }

  _initTheme() async {
    _theme = await _getThemePref() ?? themeConfig.defaultTheme;
    setState(() {});
    _setThemePref(_theme);
  }

  /// Set the theme.
  void setTheme(String name) {
    if (_theme != name) {
      setState(() {
        _theme = name;
      });
    }
    _setThemePref(name);
  }

  Future<String> _getThemePref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme');
  }

  void _setThemePref(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', name);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      themeConfig.getTheme(_theme),
    );
  }
}
