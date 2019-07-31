import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/src/global/public_instance.dart';

typedef _ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData theme);

/// Dynamically manages the application theme at runtime.
class ThemeManager extends StatefulWidget {
  /// Available themes of this application.
  ///
  /// A `Map` containing the name of the theme and the corresponding [ThemeData].
  ///
  /// [ThemeManager] will switch between these themes whenever necessary.
  final Map<String, ThemeData> availableThemes;

  /// Name of the default theme.
  final String defaultTheme;

  /// Build a widget tree based on the selected theme.
  ///
  /// Must not be null.
  final _ThemedWidgetBuilder builder;

  /// Dynamically manages the application theme at runtime.
  ThemeManager({
    Key key,
    @required this.availableThemes,
    @required this.defaultTheme,
    @required this.builder,
  })  : assert(availableThemes != null, 'availableThemes must not be null'),
        assert(defaultTheme != null, 'defaultTheme must not be null'),
        assert(builder != null, 'child must not be null'),
        super(key: key);

  @override
  ThemeManagerState createState() => ThemeManagerState();

  static ThemeManagerState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<ThemeManagerState>());
  }
}

class ThemeManagerState extends State<ThemeManager> {
  final _themeStorageKey = 'selectedTheme';
  String _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = sharedPrefsServiceInstance.get(_themeStorageKey);
    if (_selectedTheme == null) {
      _storeSelectedThemeName(widget.defaultTheme);
      _selectedTheme = widget.defaultTheme;
    }
  }

  /// Set the theme.
  void setTheme(String name) {
    if (_selectedTheme != name) {
      setState(() {
        _selectedTheme = name;
      });
      _storeSelectedThemeName(name);
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, widget.availableThemes[_selectedTheme]);

  void _storeSelectedThemeName(String theme) =>
      sharedPrefsServiceInstance.set(_themeStorageKey, theme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      StringProperty('selectedThemeName', _selectedTheme),
    );
    properties.add(
      DiagnosticsProperty(
          'selectedTheme', widget.availableThemes[_selectedTheme]),
    );
  }
}
