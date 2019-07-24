import 'package:flutter/widgets.dart';
import 'package:fluttered/src/widget/stateful_wrapper.dart';
import 'package:provider/provider.dart';

import 'typedef/pvc_on_model_ready.dart';

/// `ImmutablePVC`, as the name suggests, is immutable.
/// That means, once created, the widget tree never rebuild itself.
///
/// If you want the widget tree to rebuild when the [controller] value changes,
/// use [MutablePVC] instead.
class ImmutablePVC<T> extends StatelessWidget {
  /// The controller that manages the data needed to build the view.
  /// Must not be null.
  final T controller;

  /// Build a widget tree based on the [controller] value.
  ///
  /// Must not be null.
  final Widget Function(BuildContext context, T controller) builder;

  /// Called when this widget is inserted into the tree.
  ///
  /// `onModelReady` is used to perform some initialization on the
  /// controller, if needed.
  ///
  /// Must not be null.
  ///
  /// The framework will call this method exactly once.
  final PvcOnModelReady<T> onModelReady;

  /// This method is called when this widget is removed from the tree.
  ///
  /// If you need to cleanup resources, like close a database connection
  /// or close a opened file etc, create a `dispose` method on the
  /// [controller] and pass it as dispose argument.
  final Widget Function(BuildContext context, T controller) dispose;

  /// Creates a [StatelessWidget] using [Provider], and bind the [controller] to it.
  const ImmutablePVC({
    Key key,
    @required this.controller,
    @required this.builder,
    this.onModelReady,
    this.dispose,
  })  : assert(controller != null, 'The controller must not be null.'),
        assert(builder != null, 'The builder must not be null.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onModelReady != null) {
      return StatefulWrapper(
        child: _createChild(context),
        onInit: onModelReady,
      );
    }
    return _createChild(context);
  }

  Widget _createChild(BuildContext context) {
    return Provider<T>(
      builder: (context) => controller,
      dispose: dispose,
      child: builder(
        context,
        Provider.of<T>(context, listen: false),
      ),
    );
  }
}
