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
class NetworkSensitive extends StatefulWidget {
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

  /// Callback to execute when device connected to cellular network.
  final Function onCellular;

  /// Callback to execute when device connected via Wi-Fi.
  final Function onWifi;

  /// Callback to execute when device not connected to any network.
  final Function onOffline;

  /// Widget that reacts to network connections.
  const NetworkSensitive({
    Key key,
    @required this.requiredNetworks,
    @required this.offlineFeedback,
    this.showBackdrop = true,
    this.backdropColor = Colors.grey,
    this.backdropOpacity = 0.5,
    this.onCellular,
    this.onWifi,
    this.onOffline,
    @required this.child,
  })  : assert(child != null, 'child must not be null'),
        assert(requiredNetworks != null, 'requiredNetwork must not be null'),
        assert(offlineFeedback != null, 'offlineFeedback must not be null'),
        super(key: key);

  @override
  _NetworkSensitiveState createState() => _NetworkSensitiveState();
}

class _NetworkSensitiveState extends State<NetworkSensitive> {
  List<ConnectivityResult> _mappedRequiredNetworks = [];

  @override
  void initState() {
    super.initState();
    _mapThirdPartyNaetworkStatus();
  }

  @override
  void didUpdateWidget(NetworkSensitive oldWidget) {
    super.didUpdateWidget(oldWidget);
    _mapThirdPartyNaetworkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: Connectivity().onConnectivityChanged,
      child: Consumer<ConnectivityResult>(
        builder: (context, connectivity, _) {
          _executeCallback(connectivity);
          return _constructView(context, connectivity);
        },
      ),
    );
  }

  Widget _constructView(BuildContext context, ConnectivityResult connectivity) {
    if (_mappedRequiredNetworks.contains(connectivity)) {
      return widget.child;
    } else {
      List<Widget> stackChildren = [widget.child];
      if (widget.showBackdrop) {
        stackChildren.add(
          Opacity(
            child: Container(
              color: widget.backdropColor,
            ),
            opacity: widget.backdropOpacity,
          ),
        );
      }
      stackChildren.add(
        Positioned(
          bottom: 0.0,
          child: widget.offlineFeedback,
        ),
      );
      return Stack(
        children: stackChildren,
      );
    }
  }

  void _mapThirdPartyNaetworkStatus() {
    widget.requiredNetworks.forEach(
      (status) => _mappedRequiredNetworks.add(_mapNetwork(status)),
    );
  }

  void _executeCallback(ConnectivityResult connectivity) {
    switch (connectivity) {
      case ConnectivityResult.wifi:
        widget.onWifi?.call();
        break;
      case ConnectivityResult.mobile:
        widget.onCellular?.call();
        break;
      case ConnectivityResult.none:
        widget.onOffline?.call();
        break;
    }
  }

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
