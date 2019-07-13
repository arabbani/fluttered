import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../typedef/pvc_widget_builder.dart';

/// `StatelessMutablePVC` rebuild itself whenever the [controller] value changes.
///
/// {@template fluttered.architecture.pvc.mutable.disposeInfo}
/// It will automatically call [ChangeNotifier.dispose] when this widget is removed
/// from the widget tree.
/// {@endtemplate}
///
/// If you want to perform some initialization on the [controller] when
/// the widget is inserted into the widget tree, use [StatefulMutablePVC] instead.
///
/// {@template fluttered.architecture.pvc.mutable.alternateImplementation}
/// If the entire widget tree returned by the [builder] callback does not rebuild
/// when the [controller] value changes, use [StatelessImmutablePVC] or [StatefulImmutablePVC] instead.
/// {@endtemplate}

class StatelessMutablePVC<T extends ChangeNotifier> extends StatelessWidget {
  /// {@macro fluttered.architecture.pvc.controller}
  ///
  /// {@template fluttered.mustImplementChangeNotifier}
  /// Must implement [ChangeNotifier], and handle the state of the view by calling
  /// [ChangeNotifier.notifyListeners].
  /// {@endtemplate}
  ///
  /// {@macro fluttered.mustNotBeNull}
  final T controller;

  /// {@macro fluttered.architecture.pvc.builder}
  ///
  /// {@template fluttered.builderRebuildInfo}
  /// The widget rebuild itself whenever the [controller] calls [ChangeNotifier.notifyListeners].
  /// {@endtemplate}
  ///
  /// {@macro fluttered.mustNotBeNull}
  final PVCWidgetBuilder<T> builder;

  /// {@template fluttered.architecture.pvc.child}
  /// The child widget to pass to the [builder].
  ///
  /// If a builder callback's return value contains a subtree that does not depend on
  /// the [controller], it's more efficient to build that subtree once instead of
  /// rebuilding it on every change of the [controller].
  /// {@endtemplate}
  ///
  /// If the pre-built subtree is passed as the child parameter, [StatelessMutablePVC]
  /// will pass it back to the builder function so that it can be incorporated into the build.
  ///
  /// {@template fluttered.architecture.pvc.childBenefit}
  /// Using this pre-built child is entirely optional, but can improve performance
  /// significantly in some cases.
  /// {@endtemplate}
  final Widget child;

  /// Creates a [StatelessWidget] using [ChangeNotifierProvider], and bind the [controller] to it.
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
