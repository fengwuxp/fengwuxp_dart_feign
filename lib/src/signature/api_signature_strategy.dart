import '../feign_request_options.dart';

///  api signature strategy
abstract class ApiSignatureStrategy {
  /// sign
  /// [fields] 需要签名的字段名称
  /// [feignRequest] FeignBaseRequest
  void sign(List<String> fields, FeignBaseRequest feignRequest);
}

/// 签名异常
class SignatureException implements Exception{

  /// error message
  final String message;

  ///  request object
  final FeignBaseRequest request;

   SignatureException({this.message, this.request});

  @override
  String toString() => message;

}
