import 'package:connectivity/connectivity.dart';

/// Network status listener
abstract class NetworkStatusListener {
  Future<NetworkStatus> getNetworkStatus();

  // 监听网络状态
  void onChange(void callback(NetworkStatus networkStatus));
}

class NetworkStatus {
  /// 当前是否有网络连接
  final bool isConnected;

  /// 网络类型
  final ConnectivityResult networkType;

  NetworkStatus(this.isConnected, this.networkType);
}
