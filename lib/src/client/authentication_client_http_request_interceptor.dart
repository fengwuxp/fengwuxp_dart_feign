import 'dart:async';
import 'dart:io';

import 'package:fengwuxp_dart_openfeign/src/cache_capable_support.dart';
import 'package:fengwuxp_dart_openfeign/src/client/authentication_strategy.dart';
import 'package:fengwuxp_dart_openfeign/src/client/cache_authentication_strategy.dart';
import 'package:fengwuxp_dart_openfeign/src/client/cient_http_request_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/context/request_context_holder.dart';
import 'package:fengwuxp_dart_openfeign/src/http/client_http_request.dart';
import 'package:fengwuxp_dart_openfeign/src/network/simple_none_network_failback.dart';

class AuthenticationClientHttpRequestInterceptor implements ClientHttpRequestInterceptor {
  // Refresh tokens 5 minutes in advance by default
  int _aheadOfTimes;

  // blocking 'authorization' refresh
  bool _blockingRefreshAuthorization;

  AuthenticationStrategy _authenticationStrategy;

  // In the loose mode, it only tries to obtain the authentication information. If it does not obtain it, it does nothing.
  bool _looseMode = true;

  // is refreshing status
  bool _refreshing = false;

  // sync wait refresh token
  List<WaitHttpRequest<ClientHttpRequest>> _syncQueue = [];

  AuthenticationClientHttpRequestInterceptor(AuthenticationStrategy authenticationStrategy,
      {int aheadOfTimes, bool looseMode, bool blockingRefreshAuthorization}) {
    if (authenticationStrategy is CacheCapableSupport) {
      this._authenticationStrategy = new CacheAuthenticationStrategy(authenticationStrategy);
    } else {
      this._authenticationStrategy = authenticationStrategy;
    }
    this._aheadOfTimes = aheadOfTimes ?? 5 * 60 * 1000;
    this._blockingRefreshAuthorization = blockingRefreshAuthorization ?? true;
    this._looseMode = looseMode ?? true;
  }

  @override
  Future<void> interceptor(ClientHttpRequest request) async {
    final looseMode = this._looseMode;
    // need force certification
    var forceCertification = !looseMode, onlyTryGetToken = false;
    var requestMapping = getRequestMappingByRequest(request);
    if (requestMapping != null) {
      if (requestMapping.needCertification == false) {
        // none certification
        // return req;
        if (looseMode) {
          forceCertification = false;
          onlyTryGetToken = true;
        } else {
          return request;
        }
      }
      if (requestMapping.needCertification == true) {
        // force none certification
        forceCertification = true;
      }
    }
    if (!this._needAppendAuthorizationHeader(request.headers)) {
      // Prevent recursion on refresh
      return request;
    }

//    final {aheadOfTimes, blockingRefreshAuthorization, authenticationStrategy} = this;
    final aheadOfTimes = this._aheadOfTimes,
        blockingRefreshAuthorization = this._blockingRefreshAuthorization,
        authenticationStrategy = this._authenticationStrategy;
    AuthenticationToken authorization;
    try {
      authorization = await authenticationStrategy.getAuthorization(request.url, request.headers, request.method);
    } catch (e) {
      if (!forceCertification) {
        return request;
      }
      return Future.error(HttpException("authorization is null", uri: request.url));
    }

    if (authorization == null) {
      return Future.error(HttpException("authorization is null", uri: request.url));
    }

    final needRefreshAuthorization =
        !onlyTryGetToken || authorization.expireDate < DateTime.now().millisecond + aheadOfTimes;
    if (authorization.expireDate == NEVER_REFRESH_FLAG || !needRefreshAuthorization) {
      this._appendAuthorizationHeader(authorization, request.headers);
      return request;
    }

    if (!blockingRefreshAuthorization) {
      // Concurrent refresh
      try {
        authorization = await authenticationStrategy.refreshAuthorization(
            authorization, request.url, request.headers, request.method);
      } catch (e) {
        if (!forceCertification) {
          return request;
        }
        // refresh authorization error
        return Future.error(HttpException("refresh authorization error", uri: request.url));
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
          error = e;
          if (!looseMode) {
            return Future.error(e);
          }
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
