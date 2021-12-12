import 'dart:async';

import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/authentication_strategy.dart';
import 'package:fengwuxp_dart_openfeign/src/client/client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/client/http_request_completer.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/authentication_type.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';
import 'package:fengwuxp_dart_openfeign/src/context/request_context_holder.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:logging/logging.dart';

class AuthenticationClientHttpRequestInterceptor implements ClientHttpRequestInterceptor {
  static const String _TAG = "AuthenticationClientHttpRequestInterceptor";

  static final _log = Logger(_TAG);

  // Refresh tokens 5 minutes in advance by default
  int _aheadOfTimes = 0;

  // synchronous 'authorization' refresh
  bool _synchronousRefreshAuthorization = true;

  AuthenticationStrategy<AuthenticationToken> _authenticationStrategy;

  // is refreshing status
  bool _refreshing = false;

  // sync wait refresh token
  List<HttpRequestCompleter> _waitRequestQueue = [];

  AuthenticationClientHttpRequestInterceptor(AuthenticationStrategy authenticationStrategy,
      {int aheadOfTimes = 5 * 60 * 1000, bool blockingRefreshAuthorization = true})
      : this._authenticationStrategy = authenticationStrategy,
        this._aheadOfTimes = aheadOfTimes,
        this._synchronousRefreshAuthorization = blockingRefreshAuthorization;

  @override
  Future<ClientHttpRequest> interceptor(ClientHttpRequest request) async {
    final authenticationType = _getRequestAuthenticationType(request);
    if (!_requestRequiresAuthorization(authenticationType) || this._hasAuthorizationHeader(request.headers)) {
      return request;
    }

    final isTryAuthentication = authenticationType == AuthenticationType.TRY;
    AuthenticationToken? authorization;
    try {
      authorization = await this._authenticationStrategy.getAuthorization(request);
    } catch (e) {
      if (_log.isLoggable(Level.INFO)) {
        _log.info("get authorization failure", e);
      }
      if (isTryAuthentication) {
        return request;
      }

      /// @see [UnifiedFailureToastExecutorInterceptor]
      return Future.error(UNAUTHORIZED_RESPONSE);
    }

    final tokenNeverExpires = authorization.expireDate == NEVER_REFRESH_FLAG;
    if (tokenNeverExpires) {
      return request;
    }

    final expireTimes = DateTime.now().millisecond + _aheadOfTimes;
    final tokenEffective = authorization.expireDate > expireTimes;
    if (tokenEffective) {
      this._appendAuthorizationHeader(authorization, request.headers);
      return request;
    }

    // some time in advance {@code #aheadOfTimes}, the token is invalid and needs to be re-authenticated
    final refreshTokenEffective = (authorization.refreshExpireDate ?? authorization.expireDate) > expireTimes;
    if (refreshTokenEffective) {
      // refresh token
      authorization = await this._refreshAuthenticationToken(authorization, request);
      this._appendAuthorizationHeader(authorization, request.headers);
      return request;
    }

    if (isTryAuthentication) {
      return request;
    }
    return Future.error(UNAUTHORIZED_RESPONSE);
  }

  AuthenticationType _getRequestAuthenticationType(ClientHttpRequest request) {
    final requestMapping = getRequestMappingByRequest(request);
    if (requestMapping == null) {
      return AuthenticationType.NONE;
    }
    return requestMapping.authenticationType;
  }

  Future<AuthenticationToken> _refreshAuthenticationToken(
      AuthenticationToken refreshToken, ClientHttpRequest request) async {
    if (_synchronousRefreshAuthorization) {
      return _syncRefreshAuthenticationToken(request, refreshToken);
    }
    // Concurrent refresh
    return _refreshAuthenticationToken0(refreshToken, request);
  }

  Future<AuthenticationToken> _syncRefreshAuthenticationToken(
      ClientHttpRequest request, AuthenticationToken refreshToken) async {
    if (this._refreshing) {
      // join wait queue
      return this._waitRefreshToken(request);
    } else {
      // Synchronous refresh
      this._refreshing = true;
      // need refresh token
      var error, authorization;
      try {
        authorization = await _refreshAuthenticationToken0(refreshToken, request);
      } catch (e) {
        // refresh authorization error
        error = e;
      }
      _completeWaitQueue(authorization, error);
      this._refreshing = false;
      return authorization;
    }
  }

  Future<AuthenticationToken> _refreshAuthenticationToken0(
      AuthenticationToken refreshToken, ClientHttpRequest request) {
    try {
      return _authenticationStrategy.refreshAuthorization(refreshToken, request);
    } catch (e) {
      _log.warning("refresh token failure", e);
      if (e is Error) {
        return Future.error(UNAUTHORIZED_RESPONSE, e.stackTrace);
      }
      return Future.error(UNAUTHORIZED_RESPONSE);
    }
  }

  /// add wait request
  Future<AuthenticationToken> _waitRefreshToken(ClientHttpRequest request) {
    final completer = Completer<AuthenticationToken>();
    this._waitRequestQueue.add(HttpRequestCompleter(-1, request, completer));
    return completer.future;
  }

  void _completeWaitQueue(authorization, error) {
    final waitRequestQueue = this._waitRequestQueue;
    // clear
    this._waitRequestQueue = [];
    waitRequestQueue.removeWhere((item) {
      if (authorization != null) {
        item.completer.complete(authorization);
      } else {
        item.completer.completeError(error);
      }
      return true;
    });
  }

  /// append authorization header
  /// @param authorization
  /// @param headers
  void _appendAuthorizationHeader(AuthenticationToken? authorization, Map<String, String> headers) {
    this._authenticationStrategy.appendAuthorizationHeader(authorization as AuthenticationToken, headers);
  }

  /// need append authorization header
  /// [headers]
  bool _hasAuthorizationHeader(Map<String, String> headers) {
    final headerNames = this._authenticationStrategy.getAuthorizationHeaderNames();
    return headerNames.firstWhere((name) => StringUtils.hasText(headers[name])).length == headerNames.length;
  }

  bool _requestRequiresAuthorization(AuthenticationType authenticationType) {
    return authenticationType == AuthenticationType.FORCE || authenticationType == AuthenticationType.TRY;
  }

  set authenticationStrategy(AuthenticationStrategy authenticationStrategy) =>
      this._authenticationStrategy = _authenticationStrategy;
}
