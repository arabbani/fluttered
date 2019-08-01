import 'package:flutter/material.dart';

/// Get the size of the screen.
Size screenSize(BuildContext context) => MediaQuery.of(context).size;

/// Calculate the height based on the screen height.
///
/// This method divides the screen height into [split] equal parts,
/// and assign [take] parts to the widget.
///
/// For example, if you want your widget to takes 2/3rd of the
/// screen height, use the method as below:
///
/// ```dart
/// calculateHeight(context, split = 3, take = 2);
/// ```
///
/// If there exists a toolbar, and you want to exclude the toolbar
/// height from the screen height, pass `excludeToolbar = true`.
double calculateHeight(
  BuildContext context, {
  double split = 2,
  double take = 1,
  bool excludeToolbar = false,
}) {
  double screenHeight = screenSize(context).height;
  if (excludeToolbar) screenHeight -= kToolbarHeight;
  return screenHeight / (split - take);
}

/// Calculate the width based on the screen width.
///
/// This method divides the screen width into [split] equal parts,
/// and assign [take] parts to the widget.
///
/// For example, if you want your widget to take 3/4th of the
/// screen width, use the method as below:
///
/// ```dart
/// calculateHeight(context, split = 4, take = 3);
/// ```
///
double calculateWidth(
  BuildContext context, {
  double split = 2,
  double take = 1,
}) =>
    screenSize(context).width / (split - take);
