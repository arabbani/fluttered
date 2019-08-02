import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

/// Network connection status
///
/// wiFi: Device connected via Wi-Fi
/// cellular: Device connected to cellular network
/// offline: Device not connected to any network
enum NetworkConnectivityStatus {
  wiFi,
  cellular,
  offline,
}

/// Widget that reacts to network connections.
class NetworkSensitive extends StatelessWidget {
  /// The widget below this widget in the tree.
  ///
  /// Must not be null.
  final Widget child;

  /// The network connection required for this widget to work.
  /// Default value is [NetworkConnectivityStatus.wiFi].
  final NetworkConnectivityStatus requiredNetwork;

  /// Widget that reacts to network connections.
  const NetworkSensitive({
    Key key,
    this.requiredNetwork = NetworkConnectivityStatus.wiFi,
    @required this.child,
  })  : assert(child != null, 'child must not be null'),
        assert(requiredNetwork != null, 'requiredNetwork must not be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ConnectivityService {
  // Create our public controller
  StreamController<NetworkConnectivityStatus> connectionStatusController =
      StreamController<NetworkConnectivityStatus>();

  ConnectivityService() {
    // Subscribe to the connectivity Chanaged Steam
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t

      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  // Convert from the third part enum to our own enum
  NetworkConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return NetworkConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return NetworkConnectivityStatus.wiFi;
      case ConnectivityResult.none:
        return NetworkConnectivityStatus.offline;
      default:
        return NetworkConnectivityStatus.offline;
    }
  }
}
