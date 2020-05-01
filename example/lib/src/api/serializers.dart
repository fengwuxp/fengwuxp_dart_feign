// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:fengwuxp_dart_openfeign/src/built/date_time_serializer.dart';

            import './resp/page_info.dart';
            import './domain/order.dart';
            import './evt/base_query_evt.dart';
            import './domain/base_info.dart';
            import './enums/sex.dart';
            import './evt/create_order_evt.dart';
            import './evt/query_order_evt.dart';
            import './evt/base_evt.dart';
            import './domain/user.dart';

part 'serializers.g.dart';

/// Example of how to use built_value serialization.
///
/// Declare a top level [Serializers] field called serializers. Annotate it
/// with [SerializersFor] and provide a `const` `List` of types you want to
/// be serializable.
///
/// The built_value code generator will provide the implementation. It will
/// contain serializers for all the types asked for explicitly plus all the
/// types needed transitively via fields.
///
/// You usually only need to do this once per project.
@SerializersFor(const [
     PageInfo,
     Order,
     BaseQueryEvt,
     BaseInfo,
     Sex,
     CreateOrderEvt,
     QueryOrderEvt,
     BaseEvt,
     User,
])

final Serializers serializers = (_$serializers.toBuilder()
         ..addPlugin(StandardJsonPlugin())
              ..addBuilderFactory(
              FullType(BuiltMap,[FullType(String),FullType(Object)]),
               () => MapBuilder<String,Object>())
              ..addBuilderFactory(
              FullType(BuiltList,[FullType(Order)]),
               () => ListBuilder<Order>())
              ..addBuilderFactory(
              FullType(PageInfo,[FullType(Order)]),
               () => PageInfoBuilder<Order>())
              ..addBuilderFactory(
              FullType(BuiltList,[FullType(BuiltMap,[FullType(String),FullType(BuiltList,[FullType(User)])])]),
               () => ListBuilder<BuiltMap<String,BuiltList<User>>>())
              ..addBuilderFactory(
              FullType(BuiltList,[FullType(String)]),
               () => ListBuilder<String>())
              ..addBuilderFactory(
              FullType(BuiltList,[FullType(PageInfo,[FullType(User)])]),
               () => ListBuilder<PageInfo<User>>())
         ..add(DateTimeMillisecondsSerializer()))
         .build();
