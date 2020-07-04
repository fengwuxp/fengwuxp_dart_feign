import 'dart:async';

import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/ui/request_progress_bar.dart';

/// 请求进度条拦截器
class ProcessBarExecutorInterceptor<T extends FeignBaseRequest> implements FeignClientExecutorInterceptor<T> {
  final RequestProgressBar progressBar;

  // 防止抖动，在接口很快响应的时候，不显示进度条
  final bool preventJitter;

  final ProgressBarOptions progressBarOptions;

  /// 进度条计数器，用于在同时发起多个请求时，
  /// 统一控制加载进度条
  int _count = 0;

  // timer
  Timer _timer;

  ProcessBarExecutorInterceptor(RequestProgressBar progressBar,
      {ProgressBarOptions progressBarOptions = const ProgressBarOptions()})
      : this.progressBar = progressBar,
        // 延迟显示的时间最少要大于等于100毫秒才会启用防止抖动的模式
        this.preventJitter = progressBarOptions.delay >= 100,
        this.progressBarOptions = progressBarOptions;

  @override
  Future<T> preHandle(T request, UIOptions uiOptions) async {
    if (!this._needShowProcessBar(uiOptions)) {
      return request;
    }

    if (this._count == 0) {
      // TODO 支持请求级别的 ProgressBarOptions配置
      var progressBar = this.progressBar, progressBarOptions = this.progressBarOptions;
      // 显示加载进度条
      if (this.preventJitter) {
        this._timer = Timer(Duration(milliseconds: progressBarOptions.delay), () {
          progressBar.showProgressBar(progressBarOptions);
        });
      } else {
        progressBar.showProgressBar(progressBarOptions);
      }
    }

    //计数器加一
    this._count++;
    return request;
  }

  Future postHandle<E>(T request, UIOptions uiOptions, E response, {BuiltValueSerializable serializer}) async {
    if (!this._needShowProcessBar(uiOptions)) {
      //不使用进度条
      return response;
    }
    _tryCloseProcessBar();
    return response;
  }

  Future postError<E>(T options, UIOptions uiOptions, error, {BuiltValueSerializable serializer}) {
    if (!this._needShowProcessBar(uiOptions)) {
      // 不使用进度条
      return Future.error(error);
    }
    _tryCloseProcessBar();
    //不使用进度条
    return Future.error(error);
  }

  bool _needShowProcessBar(UIOptions uiOptions) {
    if (uiOptions.useProgressBar == false) {
      //不使用进度条
      return false;
    }
    return true;
  }

  void _tryCloseProcessBar() {
    //计数器减一
    this._count--;
    if (this._count == 0) {
      //清除定时器
      if (this._timer != null) {
        this._timer.cancel();
      }
      //隐藏加载进度条
      progressBar.hideProgressBar();
    }
  }
}
