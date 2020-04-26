import '../feign_request_options.dart';

///  api signature strategy
abstract class ApiSignatureStrategy {
  /// sign
  void sign(List<String> fields, FeignRequestBaseOptions feignRequestBaseOptions);
}
