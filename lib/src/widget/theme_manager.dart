import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttered/src/widget/pvc.dart';

class _ThemeController extends ChangeNotifier {}

class ThemeManager extends StatelessWidget {
  /// The widget below this widget in the tree.
  ///
  /// Must not be null.
  final MaterialApp child;

  const ThemeManager({Key key, this.child})
      : assert(child != null, 'child must not be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MutablePVC(
      controller: _ThemeController(),
      builder: (context, controller, _) {
        child.
      },
    );
  }
}
