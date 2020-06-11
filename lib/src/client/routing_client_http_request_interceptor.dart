import 'package:fengwuxp_dart_openfeign/src/client/client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/context/request_url_mapping_holder.dart';

import '../http/client_http_request.dart';

/// If the url starts with @xxx, replace 'xxx' with the value of name='xxx' in the routeMapping
/// example url='@memberModule/find_member  routeMapping = {memberModule:"http://test.a.b.com/member"}
/// ==> 'http://test.a.b.com/member/find_member'
class RoutingClientHttpRequestInterceptor implements ClientHttpRequestInterceptor {
  Map<String, String> _routeMapping;

  RoutingClientHttpRequestInterceptor(routeMapping) {
    if (routeMapping is String) {
      this._routeMapping = {"default": routeMapping};
    } else {
      this._routeMapping = routeMapping;
    }
  }

  /// [routeMapping] String or Map<String,String>
  factory(routeMapping) {
    return new RoutingClientHttpRequestInterceptor(routeMapping);
  }

  Future<void> interceptor(ClientHttpRequest request) {
    request.uri(routing(request.url, this._routeMapping));
    return Future.value();
  }
}
