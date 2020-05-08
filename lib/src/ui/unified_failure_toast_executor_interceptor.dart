import 'dart:io';

import 'package:fengwuxp_dart_openfeign/index.dart';
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
//    var isResponseEntity = serializer.specifiedType != null && serializer.specifiedType.root == ResponseEntity;
//
//    if (response.ok) {
//      if (isResponseEntity) {
//        return response;
//      } else {
//        return response.body;
//      }
//    }
//    var result = isResponseEntity ? response : this._transformerResponseData(response, serializer);
//    if (HttpStatus.unauthorized == response.statusCode) {
//      // 发送需要登陆的广播
//      getFeignConfiguration().authenticationBroadcaster?.sendUnAuthorizedEvent();
//    }
//    return Future.error(result);
    return response;
  }

  /// in request failure invoke
  /// [options]
  /// [exception]
  Future postError<E>(T options, UIOptions uiOptions, error, {BuiltValueSerializable serializer}) {
    if (error is ClientException) {
      return Future.error(ResponseEntity(HttpStatus.internalServerError, {}, null, "request exception"));
    }
    if (error is ClientTimeOutException) {
      return Future.error(ResponseEntity(HttpStatus.gatewayTimeout, {}, null, "client timeout exception"));
    }
    var isResponseEntity = serializer.specifiedType != null && serializer.specifiedType.root == ResponseEntity;
    var result = isResponseEntity ? error : this._transformerResponseData(error, serializer);
    if (error is ResponseEntity) {
      if (HttpStatus.unauthorized == result.statusCode) {
        // 发送需要登陆的广播
        getFeignConfiguration().authenticationBroadcaster?.sendUnAuthorizedEvent();
      }
    }
    return Future.error(result);
  }
}
