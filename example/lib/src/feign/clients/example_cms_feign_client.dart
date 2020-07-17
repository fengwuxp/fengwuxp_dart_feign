import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';

import './example_cms_feign_client.reflectable.dart';


void main() {
 initializeReflectable();
}

     /// 接口：POST
    @FeignClient(value:'/example_cms',)
class ExampleCmsFeignClient extends FeignProxyClient {

    ExampleCmsFeignClient() : super() {
       main();
    }


               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：List
               /// 3:返回值在java中的类型为：Integer
                @GetMapping(value:'get_num',)
            Future<BuiltList<int>>  getNums(
  int num,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltList<int>>("getNums",
                   [num,],
                    feignOptions: feignOptions,
                        serializer: BuiltValueSerializable(
                        specifiedType:FullType(BuiltList,[FullType(int)])
                        )
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：List
               /// 3:返回值在java中的类型为：Map
               /// 4:返回值在java中的类型为：Integer
               /// 5:返回值在java中的类型为：String
                @GetMapping(value:'get_maps',)
            Future<BuiltList<BuiltMap<int,String>>>  getMaps(
  int num,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltList<BuiltMap<int,String>>>("getMaps",
                   [num,],
                    feignOptions: feignOptions,
                        serializer: BuiltValueSerializable(
                        specifiedType:FullType(BuiltList,[FullType(BuiltMap,[FullType(int),FullType(String)])])
                        )
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：Map
               /// 3:返回值在java中的类型为：String
               /// 4:返回值在java中的类型为：Integer
                @GetMapping(value:'get_map',)
            Future<BuiltMap<String,int>>  getMap(
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltMap<String,int>>("getMap",
                   [],
                    feignOptions: feignOptions,
                        serializer: BuiltValueSerializable(
                        specifiedType:FullType(BuiltMap,[FullType(String),FullType(int)])
                        )
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：Map
               /// 3:返回值在java中的类型为：String
               /// 4:返回值在java中的类型为：List
               /// 5:返回值在java中的类型为：Boolean
                @GetMapping(value:'get_map_2',)
            Future<BuiltMap<String,BuiltList<bool>>>  getMap2(
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltMap<String,BuiltList<bool>>>("getMap2",
                   [],
                    feignOptions: feignOptions,
                        serializer: BuiltValueSerializable(
                        specifiedType:FullType(BuiltMap,[FullType(String),FullType(BuiltList,[FullType(bool)])])
                        )
               );
            }
}




final exampleCmsFeignClient = ExampleCmsFeignClient();
