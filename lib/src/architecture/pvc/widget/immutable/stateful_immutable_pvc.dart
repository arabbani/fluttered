import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_on_model_ready.dart';
import '../../typedef/pvc_widget_builder.dart';

/// A `StatefulImmutablePVC` is immutable, as the name suggests.
/// That means, once created, the widget tree never rebuild itself.
///
/// If you want the widget tree to rebuild when the [controller] value changes,
/// use [StatelessMutablePVC] or [StatefulMutablePVC] instead.
class StatefulImmutablePVC<T> extends StatefulWidget {
  /// The controller that manages the data needed to build the view.
  /// Must not be null.
  final T controller;

  /// Build a widget tree based on the [controller] value.
  /// Must not be null.
  final PVCWidgetBuilder<T> builder;

  /// This method is called only once when this widget is inserted into the
  /// widget tree.
  ///
  /// `onModelReady` is used to perform some initialization on the
  /// controller, if needed.
  ///
  /// Must not be null.
  ///
  /// The framework will call this method exactly once for each [StatefulImmutablePVC] object
  /// it creates.
  final PvcOnModelReady<T> onModelReady;

  /// Creates a [StatefulWidget] using [Provider], and bind the [controller] to it.
  StatefulImmutablePVC({
    Key key,
    @required this.controller,
    @required this.builder,
    @required this.onModelReady,
  })  : assert(controller != null, 'The \'controller\' must not be null.'),
        assert(builder != null, 'The \'builder\' must not be null.'),
        assert(onModelReady != null, '\'onModelReady\' must not be null.'),
        super(key: key);

  @override
  _StatefulImmutablePVCState createState() => _StatefulImmutablePVCState<T>();
}

class _StatefulImmutablePVCState<T> extends State<StatefulImmutablePVC<T>> {
  @override
  void initState() {
    widget.onModelReady(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      builder: (context) => widget.controller,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
