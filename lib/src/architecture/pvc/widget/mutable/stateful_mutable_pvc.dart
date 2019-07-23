import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_on_model_ready.dart';
import '../../typedef/pvc_widget_builder.dart';

/// `StatefulMutablePvc` rebuild itself whenever the [controller] value changes.
///
/// It will automatically dispose the [controller] when this widget is removed
/// from the widget tree.
///
/// If the entire widget tree returned by the [builder] callback does not rebuild
/// when the [controller] value changes, use [StatelessImmutablePvc] or [StatefulImmutablePvc] instead.
class StatefulMutablePvc<T extends ChangeNotifier> extends StatefulWidget {
  /// The controller that manages the data needed to build the view.
  ///
  /// Must implement [ChangeNotifier], and handle the state of the view by calling
  /// [ChangeNotifier.notifyListeners].
  ///
  /// Must not be null.
  final T controller;

  /// Build a widget tree based on the [controller] value.
  ///
  /// Must not be null.
  final PvcWidgetBuilder<T> builder;

  /// The child widget to pass to the [builder].
  ///
  /// If a builder callback's return value contains a subtree that does not depend on
  /// the [controller], it's more efficient to build that subtree once instead of
  /// rebuilding it on every change of the [controller].
  ///
  /// If the pre-built subtree is passed as the child parameter, [StatefulMutablePvc]
  /// will pass it back to the builder function so that it can be incorporated into the build.
  ///
  /// Using this pre-built child is entirely optional, but can improve performance
  /// significantly in some cases.
  final Widget child;

  /// This method is called only once when this widget is inserted into the
  /// widget tree.
  ///
  /// `onModelReady` is used to perform some initialization on the
  /// controller, if needed.
  ///
  /// Must not be null.
  ///
  /// The framework will call this method exactly once for each [StatefulMutablePvc] object
  /// it creates.
  final PvcOnModelReady<T> onModelReady;

  /// Creates a [StatefulWidget] using [ChangeNotifierProvider], and bind the [controller] to it.
  StatefulMutablePvc({
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
  _StatefulMutablePvcState createState() => _StatefulMutablePvcState<T>();
}

class _StatefulMutablePvcState<T extends ChangeNotifier>
    extends State<StatefulMutablePvc<T>> {
  @override
  void initState() {
    widget.onModelReady?.call(widget.controller);
    // widget.onModelReady(widget.controller);
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
