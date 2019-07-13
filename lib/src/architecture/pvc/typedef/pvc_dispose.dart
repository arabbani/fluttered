import 'package:flutter/material.dart';

/// A function that defines the callback, executed when
/// the widget is removed from the widget tree.
typedef PvcDispose<T> = Widget Function(BuildContext context, T controller);
