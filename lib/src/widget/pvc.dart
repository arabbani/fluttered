import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttered/src/widget/stateful_wrapper.dart';
import 'package:provider/provider.dart';

typedef _OnInit<T> = void Function(T controller);

/// `MutablePVC` rebuild itself whenever the [controller] value changes.
///
/// It will automatically dispose the [controller] when this widget is
/// removed from the widget tree.
///
/// If the entire widget tree returned by the [builder] callback does
/// not rebuild when the [controller] value changes, use [ImmutablePVC]
/// instead.
class MutablePVC<T extends ChangeNotifier> extends StatelessWidget {
  /// The controller that manages the data needed to build the view.
  ///
  /// Must implement [ChangeNotifier], and change the state by calling
  /// [ChangeNotifier.notifyListeners].
  ///
  /// Must not be null.
  final T controller;

  /// Build a widget tree based on the [controller] value.
  ///
  /// Must not be null.
  final Widget Function(
      BuildContext context, T controller, Widget immutableTree) builder;

  /// The immutableTree widget to pass to the [builder].
  ///
  /// If a builder callback's return value contains a subtree that does
  /// not depend on the [controller], it's more efficient to build that
  /// subtree once instead of rebuilding it on every change of the [controller].
  ///
  /// If the pre-built subtree is passed as the `immutableTree` parameter,
  /// [MutablePVC] will pass it back to the builder function so that it
  /// can be incorporated into the build.
  ///
  /// Using this pre-built `immutableTree` is entirely optional, but can
  /// improve performance significantly in some cases.
  final Widget immutableTree;

  /// Called when this widget is inserted into the tree. `onInit` is used
  /// to perform some initialization on the controller, if needed.
  ///
  /// The framework will call this method exactly once.
  ///
  /// See also:
  ///
  ///  * [StatefulWidget.initState] for more info.
  final _OnInit<T> onInit;

  /// Create a widget using [ChangeNotifierProvider].
  ///
  /// The parameters [controller] and [builder] must not be null.
  const MutablePVC({
    Key key,
    @required this.controller,
    @required this.builder,
    this.immutableTree,
    this.onInit,
  })  : assert(controller != null, 'The controller must not be null.'),
        assert(builder != null, 'The builder must not be null.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onInit != null) {
      return StatefulWrapper(
        child: _createChild(),
        initState: () => onInit(controller),
      );
    }
    return _createChild();
  }

  Widget _createChild() {
    return ChangeNotifierProvider<T>(
      builder: (context) => controller,
      child: Consumer<T>(
        builder: builder,
        child: immutableTree,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}

/// `ImmutablePVC`, as the name suggests, is immutable.
/// That means, once created, the widget tree never rebuild itself.
///
/// If you want the widget tree to rebuild when the [controller] value
/// changes, use [MutablePVC] instead.
class ImmutablePVC<T> extends StatelessWidget {
  /// The controller that manages the data needed to build the view.
  /// Must not be null.
  final T controller;

  /// Build a widget tree based on the [controller] value.
  ///
  /// Must not be null.
  final Widget Function(BuildContext context, T controller) builder;

  /// Called when this widget is inserted into the tree. `onInit` is used
  /// to perform some initialization on the controller, if needed.
  ///
  /// The framework will call this method exactly once.
  ///
  /// See also:
  ///
  ///  * [StatefulWidget.initState] for more info.
  final _OnInit<T> onInit;

  /// This method is called when this widget is removed from the tree.
  ///
  /// If you need to cleanup resources, like close a database connection
  /// or close a opened file etc, create a `dispose` method on the
  /// [controller] and pass it as dispose argument.
  ///
  /// See also:
  ///
  ///  * [StatefulWidget.dispose] for more info.
  final Widget Function(BuildContext context, T controller) dispose;

  /// Create a widget using [Provider].
  ///
  /// The parameters [controller] and [builder] must not be null.
  const ImmutablePVC({
    Key key,
    @required this.controller,
    @required this.builder,
    this.onInit,
    this.dispose,
  })  : assert(controller != null, 'The controller must not be null.'),
        assert(builder != null, 'The builder must not be null.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onInit != null) {
      return StatefulWrapper(
        child: _createChild(context),
        initState: () => onInit(controller),
      );
    }
    return _createChild(context);
  }

  Widget _createChild(BuildContext context) {
    return Provider<T>(
      builder: (context) => controller,
      dispose: dispose,
      child: Builder(
        builder: (context) => builder(
          context,
          Provider.of<T>(context, listen: false),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}
