import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test completer', ()async {
// 实例化一个Completer
    var completer = Completer();
// 这里可以拿到这个completer内部的Future
    var future = completer.future;
// 需要的话串上回调函数。
    future.then((value) => print('$value'));

// 设置为完成状态
    completer.complete("done");
  });
}
