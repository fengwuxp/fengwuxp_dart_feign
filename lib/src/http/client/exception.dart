// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fengwuxp_dart_openfeign/src/http/client/base_request.dart';

/// An exception caused by an error in a pkg/http client.
class ClientException implements Exception {
  /// error message
  final String message;

  ///  request object
  final BaseRequest request;

  ClientException({this.message, this.request});

  @override
  String toString() => message;
}

/// request timeout exception
class ClientTimeOutException extends ClientException {
  ClientTimeOutException({String message, BaseRequest request}) : super(message: message, request: request);
}
