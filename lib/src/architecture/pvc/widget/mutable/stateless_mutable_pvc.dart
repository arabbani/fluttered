import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_provider_builder.dart';

/// Create a [StatelessWidget] using [ChangeNotifierProvider]. The widget rebuild
/// itself whenever the [controller] calls [ChangeNotifier.notifyListeners].
class StatelessMutablePVC<T extends ChangeNotifier> extends StatelessWidget {
  /// The controller for this view. [controller] manages the data needed
  /// to build the view.
  ///
  /// Must implement [ChangeNotifier], and handle the state of the view by calling
  /// [ChangeNotifier.notifyListeners].
  final T controller;

  /// Build a widget tree based on the [controller] value. The widget rebuild itself
  /// whenever the [controller] changes its state by calling [ChangeNotifier.notifyListeners].
  ///
  /// Must not be null.
  final PVCProviderBuilder<T> builder;

  /// The child widget to pass to [builder].
  ///
  /// If a builder callback's return value contains a subtree that does not depend on
  /// the [controller], it's more efficient to build that subtree once instead of
  /// rebuilding it on every change of the [controller].
  ///
  /// If the pre-built subtree is passed as the child parameter, [StatelessMutablePVC]
  /// will pass it back to the builder function so that it can be incorporated into the build.
  ///
  /// Using this pre-built child is entirely optional, but can improve performance
  /// significantly in some cases.
  final Widget child;

  /// Create a [StatelessWidget] using [ChangeNotifierProvider], and bind the [controller] to it.
  /// The state of the widget is maintained by the [controller].
  ///
  /// `StatelessMutablePVC` rebuild itself whenever the [controller] calls [ChangeNotifier.notifyListeners].
  ///
  /// If the entire widget tree returned by the builder callback does not depend on the [controller],
  /// use [StatelessImmutablePVC] or [StatefulImmutablePVC] instead.
  ///
  /// If you want to perform some initialization logic on the [controller] when the widget is
  /// inserted into the tree, use [StatefulMutablePVC] instead.
  StatelessMutablePVC({
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
