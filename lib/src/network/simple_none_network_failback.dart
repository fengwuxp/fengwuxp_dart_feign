import 'dart:async';
import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/client/http_request_completer.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/network/none_network_failback.dart';

/// simple network status listener
///
/// The current request is suspended when the network status is unavailable, waiting for a while, and the request is continued after the network is restored.
///  [SimpleNoneNetworkFailBack.maxWaitTime]
/// [ SimpleNoneNetworkFailBack.maxWaitLength]
class SimpleNoneNetworkFailBack<T extends ClientHttpRequest> implements NoneNetworkFailBack<T> {
  List<HttpRequestCompleter> _waitQueue = [];

  // max wait time millisecond
  final int maxWaitTime;

  // max wait queue length
  final int maxWaitLength;

  SimpleNoneNetworkFailBack({int maxWaitTime = 5 * 60 * 1000, int maxWaitLength = 16})
      : this.maxWaitTime = maxWaitTime,
        this.maxWaitLength = maxWaitLength;

  @override
  Future<T> onNetworkClose(T request) async {
    this._tryRemoveInvalidItem();
    return this._addWaitItem(request).future;
  }

  @override
  Future<void> onNetworkActive() async {
    var waitQueue = this._waitQueue;
    var oldLength = waitQueue.length;
    if (oldLength == 0) {
      return;
    }
    // 防止 onNetworkActive被多次调用
    this._waitQueue = [];
    waitQueue.removeWhere((item) {
      item.completer.complete(item.request);
      return true;
    });
    // clear
    waitQueue = [];
  }

  Completer<T> _addWaitItem(T request) {
    final waitQueue = this._waitQueue;
    if (waitQueue.length == maxWaitLength) {
      // 队列已满，强制移除掉第一个元素
      this._rejectHttpRequest(waitQueue.removeAt(0));
    }
    final completer = Completer<T>();
    this._waitQueue.add(HttpRequestCompleter(DateTime.now().millisecond + maxWaitTime, request, completer));
    return completer;
  }

  void _tryRemoveInvalidItem() {
    final waitQueue = this._waitQueue, maxWaitLength = this.maxWaitLength;
    var oldLength = waitQueue.length;
    if (oldLength == 0) {
      return;
    }
    final currentTime = DateTime.now().millisecond;
    waitQueue.removeWhere((item) {
      // 是否过期
      final isExpire = item.isExpire(currentTime);
      if (isExpire) {
        this._rejectHttpRequest(item);
      }
      return isExpire;
    });
    final newLength = waitQueue.length;
    if (newLength < maxWaitLength || newLength == 0) {
      return;
    }
    // remove first item
    this._rejectHttpRequest(waitQueue.removeAt(0));
  }

  void _rejectHttpRequest(HttpRequestCompleter _waitHttpRequest) {
    _waitHttpRequest.completer
        .completeError(new HttpException("token refresh failure", uri: _waitHttpRequest.request.url));
  }
}
