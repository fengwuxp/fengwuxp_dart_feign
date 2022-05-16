import 'package:fengwuxp_dart_openfeign/src/http/http_request.dart';

/// marked authentication strategy cache support
/// [CacheAuthenticationStrategy]
/// [AuthenticationClientHttpRequestInterceptor]
abstract class CacheCapableAuthenticationStrategy {
  /// clear cache
  /// if send send unauthorized event,need clear cache
  /// [AuthenticationBroadcaster.sendUnAuthorizedEvent]
  void clearCache();
}

/// authentication strategy
abstract class AuthenticationStrategy<T extends AuthenticationToken> {
  static const _DEFAULT_AUTHENTICATION_HEADER_NAMES = ["Authorization"];

  /// get authorization header names
  /// default :['Authorization']
  List<String> getAuthorizationHeaderNames() {
    return _DEFAULT_AUTHENTICATION_HEADER_NAMES;
  }

  Future<T> getAuthorization(HttpRequest request);

  Future<T> refreshAuthorization(T authorization, HttpRequest request);

  Map<String, String> appendAuthorizationHeader(T authorization, Map<String, String> headers) {
    headers.putIfAbsent(getAuthorizationHeaderNames().first, () => authorization.authorization);
    return headers;
  }
}

// never refresh token flag
const NEVER_REFRESH_FLAG = -1;

abstract class AuthenticationToken {
  /// authorization token
  String get authorization;

  /// refresh token
  String get refreshToken;

  /// token expire milli second
  /// if never refresh token ,return [NEVER_REFRESH_FLAG]
  int get expireDate;

  /// if never refresh token ,return [NEVER_REFRESH_FLAG]
  int? get refreshExpireDate;
}

