import 'package:flutter/material.dart';

/// Configures the application theme.
class ThemeConfig {
  /// A `Map` containing the name of the theme and the corresponding [ThemeData].
  /// [ThemeManager] will switch between these themes whenever necessary.
  final Map<String, ThemeData> availableThemes;

  /// Name of the default theme.
  String selectedTheme;

  /// Configures the application theme.
  ThemeConfig({
    @required this.availableThemes,
    @required var defaultTheme,
  })  : assert(availableThemes != null, 'availableThemes must not be null'),
        assert(defaultTheme != null, 'defaultTheme must not be null'),
        selectedTheme = defaultTheme;
}
