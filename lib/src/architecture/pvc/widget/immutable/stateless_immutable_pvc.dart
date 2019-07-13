import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_provider_builder.dart';

/// A [StatelessImmutablePVC] is immutable, as the name suggests.
// {@template pvc.immutable}
/// That means, once created, the widget tree never rebuild itself.
/// The [controller] manages the data needed to build the widget tree.
///
/// If you want the widget tree to rebuild when the [controller] value changes,
/// use [StatelessMutablePVC] or [StatefulMutablePVC] instead.
/// {@endtemplate}
///
/// If you want to perform some initialization on the [controller] when
/// the widget is inserted into the widget tree, use [StatefulImmutablePVC] instead.
class StatelessImmutablePVC<T> extends StatelessWidget {
  /// {@template pvc.immutable.controller}
  /// The controller for this view. [controller] manages the data needed
  /// to build the view.
  ///
  /// Must not be null.
  /// {@endtemplate}
  final T controller;

  /// {@template pvc.builder}
  /// Build a widget tree based on the [controller] value.
  ///
  /// Must not be null.
  /// {@endtemplate}
  final PVCProviderBuilder<T> builder;

  /// Create a [StatelessWidget] using [Provider], and bind the [controller] to it.
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
