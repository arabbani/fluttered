import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/src/global/private_instance.dart';
import 'package:fluttered/src/global/public_instance.dart';

typedef _ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData theme);

/// Dynamically manages the application theme at runtime.
class ThemeManager extends StatefulWidget {
  /// Available themes of this application.
  ///
  /// A [Map] containing the name of the theme and the corresponding [ThemeData].
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
  _ThemeManagerState createState() => _ThemeManagerState();

  static _ThemeManagerState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<_ThemeManagerState>());
  }
}

class _ThemeManagerState extends State<ThemeManager> {
  final _themeNamePersistentKey = '${persistentStoreKeyPrefix}SelectedTheme';

  /// Currently selected theme.
  String selectedTheme;

  @override
  void initState() {
    super.initState();
    selectedTheme = sharedPrefsServiceInstance.get(_themeNamePersistentKey);
    if (selectedTheme == null) {
      selectedTheme = widget.defaultTheme;
      _storeSelectedThemeName(widget.defaultTheme);
    }
  }

  /// Set the theme. [setTheme] will call [setState] to rebuild the UI.
  void setTheme(String name) {
    if (selectedTheme != name) {
      setState(() {
        selectedTheme = name;
      });
      _storeSelectedThemeName(name);
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, widget.availableThemes[selectedTheme]);

  void _storeSelectedThemeName(String theme) =>
      sharedPrefsServiceInstance.set(_themeNamePersistentKey, theme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('selectedThemeName', selectedTheme));
    properties.add(DiagnosticsProperty(
        'selectedThemeData', widget.availableThemes[selectedTheme]));
  }
}
