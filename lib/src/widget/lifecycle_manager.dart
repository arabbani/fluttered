import 'dart:async';

import 'package:flutter/widgets.dart';

/// Manages the application lifecycle states.
class LifecycleManager extends StatefulWidget {
  /// The widget below this widget in the tree.
  ///
  /// Must not be null.
  final Widget child;

  /// Called when the application is paused.
  ///
  /// See also:
  ///
  ///  * [AppLifecycleState] for more info.
  final VoidCallback onPaused;

  /// Called when the application is resumed.
  ///
  /// See also:
  ///
  ///  * [AppLifecycleState] for more info.
  final VoidCallback onResumed;

  /// Called when the application is suspending.
  ///
  /// See also:
  ///
  ///  * [AppLifecycleState] for more info.
  final VoidCallback onSuspending;

  /// Manages the application lifecycle states.
  const LifecycleManager({
    Key key,
    @required this.child,
    this.onPaused,
    this.onResumed,
    this.onSuspending,
  })  : assert(child != null, 'child must not be null'),
        super(key: key);

  @override
  _LifecycleManagerState createState() => _LifecycleManagerState();

  static _LifecycleManagerState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LifecycleManagerState>());
}

class _LifecycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {
  StreamController<AppLifecycleState> _lifecycleStateController;

  /// Stream of application lifecycle states.
  Stream<AppLifecycleState> lifecycleStateStream;

  @override
  void initState() {
    super.initState();
    _lifecycleStateController = StreamController();
    lifecycleStateStream = _lifecycleStateController.stream;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _lifecycleStateController?.close();
    lifecycleStateStream = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lifecycleStateController.add(state);
    switch (state) {
      case AppLifecycleState.paused:
        widget.onPaused?.call();
        break;
      case AppLifecycleState.resumed:
        widget.onResumed?.call();
        break;
      case AppLifecycleState.suspending:
        widget.onSuspending?.call();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
