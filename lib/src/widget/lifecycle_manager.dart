import 'dart:async';

import 'package:flutter/widgets.dart';

StreamController<AppLifecycleState> _lifecycleStateController;

Stream<AppLifecycleState> lifecycleState;

class LifecycleManager extends StatefulWidget {
  /// The widget below this widget in the tree.
  ///
  /// Must not be null.
  final Widget child;

  /// Called when the application is paused.
  final VoidCallback onPaused;

  /// Called when the application is resumed.
  final VoidCallback onResumed;

  const LifecycleManager({
    Key key,
    @required this.child,
    this.onPaused,
    this.onResumed,
  })  : assert(child != null, 'child must not be null'),
        super(key: key);

  @override
  _LifecycleManagerState createState() => _LifecycleManagerState();
}

class _LifecycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _lifecycleStateController = StreamController();
    lifecycleState = _lifecycleStateController.stream;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _lifecycleStateController?.close();
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
      default:
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
