import 'package:flutter/material.dart';

/// A function that defines the widget tree to build
/// based on the [controller] value.
typedef PVCWidgetBuilder<T> = Widget Function(
    BuildContext context, T controller, Widget child);
