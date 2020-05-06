import 'package:connectivity/connectivity.dart';
import 'package:fengwuxp_dart_openfeign/src/network/network_status_listener.dart';

/// default  listener network status
class DefaultNetworkStatusListener implements NetworkStatusListener {
  final connectivity = Connectivity();




  @override
  Future<NetworkStatus> getNetworkStatus() {
    return connectivity.checkConnectivity().then((result) {
      bool isConnected = ConnectivityResult.none != result;
      return NetworkStatus(isConnected, result);
    });
  }

  @override
  void onChange(callback) {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      bool isConnected = ConnectivityResult.none != result;
      var networkStatus = NetworkStatus(isConnected, result);
      callback(networkStatus);
    });
  }
}
