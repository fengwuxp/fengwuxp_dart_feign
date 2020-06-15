import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/authentication_strategy.dart';

/// cache AuthenticationStrategy
/// [CacheCapableAuthenticationStrategy]
class CacheAuthenticationStrategy<T extends AuthenticationToken> implements AuthenticationStrategy<T> {
  AuthenticationStrategy<T> _authenticationStrategy;

  T _cacheAuthenticationToken;

  CacheAuthenticationStrategy(this._authenticationStrategy) {
    getFeignConfiguration().authenticationBroadcaster?.receiveAuthorizedEvent(this.clearCache);
  }

  @override
  List<String> getAuthorizationHeaderNames() {
    return this._authenticationStrategy.getAuthorizationHeaderNames();
  }

  @override
  Future<T> getAuthorization(Uri uri, Map<String, String> headers, String method) async {
    if (this._cacheAuthenticationToken == null) {
      this._cacheAuthenticationToken = await this._authenticationStrategy.getAuthorization(uri, headers, method);
    }
    return this._cacheAuthenticationToken;
  }

  @override
  Map<String, String> appendAuthorizationHeader(AuthenticationToken authorization, Map<String, String> headers) {
    return this._authenticationStrategy.appendAuthorizationHeader(authorization, headers);
  }

  @override
  Future<T> refreshAuthorization(T authorization, Uri uri, Map<String, String> headers, String method) async {
    this._cacheAuthenticationToken =
        await this._authenticationStrategy.refreshAuthorization(authorization, uri, headers, method);
    return this._cacheAuthenticationToken;
  }

  @override
  clearCache() {
    this._cacheAuthenticationToken = null;
  }
}
