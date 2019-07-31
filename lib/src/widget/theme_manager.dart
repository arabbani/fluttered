import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/src/global/private_instance.dart';
import 'package:fluttered/src/global/public_instance.dart';

typedef _ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData theme);

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
  final _themeStorageKey = 'selectedTheme';

  @override
  void initState() {
    super.initState();
    assert(themeConfig != null,
        'themeConfig cannot be null. See docs how to config ThemeManager');
    if (mounted) {
      var theme = sharedPrefsServiceInstance.get(_themeStorageKey);
      if (theme != null) {
        if (selectedThemeName != theme) {
          _setSelectedTheme(theme);
        }
      } else {
        _storeThemeName(selectedThemeName);
      }
    }
  }

  void _setSelectedTheme(String name) {
    setState(() {
      themeConfig.selectedTheme = name;
    });
  }

  /// Set the theme.
  void setTheme(String name) {
    if (selectedThemeName != name) {
      _setSelectedTheme(name);
      _storeThemeName(name);
    }
  }

  /// Name of the selected theme.
  String get selectedThemeName => themeConfig.selectedTheme;

  void _storeThemeName(String theme) =>
      sharedPrefsServiceInstance.set(_themeStorageKey, theme);

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
