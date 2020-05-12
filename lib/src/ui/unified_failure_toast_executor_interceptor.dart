import 'dart:io';

import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';
import 'package:fengwuxp_dart_openfeign/src/executor/feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client/client_exception.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';

import '../feign_request_options.dart';

typedef void UnifiedFailureToast(ResponseEntity response);

/// 转换统一返回的错误数据的函数
/// [data]
/// [serializer]
typedef T TransformerResponseData<T>(data, BuiltValueSerializable serializer);

//  unified transform failure toast
class UnifiedFailureToastExecutorInterceptor<T extends FeignBaseRequest> implements FeignClientExecutorInterceptor<T> {
  TransformerResponseData _transformerResponseData;

  UnifiedFailureToastExecutorInterceptor(this._transformerResponseData);

  Future<T> preHandle(T request, UIOptions uiOptions) async {
    return request;
  }

  /// in request after invoke
  /// [options]
  /// [response]
  Future postHandle<E>(T request, UIOptions uiOptions, E response, {BuiltValueSerializable serializer}) async {
    return response;
  }

  /// in request failure invoke
  /// [options]
  /// [exception]
  Future postError<E>(T options, UIOptions uiOptions, error, {BuiltValueSerializable serializer}) {
    var result = error;
    if (error is ClientTimeOutException) {
      result = UNAUTHORIZED_RESPONSE;
    }
    if (error is Exception) {
      // 其他异常
      result = ResponseEntity(HttpStatus.internalServerError, {}, null, null);
    }
    if (result != error) {
      var isResponseEntity = serializer.specifiedType != null && serializer.specifiedType.root == ResponseEntity;
      result = isResponseEntity ? error : this._transformerResponseData(error, serializer);
    }
    if (error is ResponseEntity) {
      if (HttpStatus.unauthorized == result.statusCode) {
        // 发送需要登陆的广播
        getFeignConfiguration().authenticationBroadcaster?.sendUnAuthorizedEvent();
      }
    }
    _tryToast(result, uiOptions);
    return Future.error(result);
  }

  void _tryToast(resp, UIOptions uiOptions) {
    if (uiOptions.useUnifiedToast == false || uiOptions.useProgressBar == false) {
      return;
    }
    getFeignConfiguration().feignToastHandle(resp);
  }
}
