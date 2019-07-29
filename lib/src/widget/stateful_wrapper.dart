import 'package:flutter/widgets.dart';

/// A widget that provides [initState] call in a `StatelessWidget`.
///
/// Instead of creating a `StatefulWidget` only to call `initState`,
/// use `StatefulWrapper` from a `StatelessWidget`.
class StatefulWrapper extends StatefulWidget {
  /// Called when this widget is inserted into the tree.
  ///
  /// The framework will call this method exactly once.
  ///
  /// Must not be null.
  final Function onInit;

  /// The widget below this widget in the tree.
  ///
  /// Must not be null.
  final Widget child;

  /// A widget that provides [initState] call in a stateless widget.
  const StatefulWrapper({
    Key key,
    @required this.onInit,
    @required this.child,
  })  : assert(onInit != null, 'onInit must not be null'),
        assert(child != null, 'child must not be null'),
        super(key: key);

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
