import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_provider_builder.dart';

/// Create a [StatelessWidget] using [Provider]. Once created,
/// the widget tree never rebuilds.
class StatelessImmutablePVC<T> extends StatelessWidget {
  /// The controller for this view. [controller] manages the data needed
  /// to build the view.
  final T controller;

  /// Build a widget tree based on the [controller] value. Once created,
  /// the widget never rebuild itself.
  ///
  /// Must not be null.
  final PVCProviderBuilder<T> builder;

  /// Create a [StatelessWidget] using [Provider], and bind the [controller] to it.
  ///
  /// [StatelessImmutablePVC] is immutable, as the name suggests. That means
  /// it will never rebuild itself.
  ///
  /// If you want the widget tree to rebuild based on the [controller] value,
  /// use [StatelessMutablePVC] or [StatefulMutablePVC] instead.
  ///
  /// If you want to perform some initialization logic on the [controller] when
  /// the widget is inserted into the tree, use [StatefulImmutablePVC] instead.
  StatelessImmutablePVC({
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
