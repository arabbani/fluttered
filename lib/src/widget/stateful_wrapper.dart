import 'package:flutter/widgets.dart';

/// A widget that provides [initState] call in a stateless widget.
class StatefulWrapper extends StatefulWidget {
  // Called when this object is inserted into the tree.
  ///
  /// The framework will call this method exactly once for each [State] object
  /// it creates.
  ///
  /// {@macro flutter.widgets.subscriptions}
  final Function onInit;

  /// The widget below this widget in the tree.
  final Widget child;

  /// A widget that provides [initState] call in a stateless widget.
  const StatefulWrapper({
    Key key,
    @required this.child,
    @required this.onInit,
  })  : assert(child != null, 'child must not be null'),
        assert(onInit != null, 'onInit must not be null'),
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
