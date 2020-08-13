import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/path_variable.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_header.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_param.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/signature.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/authentication_type.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_proxy_client.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_request_options.dart';

import '../built/hello/hello.dart';
import '../built/req/query_hello_req.dart';

/// feign client
@Feign
@FeignClient(name: "hello_client", value: "/")
class HelloFeignClient extends FeignProxyClient {
  /// 返回具体类型
  /// 为了能够返回具体类型 骗过 dart运行时泛型匹配使用如下方式调用
  @GetMapping(value: "/", authenticationType: AuthenticationType.NONE)
  Future<Hello> getHello(@RequestHeader() String name, @RequestParam() num id, [UIOptions feignOptions]) {
    return this.delegateInvoke<Hello>("getHello", [name, id],
        feignOptions: feignOptions, serializer: BuiltValueSerializable(serializer: Hello.serializer));
  }

  /// 返回具体类型
  /// 为了能够返回具体类型 骗过 dart运行时泛型匹配使用如下方式调用
  @GetMapping(value: "/test")
  Future<String> getTest(@RequestHeader() String name, @RequestParam() BuiltList<num> id, [UIOptions feignOptions]) {
    return this.delegateInvoke<String>("getTest", [name, id], feignOptions: feignOptions);
  }

  /// 不返回具体类型  dart运行时泛型匹配的限制
  /// noSuchMethod 永远返回 Future<dynamic>
  @GetMapping(value: "/get_hello")
  Future getHelloForObject(@RequestHeader() String name, @RequestParam() num id, [UIOptions feignOptions]);

  @GetMapping(value: "/get_hello")
  @Signature(["id"])
  Future queryHello(QueryHelloReq req, [UIOptions feignOptions]);

  @GetMapping(value: "/get_hello/{id}")
  Future findHelloById(@PathVariable() String id, [UIOptions feignOptions]);

  @PutMapping(value: "/put_data_test")
  Future putDataTest(@RequestBody() QueryHelloReq req, [UIOptions feignOptions]);
}
