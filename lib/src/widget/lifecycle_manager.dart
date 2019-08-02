import 'package:flutter/widgets.dart';

/// Manages the application lifecycle states.
class LifecycleManager extends StatefulWidget {
  /// The widget below this widget in the tree.
  ///
  /// Must not be null.
  final Widget child;

  /// Called when the application is in [AppLifecycleState.resumed] state.
  final VoidCallback onResumed;

  /// Called when the application is in [AppLifecycleState.inactive] state.
  final VoidCallback onInactive;

  /// Called when the application is in [AppLifecycleState.paused] state.
  final VoidCallback onPaused;

  /// Called when the application is in [AppLifecycleState.suspending] state.
  final VoidCallback onSuspending;

  /// Manages the application lifecycle states.
  const LifecycleManager({
    Key key,
    this.onResumed,
    this.onInactive,
    this.onPaused,
    this.onSuspending,
    @required this.child,
  })  : assert(child != null, 'child must not be null'),
        super(key: key);

  @override
  _LifecycleManagerState createState() => _LifecycleManagerState();

  static _LifecycleManagerState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LifecycleManagerState>());
}

class _LifecycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.onResumed?.call();
        break;
      case AppLifecycleState.inactive:
        widget.onInactive?.call();
        break;
      case AppLifecycleState.paused:
        widget.onPaused?.call();
        break;
      case AppLifecycleState.suspending:
        widget.onSuspending?.call();
        break;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
