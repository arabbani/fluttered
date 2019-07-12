import 'package:flutter/material.dart';

typedef PVCProviderBuilder<T> = Widget Function(
    BuildContext context, T controller, Widget child);
