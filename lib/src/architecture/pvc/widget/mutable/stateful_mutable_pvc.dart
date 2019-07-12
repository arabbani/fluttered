import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_provider_builder.dart';

/// Create a [StatefulWidget] using [ChangeNotifierProvider]. The widget rebuild
/// itself whenever the [controller] calls [ChangeNotifier.notifyListeners].
class StatefulMutablePVC<T extends ChangeNotifier> extends StatefulWidget {
  /// The controller for this view. Controller manages the data needed
  /// to build the view.
  ///
  /// Must implement [ChangeNotifier], and handle the state of the view by calling
  /// [ChangeNotifier.notifyListeners].
  final T controller;

  /// Build a widget tree based on the [controller] value. The widget rebuild itself
  /// whenever the [controller] changes its state by calling [ChangeNotifier.notifyListeners].
  ///
  /// Must not be null.
  final PVCProviderBuilder<T> builder;

  /// The child widget to pass to [builder].
  ///
  /// If a builder callback's return value contains a subtree that does not depend on
  /// the [controller], it's more efficient to build that subtree once instead of
  /// rebuilding it on every change of the [controller].
  ///
  /// If the pre-built subtree is passed as the child parameter, [StatefulMutablePVC]
  /// will pass it back to the builder function so that it can be incorporated into the build.
  ///
  /// Using this pre-built child is entirely optional, but can improve performance
  /// significantly in some cases.
  final Widget child;

  /// Called when this object is inserted into the tree. This method is used to perform some
  /// initialization logic in the controller, if needed.
  ///
  /// The framework will call this method exactly once for each [StatefulMutablePVC] object
  /// it creates.
  final Function(T controller) onModelReady;

  /// Create a [StatefulWidget] using [ChangeNotifierProvider], and bind the [controller] to it.
  /// The state of the widget is maintained by the [controller].
  ///
  /// `StatefulMutablePVC` rebuild itself whenever the [controller] calls [ChangeNotifier.notifyListeners].
  ///
  /// If the entire widget tree returned by the builder callback does not depend on the [controller],
  /// use [StatelessImmutablePVC] or [StatefulImmutablePVC] instead.
  ///
  /// [onModelReady] is called when this widget is inserted into the tree.  This method is used to
  /// perform some initialization logic in the controller, if needed.The framework
  /// will call this method exactly once for each [StatefulMutablePVC] object it creates.
  StatefulMutablePVC({
    Key key,
    @required this.controller,
    @required this.builder,
    @required this.onModelReady,
    this.child,
  })  : assert(controller != null, 'The \'controller\' must not be null.'),
        assert(builder != null, 'The \'builder\' must not be null.'),
        assert(onModelReady != null, '\'onModelReady\' must not be null.'),
        super(key: key);

  @override
  _StatefulMutablePVCState createState() => _StatefulMutablePVCState<T>();
}

class _StatefulMutablePVCState<T extends ChangeNotifier>
    extends State<StatefulMutablePVC<T>> {
  @override
  void initState() {
    widget.onModelReady(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => widget.controller,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
