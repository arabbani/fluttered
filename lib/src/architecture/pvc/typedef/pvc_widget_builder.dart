import 'package:flutter/material.dart';

typedef PVCWidgetBuilder<T> = Widget Function(
    BuildContext context, T controller, Widget child);
