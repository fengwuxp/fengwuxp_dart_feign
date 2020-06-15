import 'dart:io';

import 'package:fengwuxp_dart_openfeign/index.dart';

/// http header content type name
//const CONTENT_TYPE_NAME = HttpHeaders.contentTypeHeader;

/// feign options 命名参数的名称
const FEIGN_OPTIONS_PARAMETER_NAME = "feignOptions";

const FEIGN_SERIALIZER_PARAMETER_NAME = "serializer";

/// request id header name
const REQUEST_ID_HEADER_NAME = 'Dart-Feign-Request-Id';

///  mock unauthorized response
final UNAUTHORIZED_RESPONSE = ResponseEntity(HttpStatus.unauthorized, {}, null, null);

/// mock gatewayTimeout response
final GATEWAY_TIME_RESPONSE = ResponseEntity(HttpStatus.gatewayTimeout, {}, null, null);

const NETWORK_NONE="network none";
