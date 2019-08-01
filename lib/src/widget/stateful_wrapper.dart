import 'package:flutter/widgets.dart';

/// A widget that provides `initState` and `didUpdateWidget`
/// callback in a [StatelessWidget].
///
/// Instead of creating a [StatefulWidget] only to call `initState`,
/// or `didUpdateWidget` use [StatefulWrapper] from a [StatelessWidget].
class StatefulWrapper extends StatefulWidget {
  /// The widget below this widget in the tree.
  ///
  /// Must not be null.
  final Widget child;

  /// Called when this widget is inserted into the tree.
  /// The framework will call this method exactly once.
  ///
  /// See also:
  ///
  ///  * [StatefulWidget.initState]
  final Function initState;

  /// Called when widget configuration changes.
  ///
  /// See also:
  ///
  ///  * [StatefulWidget.didUpdateWidget].
  final Function didUpdateWidget;

  /// Provides `initState` and `didUpdateWidget` callback in
  /// a [StatelessWidget].
  ///
  /// The parameter [child] must not be null. Atleast one of
  /// [initState] and [didUpdateWidget] must be provided.
  const StatefulWrapper({
    Key key,
    @required this.child,
    this.initState,
    this.didUpdateWidget,
  })  : assert(child != null, 'child must not be null'),
        assert(initState != null || didUpdateWidget != null,
            'Atleast one of initState and didUpdateWidget must be provided'),
        super(key: key);

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    super.initState();
    widget.initState?.call();
  }

  @override
  void didUpdateWidget(StatefulWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.didUpdateWidget?.call();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
