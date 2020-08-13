import 'dart:async';

import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/client/authentication_strategy.dart';
import 'package:fengwuxp_dart_openfeign/src/client/client_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/authentication_type.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';
import 'package:fengwuxp_dart_openfeign/src/context/request_context_holder.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/network/simple_none_network_failback.dart';

class AuthenticationClientHttpRequestInterceptor implements ClientHttpRequestInterceptor {
  // Refresh tokens 5 minutes in advance by default
  int _aheadOfTimes;

  // blocking 'authorization' refresh
  bool _blockingRefreshAuthorization;

  AuthenticationStrategy _authenticationStrategy;

  // is refreshing status
  bool _refreshing = false;

  // sync wait refresh token
  List<WaitHttpRequest<ClientHttpRequest>> _syncQueue = [];

  AuthenticationClientHttpRequestInterceptor(AuthenticationStrategy authenticationStrategy,
      {int aheadOfTimes, bool blockingRefreshAuthorization}) {
    this._authenticationStrategy = authenticationStrategy;
    this._aheadOfTimes = aheadOfTimes ?? 5 * 60 * 1000;
    this._blockingRefreshAuthorization = blockingRefreshAuthorization ?? true;
  }

  @override
  Future<void> interceptor(ClientHttpRequest request) async {
    var requestMapping = getRequestMappingByRequest(request);
    var isTryAuthentication = false;
    if (requestMapping != null) {
      final authenticationType = requestMapping.authenticationType;
      if (authenticationType == AuthenticationType.NONE) {
        // none certification
        return request;
      }
      isTryAuthentication = authenticationType == AuthenticationType.TRY;
    }

    if (!this._needAppendAuthorizationHeader(request.headers)) {
      // Prevent recursion on refresh
      return request;
    }

    final aheadOfTimes = this._aheadOfTimes,
        blockingRefreshAuthorization = this._blockingRefreshAuthorization,
        authenticationStrategy = this._authenticationStrategy;
    AuthenticationToken authorization;
    try {
      authorization = await authenticationStrategy.getAuthorization(request.url, request.headers, request.method);
    } catch (e) {
      if (isTryAuthentication) {
        return request;
      }

      /// see[UnifiedFailureToastExecutorInterceptor]
      return Future.error(UNAUTHORIZED_RESPONSE);
    }

    if (authorization == null || !StringUtils.hasText(authorization.authorization)) {
      if (isTryAuthentication) {
        return request;
      }
      return Future.error(UNAUTHORIZED_RESPONSE);
    }

    final currentTimes = DateTime.now().millisecond;
    final tokenIsNever = authorization.expireDate == NEVER_REFRESH_FLAG;
    final refreshTokenIsNever = authorization.refreshExpireDate == NEVER_REFRESH_FLAG;
    final refreshTokenIsInvalid =
        authorization.refreshExpireDate <= currentTimes + aheadOfTimes && !refreshTokenIsNever;
    if (refreshTokenIsInvalid && !tokenIsNever) {
      // 20 seconds in advance, the token is invalid and needs to be re-authenticated
      if (isTryAuthentication) {
        return request;
      }
      // refresh token invalid ,need authorization
      return Future.error(UNAUTHORIZED_RESPONSE);
    }

    final authorizationIsInvalid = authorization.expireDate <= currentTimes + aheadOfTimes && !tokenIsNever;
    if (!authorizationIsInvalid) {
      this._appendAuthorizationHeader(authorization, request.headers);
      return request;
    }

    if (!blockingRefreshAuthorization) {
      // Concurrent refresh
      try {
        authorization = await authenticationStrategy.refreshAuthorization(
            authorization, request.url, request.headers, request.method);
      } catch (e) {
        return Future.error(UNAUTHORIZED_RESPONSE);
      }
    } else {
      if (this._refreshing) {
        // join wait queue
        return this._addWaitItem(request).future;
      } else {
        // Synchronous refresh
        this._refreshing = true;
        // need refresh token
        var error;
        try {
          authorization = await authenticationStrategy.refreshAuthorization(
              authorization, request.url, request.headers, request.method);
        } catch (e) {
          // refresh authorization error
          return Future.error(UNAUTHORIZED_RESPONSE);
        }
        this._refreshing = false;
        // clear
        var syncQueue = this._syncQueue;
        if (syncQueue.length > 0) {
          this._syncQueue = [];
          syncQueue.removeWhere((item) {
            if (error) {
              item.completer.completeError(error);
            } else {
              this._appendAuthorizationHeader(authorization, request.headers);
              item.completer.complete();
            }
            return true;
          });
        }
      }
    }

    this._appendAuthorizationHeader(authorization, request.headers);
    return request;
  }

  /// add wait request
  Completer<void> _addWaitItem(ClientHttpRequest request) {
    final syncQueue = this._syncQueue;
    final completer = Completer<void>();
    syncQueue.add(WaitHttpRequest(-1, request, completer));
    return completer;
  }

  /// append authorization header
  /// @param authorization
  /// @param headers
  void _appendAuthorizationHeader(AuthenticationToken authorization, Map<String, String> headers) {
    this._authenticationStrategy.appendAuthorizationHeader(authorization, headers);
  }

  /// need append authorization header
  /// [headers]
  bool _needAppendAuthorizationHeader(Map<String, String> headers) {
    final headerNames = this._authenticationStrategy.getAuthorizationHeaderNames() ?? ["Authorization"];
    return headerNames.map((name) => headers[name] != null ? 1 : 0).reduce((i1, i2) => i1 + i2) != headerNames.length;
  }

  set authenticationStrategy(AuthenticationStrategy authenticationStrategy) =>
      this._authenticationStrategy = _authenticationStrategy;
}
