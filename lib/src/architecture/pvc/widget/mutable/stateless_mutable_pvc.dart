import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_widget_builder.dart';

/// `StatelessMutablePvc` rebuild itself whenever the [controller] value changes.
///
/// It will automatically dispose the [controller] when this widget is removed
/// from the widget tree.
///
/// If you want to perform some initialization on the [controller] when
/// the widget is inserted into the widget tree, use [StatefulMutablePvc] instead.
///
/// If the entire widget tree returned by the [builder] callback does not rebuild
/// when the [controller] value changes, use [StatelessImmutablePvc] or [StatefulImmutablePvc] instead.

class StatelessMutablePvc<T extends ChangeNotifier> extends StatelessWidget {
  /// The controller that manages the data needed to build the view.
  ///
  /// Must implement [ChangeNotifier], and change the state by calling [ChangeNotifier.notifyListeners].
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
  /// If the pre-built subtree is passed as the child parameter, [StatelessMutablePvc]
  /// will pass it back to the builder function so that it can be incorporated into the build.
  ///
  /// Using this pre-built child is entirely optional, but can improve performance
  /// significantly in some cases.
  final Widget child;

  /// Creates a [StatelessWidget] using [ChangeNotifierProvider], and bind the [controller] to it.
  StatelessMutablePvc({
    Key key,
    @required this.controller,
    @required this.builder,
    this.child,
  })  : assert(controller != null, 'The \'controller\' must not be null.'),
        assert(builder != null, 'The \'builder\' must not be null.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => controller,
      child: Consumer<T>(
        builder: builder,
        child: child,
      ),
    );
  }
}
