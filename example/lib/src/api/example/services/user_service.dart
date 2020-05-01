import 'dart:io';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';

            import '../../domain/order.dart';
            import '../../resp/page_info.dart';
            import '../../domain/user.dart';
            import '../../domain/base_info.dart';
            import '../../enums/sex.dart';
            import '../../serializers.dart';

     /// 接口：POST

    @FeignClient(value:'/users',)
class UserService extends FeignProxyClient {




               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：User
                @GetMapping(value:'/{id}',)
            Future<User>  getUser(
                     @PathVariable()
                num id,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<User>("getUser",
                   [id,],
                    feignOptions: feignOptions,
                    serializer: BuiltValueSerializable(
                        serializer: User.serializer,
                    )
               );
            }

               /// 1:接口方法：PUT
               /// 2:返回值在java中的类型为：String
                @PutMapping(value:'/{id}',)
            Future<String>  putUser(
                     @PathVariable()
                num id,
                     @RequestBody(true)
                User user,
                     @RequestBody(true)
                Order order,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<String>("putUser",
                   [id,user,order,],
                    feignOptions: feignOptions,
               );
            }

               /// 1:接口方法：DELETE
               /// 2:返回值在java中的类型为：String
                @DeleteMapping(value:'/{id}',)
            Future<String>  deleteUser(
                     @PathVariable()
                num id,
  String name,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<String>("deleteUser",
                   [id,name,],
                    feignOptions: feignOptions,
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：String
                @GetMapping()
            Future<String>  sample(
  List<num> ids,
  String name,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<String>("sample",
                   [ids,name,],
                    feignOptions: feignOptions,
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：数组
               /// 3:返回值在java中的类型为：String
                @GetMapping(value:'sample3',)
            Future<BuiltList<String>>  sample2(
  List<num> ids,
  String name,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltList<String>>("sample2",
                   [ids,name,],
                    feignOptions: feignOptions,
                    serializer: BuiltValueSerializable(
                        specifiedType: FullType(BuiltList, [FullType(String)])
                    )
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：数组
               /// 3:返回值在java中的类型为：Map
               /// 4:返回值在java中的类型为：String
               /// 5:返回值在java中的类型为：数组
               /// 6:返回值在java中的类型为：User
                @GetMapping(value:'sample2',)
            Future<BuiltList<BuiltMap<String,BuiltList<User>>>>  sampleMap(
  List<num> ids,
  String name,
  Sex sex,
  List<Map<String,List<String>>> testParam,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltList<BuiltMap<String,BuiltList<User>>>>("sampleMap",
                   [ids,name,sex,testParam,],
                    feignOptions: feignOptions,
               );
            }

               /// 1:接口方法：POST
               /// 2:返回值在java中的类型为：void
                @PostMapping(produces:[HttpMediaType.MULTIPART_FORM_DATA],)
            Future<void>  uploadFile(
                     @RequestParam("file")
                File commonsMultipartFile,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<void>("uploadFile",
                   [commonsMultipartFile,],
                    feignOptions: feignOptions,
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：Map
               /// 3:返回值在java中的类型为：String
               /// 4:返回值在java中的类型为：Object
                @GetMapping(value:'/test',)
            Future<BuiltMap<String,Object>>  test3(
  num id,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltMap<String,Object>>("test3",
                   [id,],
                    feignOptions: feignOptions,
                    serializer: BuiltValueSerializable(
                        specifiedType: FullType(BuiltMap, [FullType(String,[FullType(Object)])])
                    )
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：ServiceResponse
               /// 3:返回值在java中的类型为：List
               /// 4:返回值在java中的类型为：PageInfo
               /// 5:返回值在java中的类型为：User
                @GetMapping(value:'/test2',)
            Future<BuiltList<PageInfo<User>>>  test4(
  num id,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltList<PageInfo<User>>>("test4",
                   [id,],
                    feignOptions: feignOptions,
                    serializer: BuiltValueSerializable(
                        specifiedType: FullType(BuiltList, [FullType(PageInfo,[FullType(User)])])
                    )
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：Map
               /// 3:返回值在java中的类型为：PageInfo
               /// 4:返回值在java中的类型为：User
               /// 5:返回值在java中的类型为：List
               /// 6:返回值在java中的类型为：PageInfo
               /// 7:返回值在java中的类型为：User
                @GetMapping(value:'/test5',)
            Future<BuiltMap<PageInfo<User>,BuiltList<PageInfo<User>>>>  test5(
  num id,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltMap<PageInfo<User>,BuiltList<PageInfo<User>>>>("test5",
                   [id,],
                    feignOptions: feignOptions,
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：Map
               /// 3:返回值在java中的类型为：PageInfo
               /// 4:返回值在java中的类型为：数组
               /// 5:返回值在java中的类型为：User
               /// 6:返回值在java中的类型为：List
               /// 7:返回值在java中的类型为：PageInfo
               /// 8:返回值在java中的类型为：数组
               /// 9:返回值在java中的类型为：User
                @GetMapping(value:'/test6',)
            Future<BuiltMap<PageInfo<BuiltList<User>>,BuiltList<PageInfo<BuiltList<User>>>>>  test6(
  num id,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltMap<PageInfo<BuiltList<User>>,BuiltList<PageInfo<BuiltList<User>>>>>("test6",
                   [id,],
                    feignOptions: feignOptions,
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：Map
               /// 3:返回值在java中的类型为：PageInfo
               /// 4:返回值在java中的类型为：数组
               /// 5:返回值在java中的类型为：数组
               /// 6:返回值在java中的类型为：User
               /// 7:返回值在java中的类型为：List
               /// 8:返回值在java中的类型为：PageInfo
               /// 9:返回值在java中的类型为：数组
               /// 10:返回值在java中的类型为：数组
               /// 11:返回值在java中的类型为：User
                @GetMapping(value:'/test7',)
            Future<BuiltMap<PageInfo<BuiltList<BuiltList<User>>>,BuiltList<PageInfo<BuiltList<BuiltList<User>>>>>>  test7(
  num id,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltMap<PageInfo<BuiltList<BuiltList<User>>>,BuiltList<PageInfo<BuiltList<BuiltList<User>>>>>>("test7",
                   [id,],
                    feignOptions: feignOptions,
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：Map
               /// 3:返回值在java中的类型为：数组
               /// 4:返回值在java中的类型为：String
               /// 5:返回值在java中的类型为：数组
               /// 6:返回值在java中的类型为：数组
               /// 7:返回值在java中的类型为：数组
               /// 8:返回值在java中的类型为：数组
               /// 9:返回值在java中的类型为：String
                @GetMapping(value:'/test8',)
            Future<BuiltMap<BuiltList<String>,BuiltList<BuiltList<BuiltList<BuiltList<String>>>>>>  test8(
  num id,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltMap<BuiltList<String>,BuiltList<BuiltList<BuiltList<BuiltList<String>>>>>>("test8",
                   [id,],
                    feignOptions: feignOptions,
               );
            }

               /// 1:接口方法：GET
               /// 2:返回值在java中的类型为：数组
               /// 3:返回值在java中的类型为：数组
               /// 4:返回值在java中的类型为：数组
               /// 5:返回值在java中的类型为：Map
               /// 6:返回值在java中的类型为：数组
               /// 7:返回值在java中的类型为：数组
               /// 8:返回值在java中的类型为：String
               /// 9:返回值在java中的类型为：数组
               /// 10:返回值在java中的类型为：String
                @GetMapping(value:'/test9',)
            Future<BuiltList<BuiltList<BuiltList<BuiltMap<BuiltList<BuiltList<String>>,BuiltList<String>>>>>>  test9(
  num id,
             [UIOptions feignOptions]) {
               return this.delegateInvoke<BuiltList<BuiltList<BuiltList<BuiltMap<BuiltList<BuiltList<String>>,BuiltList<String>>>>>>("test9",
                   [id,],
                    feignOptions: feignOptions,
               );
            }
}

final userService = UserService();
