import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_widget_builder.dart';

/// A [StatefulImmutablePVC] is immutable, as the name suggests.
/// {@macro pvc.immutable}
class StatefulImmutablePVC<T> extends StatefulWidget {
  /// {@macro pvc.immutable.controller}
  final T controller;

  /// {@macro pvc.builder}
  final PVCWidgetBuilder<T> builder;

  /// {@template pvc.onModelReady}
  /// This method is called only once when this widget is inserted into the
  /// widget tree. This method is used to perform some initialization on the
  /// controller, if needed.
  /// {@endtemplate}
  ///
  /// The framework will call this method exactly once for each [StatefulImmutablePVC] object
  /// it creates.
  final Function(T) onModelReady;

  /// Create a [StatefulWidget] using [Provider], and bind the [controller] to it.
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
