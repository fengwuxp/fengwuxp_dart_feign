import 'dart:async';
import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/network/none_network_failback.dart';

/// simple network status listener
///
/// The current request is suspended when the network status is unavailable, waiting for a while, and the request is continued after the network is restored.
///  [SimpleNoneNetworkFailBack.maxWaitTime]
/// [ SimpleNoneNetworkFailBack.maxWaitLength]
class SimpleNoneNetworkFailBack<T extends ClientHttpRequest> implements NoneNetworkFailBack<T> {
  List<WaitHttpRequest<T>> _waitQueue = [];

  // max wait time millisecond
  final int maxWaitTime;

  // max wait queue length
  final int maxWaitLength;

  SimpleNoneNetworkFailBack({
    int maxWaitTime,
    int maxWaitLength,
  })  : this.maxWaitTime = maxWaitTime ?? 5 * 60 * 1000,
        this.maxWaitLength = maxWaitLength ?? 16;

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
    waitQueue = null;
  }

  Completer<T> _addWaitItem(T request) {
    final waitQueue = this._waitQueue;
    if (waitQueue.length == maxWaitLength) {
      // 队列已满，强制移除掉第一个元素
      this._rejectHttpRequest(waitQueue.removeAt(0));
    }
    final completer = Completer<T>();
    this._waitQueue.add(WaitHttpRequest(DateTime.now().millisecond + maxWaitTime, request, completer));
    return completer;
  }

  void _tryRemoveInvalidItem() {
    final waitQueue = this._waitQueue, maxWaitLength = this.maxWaitLength;
    var oldLength = waitQueue.length;
    if (oldLength == 0) {
      return;
    }
    var currentTime = DateTime.now().millisecond;
    waitQueue.removeWhere((item) {
      // 是否还在有效期内
      var isEffective = currentTime - item.expireTime < 0;
      var needRemove = !isEffective;
      if (needRemove) {
        this._rejectHttpRequest(item);
      }
      return needRemove;
    });
    var newLength = waitQueue.length;
    if (newLength < maxWaitLength || newLength == 0) {
      return;
    }
    // remove first item
    this._rejectHttpRequest(waitQueue.removeAt(0));
  }

  void _rejectHttpRequest(WaitHttpRequest<T> _waitHttpRequest) {
    _waitHttpRequest.completer.completeError(new HttpException("网络不可用", uri: _waitHttpRequest.request.url));
  }
}

class WaitHttpRequest<T> {
  final int expireTime;

  final T request;

  final Completer completer;

  WaitHttpRequest(this.expireTime, this.request, this.completer);
}
