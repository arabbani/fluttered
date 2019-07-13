import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_widget_builder.dart';

/// A `StatelessImmutablePvc` is immutable, as the name suggests.
/// That means, once created, the widget tree never rebuild itself.
///
/// If you want to perform some initialization on the [controller] when
/// the widget is inserted into the widget tree, use [StatefulImmutablePvc] instead.
///
/// If you want the widget tree to rebuild when the [controller] value changes,
/// use [StatelessMutablePvc] or [StatefulMutablePvc] instead.
class StatelessImmutablePvc<T> extends StatelessWidget {
  /// The controller that manages the data needed to build the view.
  /// Must not be null.
  final T controller;

  /// Build a widget tree based on the [controller] value.
  /// Must not be null.
  final PvcWidgetBuilder<T> builder;

  /// Creates a [StatelessWidget] using [Provider], and bind the [controller] to it.
  StatelessImmutablePvc({
    Key key,
    @required this.controller,
    @required this.builder,
  })  : assert(controller != null, 'The \'controller\' must not be null.'),
        assert(builder != null, 'The \'builder\' must not be null.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      builder: (context) => controller,
      child: Consumer<T>(builder: builder),
      // dispose: (_, controller) => {
      //   if(controller)
      // },
    );
  }
}
