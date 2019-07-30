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
    setState(() {
      _counter++;
      if (_counter > 1) {
        _counter = 0;
      }
    });
    ThemeManager.of(context).setTheme(availableThemes.keys.toList()[_counter]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
          stream: lifecycleState,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('WAITING');
            } else if (snapshot.hasError) {
              return Text('APP LIFECYCLE_STATE ERROR');
            } else {
              return Text(snapshot.data.toString());
            }
          },
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
