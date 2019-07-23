import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_dispose.dart';
import '../../typedef/pvc_on_model_ready.dart';
import '../../typedef/pvc_widget_builder.dart';

/// A `StatefulImmutablePvc` is immutable, as the name suggests.
/// That means, once created, the widget tree never rebuild itself.
///
/// If you want the widget tree to rebuild when the [controller] value changes,
/// use [StatelessMutablePvc] or [StatefulMutablePvc] instead.
class StatefulImmutablePvc<T> extends StatefulWidget {
  /// The controller that manages the data needed to build the view.
  /// Must not be null.
  final T controller;

  /// Build a widget tree based on the [controller] value.
  /// Must not be null.
  final PvcWidgetBuilder<T> builder;

  /// This method is called only once when this widget is inserted into the
  /// widget tree.
  ///
  /// `onModelReady` is used to perform some initialization on the
  /// controller, if needed.
  ///
  /// Must not be null.
  ///
  /// The framework will call this method exactly once for each [StatefulImmutablePvc] object
  /// it creates.
  final PvcOnModelReady<T> onModelReady;

  /// This method is called when the widget is removed from the tree.
  ///
  /// If you need to cleanup resources, like close a database connection
  /// or close a opened file etc, create a `dispose` method on the
  /// [controller] and pass it as `dispose` argument.
  final PvcDispose<T> dispose;

  /// Creates a [StatefulWidget] using [Provider], and bind the [controller] to it.
  StatefulImmutablePvc({
    Key key,
    @required this.controller,
    @required this.builder,
    @required this.onModelReady,
    this.dispose,
  })  : assert(controller != null, 'The controller must not be null.'),
        assert(builder != null, 'The builder must not be null.'),
        assert(onModelReady != null, 'onModelReady must not be null.'),
        super(key: key);

  @override
  _StatefulImmutablePvcState createState() => _StatefulImmutablePvcState<T>();
}

class _StatefulImmutablePvcState<T> extends State<StatefulImmutablePvc<T>> {
  @override
  void initState() {
    widget.onModelReady(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      builder: (context) => widget.controller,
      dispose: widget.dispose,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
