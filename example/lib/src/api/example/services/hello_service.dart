import 'dart:io';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';



class HelloService extends FeignProxyClient {




               /// 1:接口方法：GET
               /// 2:Documented with OpenAPI v3 annotations
               /// 3:返回值在java中的类型为：String
                @GetMapping(value:'/hello',)
            Future<String>  index(
             [UIOptions feignOptions]) {
               return this.delegateInvoke<String>("index",
                   [],
                    feignOptions: feignOptions,
               );
            }
}

final helloService = HelloService();
