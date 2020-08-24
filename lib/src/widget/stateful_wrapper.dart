import 'package:flutter/widgets.dart';

/// A widget that provides [StatefulWidget.initState],
/// [StatefulWidget.didUpdateWidget] and [StatefulWidget.dispose]
/// callback in a [StatelessWidget].
///
/// Instead of creating a [StatefulWidget] only to call `initState`,
/// or `didUpdateWidget` or `dispose` use [StatefulWrapper] from a
/// [StatelessWidget].
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

  /// Called when this object is removed from the tree permanently.
  ///
  /// See also:
  ///
  ///  * [StatefulWidget.dispose].
  final Function dispose;

  /// Provides [StatefulWidget.initState], [StatefulWidget.didUpdateWidget]
  /// and [StatefulWidget.dispose] callback in a [StatelessWidget].
  ///
  /// The parameter [child] must not be null. Atleast one of
  /// [initState], [didUpdateWidget] and [dispose] must be provided.
  const StatefulWrapper({
    Key key,
    this.initState,
    this.didUpdateWidget,
    this.dispose,
    @required this.child,
  })  : assert(child != null, 'child must not be null'),
        assert(initState != null || didUpdateWidget != null || dispose != null,
            'Atleast one of initState, didUpdateWidget and dispose must be provided'),
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
  void dispose() {
    super.dispose();
    widget.dispose?.call();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
