import 'package:example/src/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/fluttered.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter(BuildContext context) {
    _counter++;
    if (_counter > 1) {
      _counter = 0;
    }
    ThemeManager.of(context).setTheme(availableThemes.keys.toList()[_counter]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: LifecycleManager(
          onPaused: () => print('PAUSED'),
          onResumed: () => print('RESUMED'),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
              ),
              RaisedButton(
                child: Text('Grid_Or_List'),
                onPressed: () => Navigator.pushNamed(context, 'gridOrList'),
              ),
              RaisedButton(
                child: Text('NetworkSensitive'),
                onPressed: () => Navigator.pushNamed(context, 'networkAware'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
