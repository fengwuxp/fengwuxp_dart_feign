import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/authentication_type.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_method.dart';

//typedef T ResultTransformer<T>(data);

abstract class ResultTransformer<T> {
  Future<T> transform(data);
}

class TypeResultTransformer<T> implements ResultTransformer<T> {
  const TypeResultTransformer();

  @override
  Future<T> transform(data) {
    return Future<T>.value(data);
  }
}

/// target class or method
///用于标记被feignClient注解标记的接口类
class RequestMapping {
  ///request uri
  final String value;

  ///request method
  ///default @see [FeignConfiguration]
  final String method;

  /// custom request header
  final Map<String, String> headers;

  ///The data type returned by the request interface,example: application/json
  ///default @see [FeignConfiguration]
  final List<String> consumes;

  ///Request data type submitted by the interface,example: application/json
  ///default @see [FeignConfiguration]
  final List<String> produces;

  /// timeout
  /// default @see [FeignConfiguration]
  /// ms
  final num timeout;

  /// need authentication information
  /// default @see [FeignConfiguration]
  final AuthenticationType authenticationType;

  /// 响应数据类型
  /// 由于dart的反射在面对复杂的泛型是无法得到正确的类型 使用手动传入得到形式
  /// 如果多个表示存在泛型，并且请按照嵌套顺序进行设置，如果是map的话 在map后面的2个元素 第一个表示map的key的类型 第二个表示值的类型
  /// 是集合数据类型 没有设置认为是dynamic
  /// 使用属性可以减少 reflectable 框架生成的元数据文件的大小
  ///
  /// TODO 允许自定义 ResponseParser 对这个属性进行解释，并转化
  /// 如果接口返回的对象有统一的抽象 可以简略配置
  /// 例如：接口统一响应 ServiceResp<T> 对象，这里只需要指名T对象的类型就可以了
//  final Serializer serializer;

  /// 用于“ 欺骗 ”dart 运行时泛型检查的机制
//  final ResultTransformer resultTransformer;

  const RequestMapping(
      {String value,
      String method,
      num timeout,
      AuthenticationType authenticationType,
      Map<String, String> headers,
      List<String> consumes,
      List<String> produces})
      : this.value = value,
        this.timeout = timeout,
        this.method = method,
        this.authenticationType = authenticationType ?? AuthenticationType.FORCE,
        this.headers = headers ?? const {},
        this.consumes = consumes ?? const [],
        this.produces = consumes ?? const [];
}

/// [GetMapping]
class GetMapping extends RequestMapping {
  const GetMapping(
      {String value,
      num timeout,
      Map<String, dynamic> headers,
      List<String> consumes,
      List<String> produces,
      AuthenticationType authenticationType,
      Serializer serializer,
      ResultTransformer resultTransformer})
      : super(
            value: value,
            timeout: timeout,
            method: HttpMethod.GET,
            headers: headers,
            authenticationType: authenticationType,
            consumes: consumes,
            produces: produces);
}

/// [PostMapping]
class PostMapping extends RequestMapping {
  const PostMapping(
      {String value,
      num timeout,
      Map<String, dynamic> headers,
      List<String> consumes,
      List<String> produces,
      AuthenticationType authenticationType,
      Serializer serializer,
      ResultTransformer resultTransformer})
      : super(
            value: value,
            timeout: timeout,
            method: HttpMethod.POST,
            headers: headers,
            authenticationType: authenticationType,
            consumes: consumes,
            produces: produces);
}

/// [PutMapping]
class PutMapping extends RequestMapping {
  const PutMapping(
      {String value,
      num timeout,
      Map<String, dynamic> headers,
      List<String> consumes,
      List<String> produces,
      AuthenticationType authenticationType,
      Serializer serializer,
      ResultTransformer resultTransformer})
      : super(
            value: value,
            timeout: timeout,
            method: HttpMethod.PUT,
            headers: headers,
            authenticationType: authenticationType,
            consumes: consumes,
            produces: produces);
}

/// [DeleteMapping]
class DeleteMapping extends RequestMapping {
  const DeleteMapping(
      {String value,
      num timeout,
      Map<String, dynamic> headers,
      List<String> consumes,
      List<String> produces,
      AuthenticationType authenticationType,
      Serializer serializer,
      ResultTransformer resultTransformer})
      : super(
            value: value,
            timeout: timeout,
            method: HttpMethod.DELETE,
            headers: headers,
            authenticationType: authenticationType,
            consumes: consumes,
            produces: produces);
}

/// [HeadMapping]
class HeadMapping extends RequestMapping {
  const HeadMapping(
      {String value,
      num timeout,
      Map<String, dynamic> headers,
      List<String> consumes,
      List<String> produces,
      AuthenticationType authenticationType,
      Serializer serializer,
      ResultTransformer resultTransformer})
      : super(
            value: value,
            timeout: timeout,
            method: HttpMethod.HEAD,
            headers: headers,
            authenticationType: authenticationType,
            consumes: consumes,
            produces: produces);
}

/// PatchMapping
class PatchMapping extends RequestMapping {
  const PatchMapping(
      {String value,
      num timeout,
      Map<String, dynamic> headers,
      List<String> consumes,
      List<String> produces,
      AuthenticationType authenticationType,
      Serializer serializer,
      ResultTransformer resultTransformer})
      : super(
            value: value,
            timeout: timeout,
            method: HttpMethod.PATCH,
            headers: headers,
            authenticationType: authenticationType,
            consumes: consumes,
            produces: produces);
}

const RequestMappingList = [
  RequestMapping,
  GetMapping,
  PostMapping,
  PutMapping,
  DeleteMapping,
  HeadMapping,
  PatchMapping
];
