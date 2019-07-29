import 'dart:async';

import 'package:flutter/widgets.dart';

var _lifecycleState = StreamController<AppLifecycleState>();

var currentLifecycleState = _lifecycleState.stream;

class LifecycleManager extends StatefulWidget {
  @override
  _LifecycleManagerState createState() => _LifecycleManagerState();
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
    _lifecycleState.add(state);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
