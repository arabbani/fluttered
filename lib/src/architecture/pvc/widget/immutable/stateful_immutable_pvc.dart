import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_provider_builder.dart';

/// Create a [StatefulWidget] using [Provider]. Once created,
/// the widget tree never rebuilds.
class StatefulImmutablePVC<T> extends StatefulWidget {
  /// The controller for this view. [controller] manages the data needed
  /// to build the view.
  final T controller;

  /// Build a widget tree based on the [controller] value. Once created,
  /// the widget never rebuild itself.
  ///
  /// Must not be null.
  final PVCProviderBuilder<T> builder;

  /// Called when this widget is inserted into the tree. This method is used to perform some
  /// initialization logic on the controller, if needed.
  ///
  /// The framework will call this method exactly once for each [StatefulImmutablePVC] object
  /// it creates.
  final Function(T) onModelReady;

  /// Create a [StatefulWidget] using [Provider], and bind the [controller] to it.
  ///
  /// `StatefulImmutablePVC` is immutable, as the name suggests. That means it will never
  /// rebuild itself.
  ///
  /// If you want the widget tree to rebuild based on the [controller] value,
  /// use [StatelessMutablePVC] or [StatefulMutablePVC] instead.
  ///
  /// [onModelReady] is called when this object is inserted into the tree. This method is used to
  /// perform some initialization logic on the controller, if needed. The framework
  /// will call this method exactly once for each [StatefulImmutablePVC] object it creates.
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
