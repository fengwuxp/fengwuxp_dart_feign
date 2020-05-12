import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';

/// Downgrade processing without network
abstract class NoneNetworkFailBack<T extends ClientHttpRequest> {
  ///  Network is closed
  /// @param [request]
  Future<T> onNetworkClose(T request);

  /// Network is activated
  Future<void> onNetworkActive();
}

class DefaultNoneNetworkFailBack<T extends ClientHttpRequest> implements NoneNetworkFailBack<T> {
  @override
  Future<T> onNetworkClose(T request) {
    return Future.error(HttpException(NETWORK_NONE, uri: request.url));
  }

  @override
  Future<void> onNetworkActive() async {}
}
