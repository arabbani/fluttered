import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_widget_builder.dart';

/// `StatefulMutablePVC` rebuild itself whenever the [controller] value changes.
///
/// {@macro fluttered.architecture.pvc.mutable.disposeInfo}
///
/// {@macro fluttered.architecture.pvc.mutable.alternateImplementation}
class StatefulMutablePVC<T extends ChangeNotifier> extends StatefulWidget {
  /// {@macro fluttered.architecture.pvc.controller}
  ///
  /// {@macro fluttered.mustImplementChangeNotifier}
  ///
  /// {@macro fluttered.mustNotBeNull}
  final T controller;

  /// {@macro fluttered.architecture.pvc.builder}
  ///
  /// {@macro fluttered.builderRebuildInfo}
  ///
  /// {@macro fluttered.mustNotBeNull}
  final PVCWidgetBuilder<T> builder;

  /// {@macro fluttered.architecture.pvc.child}
  ///
  /// If the pre-built subtree is passed as the child parameter, [StatefulMutablePVC]
  /// will pass it back to the builder function so that it can be incorporated into the build.
  ///
  /// {@macro fluttered.architecture.pvc.childBenefit}
  final Widget child;

  /// {@macro fluttered.architecture.pvc.onModelReady}
  ///
  /// {@macro fluttered.mustNotBeNull}
  ///
  /// The framework will call this method exactly once for each [StatefulMutablePVC] object
  /// it creates.
  final Function(T controller) onModelReady;

  /// Creates a [StatefulWidget] using [ChangeNotifierProvider], and bind the [controller] to it.
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
