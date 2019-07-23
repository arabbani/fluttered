import 'package:flutter/widgets.dart';
import 'package:fluttered/src/widget/stateful_wrapper.dart';
import 'package:provider/provider.dart';

import '../typedef/pvc_on_model_ready.dart';

/// `MutablePVC` rebuild itself whenever the [controller] value changes.
///
/// It will automatically dispose the [controller] when this widget is removed
/// from the widget tree.
///
/// If the entire widget tree returned by the [builder] callback does not rebuild
/// when the [controller] value changes, use [ImmutablePVC] instead.
class MutablePVC<T extends ChangeNotifier> extends StatelessWidget {
  /// The controller that manages the data needed to build the view.
  ///
  /// Must implement [ChangeNotifier], and change the state by calling [ChangeNotifier.notifyListeners].
  ///
  /// Must not be null.
  final T controller;

  /// Build a widget tree based on the [controller] value.
  ///
  /// Must not be null.
  final Widget Function(BuildContext context, T controller, Widget child)
      builder;

  /// The child widget to pass to the [builder].
  ///
  /// If a builder callback's return value contains a subtree that does not depend on
  /// the [controller], it's more efficient to build that subtree once instead of
  /// rebuilding it on every change of the [controller].
  ///
  /// If the pre-built subtree is passed as the child parameter, [MutablePVC]
  /// will pass it back to the builder function so that it can be incorporated into the build.
  ///
  /// Using this pre-built child is entirely optional, but can improve performance
  /// significantly in some cases.
  final Widget child;

  /// Called when this widget is inserted into the tree.
  ///
  /// `onModelReady` is used to perform some initialization on the
  /// controller, if needed.
  ///
  /// Must not be null.
  ///
  /// The framework will call this method exactly once.
  final PvcOnModelReady<T> onModelReady;

  /// Creates a [StatelessWidget] using [ChangeNotifierProvider], and bind the [controller] to it.
  const MutablePVC({
    Key key,
    @required this.controller,
    @required this.builder,
    this.child,
    this.onModelReady,
  })  : assert(controller != null, 'The controller must not be null.'),
        assert(builder != null, 'The builder must not be null.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onModelReady != null) {
      return StatefulWrapper(
        child: _createChild(),
        onInit: onModelReady,
      );
    }
    return _createChild();
  }

  Widget _createChild() {
    return ChangeNotifierProvider<T>(
      builder: (context) => controller,
      child: Consumer<T>(
        builder: builder,
        child: child,
      ),
    );
  }
}
