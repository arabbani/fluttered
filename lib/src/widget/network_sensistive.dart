import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  /// Either one of the provided network is sufficient for this
  /// widget to work.
  ///
  /// Example, if your widget work with either `wifi` or `cellular`, pass
  /// `requiredNetworks = [NetworkConnectivityStatus.wifi, NetworkConnectivityStatus.cellular]`
  final List<NetworkConnectivityStatus> requiredNetworks;

  /// Widget to show as overlay when the network connection does
  /// not satisfy [requiredNetworks].
  final Widget offlineFeedback;

  /// Whether to show backdrop.
  final bool showBackdrop;

  /// Backdrop color.
  final Color backdropColor;

  /// Backdrop opacity.
  final double backdropOpacity;

  /// Widget that reacts to network connections.
  const NetworkSensitive({
    Key key,
    @required this.requiredNetworks,
    @required this.offlineFeedback,
    this.showBackdrop = true,
    this.backdropColor = Colors.grey,
    this.backdropOpacity = 0.5,
    @required this.child,
  })  : assert(child != null, 'child must not be null'),
        assert(requiredNetworks != null, 'requiredNetwork must not be null'),
        assert(offlineFeedback != null, 'offlineFeedback must not be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ConnectivityResult> _mappedRequiredNetworks = [];
    requiredNetworks.forEach(
      (status) => _mappedRequiredNetworks.add(_mapNetwork(status)),
    );
    return StreamProvider.value(
      value: Connectivity().onConnectivityChanged,
      child: Consumer<ConnectivityResult>(
        builder: (context, connectivity, _) {
          if (_mappedRequiredNetworks.contains(connectivity)) {
            return child;
          } else {
            List<Widget> stackChildren = [child];
            if (showBackdrop) {
              stackChildren.add(
                Opacity(
                  child: Container(
                    color: backdropColor,
                  ),
                  opacity: backdropOpacity,
                ),
              );
            }
            stackChildren.add(
              Positioned(
                bottom: 0.0,
                child: offlineFeedback,
              ),
            );
            return Stack(
              children: stackChildren,
            );
          }
        },
      ),
    );
  }

  // Convert from our own enum to the third party enum
  ConnectivityResult _mapNetwork(NetworkConnectivityStatus status) {
    ConnectivityResult result;
    switch (status) {
      case NetworkConnectivityStatus.cellular:
        result = ConnectivityResult.mobile;
        break;
      case NetworkConnectivityStatus.wiFi:
        result = ConnectivityResult.wifi;
        break;
      case NetworkConnectivityStatus.offline:
        result = ConnectivityResult.none;
        break;
    }
    return result;
  }
}
