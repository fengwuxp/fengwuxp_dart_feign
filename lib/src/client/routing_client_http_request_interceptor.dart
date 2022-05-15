import 'package:fengwuxp_dart_openfeign/src/client/client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/context/request_url_mapping_holder.dart';

import '../http/client_http_request.dart';

typedef RouteMappingsSupplier = Future<Map<String, String>> Function();

/// If the url starts with @xxx, replace 'xxx' with the value of name='xxx' in the routeMapping
/// example url='lb://memberModule/find_member  routeMapping = {memberModule:"http://test.a.b.com/member"}
/// ==> 'http://test.a.b.com/member/find_member'
class RoutingClientHttpRequestInterceptor implements ClientHttpRequestInterceptor {
  final RouteMappingsSupplier supplier;

  RoutingClientHttpRequestInterceptor(this.supplier);

  static form(String apiEntry) {
    return RoutingClientHttpRequestInterceptor(() => Future.value({"default": apiEntry}));
  }

  static fromMapping(Map<String, String> routeMappings) {
    return RoutingClientHttpRequestInterceptor(() => Future.value(routeMappings));
  }

  static fromSupplier(RouteMappingsSupplier supplier) {
    return RoutingClientHttpRequestInterceptor(supplier);
  }

  Future<ClientHttpRequest> interceptor(ClientHttpRequest request) {
    return this.supplier().then((routes) {
      request.uri(routing(request.url, routes));
      return Future.value(request);
    });
  }
}
