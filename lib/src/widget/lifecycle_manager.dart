import 'dart:async';

import 'package:flutter/widgets.dart';

StreamController<AppLifecycleState> _lifecycleState;

Stream<AppLifecycleState> currentLifecycleState;

class LifecycleManager extends StatefulWidget {
  @override
  _LifecycleManagerState createState() => _LifecycleManagerState();
}

class _LifecycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _lifecycleState = StreamController();
    currentLifecycleState = _lifecycleState.stream;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _lifecycleState?.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lifecycleState.add(state);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
