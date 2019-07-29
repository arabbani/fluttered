import 'package:flutter/widgets.dart';

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
    // setState(() {
    //   _lastLifecycleState = state;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
