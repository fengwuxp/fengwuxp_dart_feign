import 'package:fengwuxp_dart_openfeign/src/cache_capable_support.dart';

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
abstract class AuthenticationStrategy<T extends AuthenticationToken> implements CacheCapableSupport {
  /// get authorization header names
  /// default :['Authorization']
  List<String> getAuthorizationHeaderNames() {
    return ["Authorization"];
  }

  Future<T> getAuthorization(Uri uri, Map<String, String> headers, String method);

  Future<T> refreshAuthorization(T authorization, Uri uri, Map<String, String> headers, String method);

  Map<String, String> appendAuthorizationHeader(T authorization, Map<String, String> headers) {
    headers.putIfAbsent(getAuthorizationHeaderNames().first, () => authorization.authorization);
    return headers;
  }
}

// never refresh token flag
const NEVER_REFRESH_FLAG = -1;

abstract class AuthenticationToken {
  String get authorization;

  //if never refresh token ,return [NEVER_REFRESH_FLAG]
  int get expireDate;
}

/// use broadcast event handle authentication
/// {@see HttpStatus.UNAUTHORIZED}
abstract class AuthenticationBroadcaster {
  /// send unauthorized event
  void sendUnAuthorizedEvent();

  /// receive authorized success event
  /// [handle]
  receiveAuthorizedEvent(void handle());
}
