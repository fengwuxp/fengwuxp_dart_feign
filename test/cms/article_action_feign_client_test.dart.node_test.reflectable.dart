// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.

import 'dart:core';

import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart'
    as prefix0;
import 'package:reflectable/mirrors.dart' as m;
import 'package:reflectable/reflectable.dart' as r show Reflectable;
import 'package:reflectable/src/reflectable_builder_based.dart' as r;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.DartFeignClient(): r.ReflectorData(
      <m.TypeMirror>[],
      <m.DeclarationMirror>[],
      <m.ParameterMirror>[],
      <Type>[],
      0,
      {},
      {},
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
