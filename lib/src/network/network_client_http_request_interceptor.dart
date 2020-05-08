import 'dart:async';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:fengwuxp_dart_openfeign/src/client/client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/network/default_network_status_listener.dart';
import 'package:fengwuxp_dart_openfeign/src/network/network_status_listener.dart';
import 'package:fengwuxp_dart_openfeign/src/network/none_network_failback.dart';

/// It needs to be configured first in the [ClientHttpRequestInterceptor] list
///
/// Check whether the client network is available and can be degraded with custom processing.
/// For example, stack requests until the network is available or abandon the request
///
/// Network interception interceptor during the execution of http client, which conflicts with {@see NetworkFeignClientExecutorInterceptor}
class NetworkClientHttpRequestInterceptor implements ClientHttpRequestInterceptor {
  final NetworkStatusListener networkStatusListener;

  final NoneNetworkFailBack networkFailBack;

  // Number of spin attempts to wait for network recovery
  final int tryWaitNetworkCount;

  // Maximum number of milliseconds for spin wait
  final int spinWaitMaxTimes;

  NetworkStatus _currentStatus = null;

  NetworkClientHttpRequestInterceptor(
      {NetworkStatusListener networkStatusListener,
      NoneNetworkFailBack networkFailBack,
      int tryWaitNetworkCount,
      int spinWaitMaxTimes})
      : this.networkStatusListener = networkStatusListener ?? DefaultNetworkStatusListener(),
        this.networkFailBack = networkFailBack,
        this.tryWaitNetworkCount = tryWaitNetworkCount ?? 3,
        this.spinWaitMaxTimes = spinWaitMaxTimes ?? 500 {
    this._initNetwork();

    // 注册网络监听
    this.networkStatusListener.onChange((newNetworkStatus) {
      if (newNetworkStatus == null) {
        newNetworkStatus = NetworkStatus(false, ConnectivityResult.none);
      }
      var networkStatus = this._currentStatus;
      if (networkStatus == null) {
        return;
      }
      if (!networkStatus.isConnected && newNetworkStatus.isConnected) {
        // 网络被激活
        this.networkFailBack.onNetworkActive();
      }
      this._currentStatus = newNetworkStatus;
    });
  }

  Future<void> interceptor(ClientHttpRequest request) async {
    var currentStatus = this._currentStatus;
    var noneNetwork = currentStatus == null || !currentStatus.isConnected;
    if (noneNetwork) {
      return this._trySpinWait(request).catchError(this._handleFailBack);
    }
  }

  /// try spin wait network
  Future<void> _trySpinWait(ClientHttpRequest request) async {
    var tryWaitNetworkCount = this.tryWaitNetworkCount, spinWaitMaxTimes = this.spinWaitMaxTimes;

    if (tryWaitNetworkCount == 0) {
      return Future.error(request);
    }
    var random = Random();
    while (tryWaitNetworkCount-- > 0 && (this._currentStatus == null || !this._currentStatus.isConnected)) {
      // 自旋等待网络恢复
      var times = random.nextInt(spinWaitMaxTimes);
      if (times < 120) {
        times = 120;
      }
      await sleep(times);
      await this._initNetwork();
    }
  }

  // 无网络时的降级处理
  Future<void> _handleFailBack(ClientHttpRequest request) async {
    await this.networkFailBack.onNetworkClose(request);
  }

  void _initNetwork() {
    this.networkStatusListener.getNetworkStatus().then((networkStatus) {
      this._currentStatus = networkStatus;
    }).catchError((e) {
      this._currentStatus = NetworkStatus(false, ConnectivityResult.none);
    });
  }
}

Future<void> sleep(int milliseconds) {
  return Future.delayed(Duration(milliseconds: milliseconds));
}
