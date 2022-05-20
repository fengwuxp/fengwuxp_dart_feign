import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';
import 'package:fengwuxp_dart_openfeign/src/context/request_context_holder.dart';
import 'package:fengwuxp_dart_openfeign/src/event/http_response_event.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_request_options.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_response.dart';

class HttpErrorResponseEventPublisherExecutorInterceptor implements FeignClientExecutorInterceptor<FeignRequest> {
  final HttpResponseEventHandler _eventHandler;

  /// 对应的配置是否注册了统一错误回调
  /// @key 配置
  /// @value 是否已经注册了错误回调
  final Map<FeignConfiguration, bool> _registeredCaches = {};

  HttpErrorResponseEventPublisherExecutorInterceptor(this._eventHandler);

  static HttpErrorResponseEventPublisherExecutorInterceptor of([HttpResponseEventHandler? handler]) {
    return HttpErrorResponseEventPublisherExecutorInterceptor((request, response, options) {
      if (handler != null && options.useUnifiedToast) {
        handler(request, response, options);
      }
    });
  }

  Future<FeignRequest> preHandle(FeignRequest request, UIOptions uiOptions) async {
    return request;
  }

  /// in request after invoke
  /// [response]
  /// [options]
  Future postHandle<E>(FeignRequest request, UIOptions uiOptions, E response,
      {BuiltValueSerializable? serializer}) async {
    return response;
  }

  @override
  Future<void> postError(FeignRequest request, UIOptions uiOptions, error, {BuiltValueSerializable? serializer}) {
    if (error is Error || error is Exception) {
      return Future.error(error);
    }
    this._registerErrorListener(request, uiOptions);
    this._publishEvent(request, uiOptions, error);
    return Future.error(error);
  }

  _registerErrorListener(FeignRequest request, UIOptions uiOptions) {
    final feignConfiguration = getRequestFeignConfiguration(request);
    if (feignConfiguration == null) {
      return;
    }

    if (this._registeredCaches[feignConfiguration] ?? false) {
      return;
    }
    this._registeredCaches[feignConfiguration] = true;
    feignConfiguration.httpResponseEventListener.onError(this._eventHandler);
  }

  _publishEvent(FeignRequest request, UIOptions uiOptions, error) {
    final configuration = getRequestFeignConfiguration(request);
    if (configuration != null) {
      var statusCode = HttpStatus.internalServerError;
      if (error is ClientHttpResponse) {
        statusCode = error.statusCode;
      }
      configuration.httpResponseEventPublisher.publishEvent(request, uiOptions, error, statusCode);
    }
  }
}
