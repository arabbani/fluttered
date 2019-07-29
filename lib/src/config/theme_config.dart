import 'package:flutter/material.dart';

/// Configures the app theme.
class ThemeConfig {
  /// A `Map` containing the name of the theme and the corresponding [ThemeData].
  /// [ThemeManager] will switch between these themes whenever necessary.
  final Map<String, ThemeData> availableThemes;

  /// Name of the default theme.
  String selectedTheme;

  /// Configures the app theme.
  ThemeConfig(
    this.availableThemes,
    this.selectedTheme,
  )   : assert(availableThemes != null, 'availableThemes must not be null'),
        assert(selectedTheme != null, 'defaultTheme must not be null');

  // set theme(String theme) => _currentTheme = theme;

  ThemeData getTheme() => availableThemes[selectedTheme];
}

ThemeConfig themeConfig;
