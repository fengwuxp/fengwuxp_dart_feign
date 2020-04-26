
import 'package:fengwuxp_dart_openfeign/src/client/clinet_http_response.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_request.dart';

///  Represents a client-side HTTP request.
abstract class ClientHttpRequest implements HttpRequest {

  /// Execute this request, resulting in a {@link [ClientHttpResponse]} that can be read.
  /// @return the response result of the execution
  /// @throws IOException in case of I/O errors
  ClientHttpResponse execute();
}
