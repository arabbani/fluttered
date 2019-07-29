import 'package:flutter/material.dart';

class ThemeConfig {
  /// A `Map` containing the name of the theme and the corresponding [ThemeData].
  /// [ThemeManager] will switch between these themes whenever necessary.
  final Map<String, ThemeData> availableThemes;

  /// Name of the default theme.
  final String defaultTheme;

  /// Configures the themes to use.
  ThemeConfig(
    this.availableThemes,
    this.defaultTheme,
  )   : assert(availableThemes != null, 'availableThemes must not be null'),
        assert(defaultTheme != null, 'defaultTheme must not be null');
}

ThemeConfig themeConfig;
