import 'package:flutter/widgets.dart';

/// A widget that provides [initState], [didUpdateWidget] and
/// [didChangeDependencies] call in a `StatelessWidget`.
///
/// Instead of creating a `StatefulWidget` only to call
/// `initState`, or `didUpdateWidget` or `didChangeDependencies`
/// use `StatefulWrapper` from a `StatelessWidget`.
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

  /// Called when a dependency of this widget changes.
  ///
  /// See also:
  ///
  ///  * [StatefulWidget.didChangeDependencies].
  final Function didChangeDependencies;

  /// A widget that provides [initState], [didUpdateWidget] and
  /// [didChangeDependencies] call in a stateless widget.
  ///
  /// The parameter `child` must not be null.
  StatefulWrapper({
    Key key,
    @required this.child,
    this.initState,
    this.didUpdateWidget,
    this.didChangeDependencies,
  })  : assert(child != null, 'child must not be null'),
        super(key: key) {
    if (this.initState == null &&
        this.didUpdateWidget == null &&
        this.didChangeDependencies == null) {
      assert(
        false,
        'Atleast one of initState, didUpdateWidget and didChangeDependencies must be provided',
      );
    }
  }

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
