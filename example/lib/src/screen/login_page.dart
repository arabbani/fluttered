import 'package:example/src/util/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/fluttered.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Login'),
          onPressed: () {
            sharedPrefsServiceInstance.set(loggedInKey, true);
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
      ),
    );
  }
}
