import 'dart:io';

import 'package:fengwuxp_dart_openfeign/index.dart';

/// feign options 命名参数的名称
const FEIGN_OPTIONS_PARAMETER_NAME = "feignOptions";

const FEIGN_SERIALIZER_PARAMETER_NAME = "serializer";

/// request id header name
const REQUEST_ID_HEADER_NAME = 'Dart-Feign-Client-Request-Id';

///  mock unauthorized response
final UNAUTHORIZED_RESPONSE = ResponseEntity(HttpStatus.unauthorized, {}, null, "unauthorized");

/// mock gatewayTimeout response
final GATEWAY_TIME_RESPONSE = ResponseEntity(HttpStatus.gatewayTimeout, {}, null, "gateway timeout");

const NETWORK_NONE = "network none";

const LB_SCHEMA = "lb";

