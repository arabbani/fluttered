import 'package:flutter/material.dart';
import 'package:fluttered/fluttered.dart';

class NetworkAware extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Aware'),
      ),
      body: NetworkSensitive(
        requiredNetworks: [NetworkConnectivityStatus.cellular],
        offlineFeedback: Container(
          padding: const EdgeInsets.all(8),
          width: screenWidth(context),
          decoration: BoxDecoration(color: Colors.blue),
          alignment: Alignment.center,
          child: Text('Network Error'),
        ),
        onWifi: () => print('WIFI'),
        child: Center(
          child: Text('NETWORK AWARE'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            title: Text('A'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            title: Text('B'),
          ),
        ],
      ),
    );
  }
}
