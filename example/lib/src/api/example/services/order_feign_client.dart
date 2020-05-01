import 'dart:io';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';

import '../../domain/order.dart';
import '../../resp/page_info.dart';
import '../../domain/user.dart';
import '../../evt/create_order_evt.dart';
import '../../evt/query_order_evt.dart';
import '../../domain/base_info.dart';
import '../../evt/base_evt.dart';
import '../../enums/sex.dart';
import '../../serializers.dart';
import '../../evt/base_query_evt.dart';

/// 接口：POST

@FeignClient(value: '/order',)
class OrderFeignClient extends FeignProxyClient {
  /// 1:接口方法：GET
  /// 2:返回值在java中的类型为：List
  /// 3:返回值在java中的类型为：Order
  @GetMapping()
  Future<BuiltList<Order>> getOrder(
      @RequestParam() List<String> names, @RequestHeader() List<num> ids, Set<Order> moneys,
      [UIOptions feignOptions]) {
    return this.delegateInvoke<BuiltList<Order>>(
        "getOrder",
        [
          names,
          ids,
          moneys,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(specifiedType: FullType(BuiltList, [FullType(Order)])));
  }

  /// 1:接口方法：GET
  /// 2:返回值在java中的类型为：PageInfo
  /// 3:返回值在java中的类型为：Order
  @GetMapping()
  Future<PageInfo<Order>> queryOrder(@RequestBody(true) QueryOrderEvt evt, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageInfo<Order>>(
        "queryOrder",
        [
          evt,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(
            serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(Order)])));
  }

  /// 1:接口方法：GET
  /// 2:返回值在java中的类型为：PageInfo
  /// 3:返回值在java中的类型为：Order
  @GetMapping()
  Future<PageInfo<Order>> queryOrder3(@RequestBody(true) List<QueryOrderEvt> evt, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageInfo<Order>>(
        "queryOrder3",
        [
          evt,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(
            serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(Order)])));
  }

  /// 1:接口方法：GET
  /// 2:返回值在java中的类型为：PageInfo
  /// 3:返回值在java中的类型为：Order
  @GetMapping()
  Future<PageInfo<Order>> queryOrder4(@RequestBody(true) Set<QueryOrderEvt> evt, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageInfo<Order>>(
        "queryOrder4",
        [
          evt,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(
            serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(Order)])));
  }

  /// 1:接口方法：GET
  /// 2:返回值在java中的类型为：PageInfo
  /// 3:返回值在java中的类型为：Order
  @GetMapping()
  Future<PageInfo<Order>> queryOrder5(@RequestBody(true) Map<String, QueryOrderEvt> evt, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageInfo<Order>>(
        "queryOrder5",
        [
          evt,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(
            serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(Order)])));
  }

  /// 1:接口方法：GET
  /// 2:返回值在java中的类型为：PageInfo
  /// 3:返回值在java中的类型为：Order
  @GetMapping()
  Future<PageInfo<Order>> queryOrder6(@RequestBody(true) List<QueryOrderEvt> evt, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageInfo<Order>>(
        "queryOrder6",
        [
          evt,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(
            serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(Order)])));
  }

  /// 1:接口方法：POST
  /// 2:返回值在java中的类型为：ServiceQueryResponse
  /// 3:返回值在java中的类型为：Order
  @PostMapping(
    produces: [HttpMediaType.MULTIPART_FORM_DATA],
  )
  Future<PageInfo<Order>> queryOrder2(@RequestParam("order_id") num oderId, String sn, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageInfo<Order>>(
        "queryOrder2",
        [
          oderId,
          sn,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(
            serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(Order)])));
  }

  /// 1:接口方法：POST
  /// 2:返回值在java中的类型为：ServiceResponse
  /// 3:返回值在java中的类型为：PageInfo
  /// 4:返回值在java中的类型为：Order
  @PostMapping()
  Future<PageInfo<Order>> queryPage(String id, [UIOptions feignOptions]) {
    return this.delegateInvoke<PageInfo<Order>>(
        "queryPage",
        [
          id,
        ],
        feignOptions: feignOptions,
        serializer: BuiltValueSerializable(
            serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(Order)])));
  }

  /// 1:接口方法：GET
  /// 2:返回值在java中的类型为：ServiceResponse
  /// 3:返回值在java中的类型为：Long
  @GetMapping()
  Future<num> createOrder(CreateOrderEvt evt, [UIOptions feignOptions]) {
    return this.delegateInvoke<num>(
      "createOrder",
      [
        evt,
      ],
      feignOptions: feignOptions,
    );
  }

  /// 1:接口方法：POST
  /// 2:返回值在java中的类型为：ServiceResponse
  @PostMapping()
  Future<Object> hello([UIOptions feignOptions]) {
    return this.delegateInvoke<Object>(
      "hello",
      [],
      feignOptions: feignOptions,
    );
  }
}

final orderFeignClient = OrderFeignClient();
