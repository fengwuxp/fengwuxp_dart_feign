import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/authentication_strategy.dart';
import 'package:fengwuxp_dart_openfeign/src/http/http_request.dart';

/// cache AuthenticationStrategy
/// [CacheCapableAuthenticationStrategy]
class CacheAuthenticationStrategy<T extends AuthenticationToken> implements AuthenticationStrategy<T> {
  AuthenticationStrategy<T> _authenticationStrategy;

  T? _cacheAuthenticationToken;

  CacheAuthenticationStrategy(this._authenticationStrategy);

  @override
  List<String> getAuthorizationHeaderNames() {
    return this._authenticationStrategy.getAuthorizationHeaderNames();
  }

  @override
  Future<T> getAuthorization(HttpRequest request) async {
    if (this._cacheAuthenticationToken == null) {
      this._cacheAuthenticationToken = await this._authenticationStrategy.getAuthorization(request);
    }
    return this._cacheAuthenticationToken as T;
  }

  @override
  Map<String, String> appendAuthorizationHeader(T authorization, Map<String, String> headers) {
    return this._authenticationStrategy.appendAuthorizationHeader(authorization, headers);
  }

  @override
  Future<T> refreshAuthorization(T authorization, HttpRequest request) async {
    return this._authenticationStrategy.refreshAuthorization(authorization, request).then((value) {
      this._cacheAuthenticationToken = value;
      return value;
    }).catchError((error) {
      this.clearCache();
      return Future.error(error);
    });
  }

  @override
  clearCache() {
    this._cacheAuthenticationToken = null;
  }
}
