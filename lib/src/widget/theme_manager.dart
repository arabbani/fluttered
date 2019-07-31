import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/src/config/fluttered_config.dart';
import 'package:fluttered/src/util/prefs.dart';

typedef _ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData theme);

// TODO: Replace SharedPreferences with custom implementation.

/// Dynamically manages the application theme at runtime.
class ThemeManager extends StatefulWidget {
  /// Build a widget tree based on the selected theme.
  ///
  /// Must not be null.
  final _ThemedWidgetBuilder builder;

  /// Dynamically manages the application theme at runtime.
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
  final _prefs = Prefs();
  final _themeStorageKey = 'selectedTheme';

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
    var theme = await _prefs.getString(_themeStorageKey);
    if (theme != null) {
      setTheme(theme);
    }
  }

  /// Set the theme.
  void setTheme(String name) {
    if (selectedThemeName != name) {
      setState(() {
        themeConfig.selectedTheme = name;
      });
      _prefs.setString(_themeStorageKey, name);
    }
  }

  /// Name of the selected theme.
  String get selectedThemeName => themeConfig.selectedTheme;

  ThemeData get _selectedTheme =>
      themeConfig.availableThemes[selectedThemeName];

  @override
  Widget build(BuildContext context) => widget.builder(context, _selectedTheme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      StringProperty('selectedThemeName', selectedThemeName),
    );
    properties.add(
      DiagnosticsProperty('selectedTheme', _selectedTheme),
    );
  }
}
