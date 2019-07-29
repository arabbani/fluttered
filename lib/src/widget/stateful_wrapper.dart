import 'package:flutter/widgets.dart';

/// A widget that provides [initState], [didUpdateWidget] and [didChangeDependencies]
/// call in a `StatelessWidget`.
///
/// Instead of creating a `StatefulWidget` only to call `initState`,
/// or `didUpdateWidget` or `didChangeDependencies` use `StatefulWrapper`
/// from a `StatelessWidget`.
class StatefulWrapper extends StatefulWidget {
  /// The widget below this widget in the tree.
  ///
  /// Must not be null.
  final Widget child;

  /// Called when this widget is inserted into the tree.
  ///
  /// The framework will call this method exactly once.
  ///
  /// Must not be null.
  final Function initState;

  /// Called widget configuration changes.
  final Function didUpdateWidget;

  /// Called when a dependency of this widget changes.
  final Function didChangeDependencies;

  /// A widget that provides [initState], [didUpdateWidget] and [didChangeDependencies]
  /// call in a stateless widget.
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
    widget.initState?.call();
    super.initState();
  }

  @override
  void didUpdateWidget(StatefulWrapper oldWidget) {
    widget.didUpdateWidget?.call();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    widget.didChangeDependencies?.call();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
