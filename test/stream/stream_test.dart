import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test stream periodic", () async {
    // 可以在回调函数中对值进行处理，这里直接返回了
    int callback(int value) {
      return value;
    }

    // 使用 periodic 创建流，第一个参数为间隔时间，第二个参数为回调函数
    Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
    // await for循环从流中读取
    await for (var i in stream) {
      print(i);
    }
  });

  test("test stream fromFuture", () async {
    print("test start");
    Future<String> fut = Future(() {
      return "async task";
    });

    // 从Future创建Stream
    Stream<String> stream = Stream<String>.fromFuture(fut);
    await for (var s in stream) {
      print(s);
    }
    print("test end");
  });

  test("test stream fromFutures", () async {
    Future<String> fut1 = Future(() {
      // 模拟耗时5秒
      sleep(Duration(seconds: 5));
      return "async task1";
    });
    Future<String> fut2 = Future(() {
      return "async task2";
    });

    // 将多个Future放入一个列表中，将该列表传入
    Stream<String> stream = Stream<String>.fromFutures([fut1, fut2]);
    await for (var s in stream) {
      print(s);
    }
    print("test end");
  });

  test("test stream fromIterable", () async {
    // 从一个列表创建`Stream`
    Stream<int> stream = Stream<int>.fromIterable([1, 2, 3]);
    await for (var s in stream) {
      print(s);
    }
  });

  test("test stream value", () async {
    Stream<bool> stream = Stream<bool>.value(false);
    // await for循环从流中读取
    await for (var i in stream) {
      print(i);
    }
  });

  test("test stream listen", () async {
    // 可以在回调函数中对值进行处理，这里直接返回了
    int callback(int value) {
      return value;
    }

    Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
    stream.listen((x) => print(x), onError: (e) => print(e), onDone: () => print("onDone"));
  });

  test("test stream take", () async {
    // 可以在回调函数中对值进行处理，这里直接返回了
    int callback(int value) {
      return value;
    }

    Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
    // 当放入三个元素后，监听会停止，Stream会关闭
    stream = stream.take(3);

    stream.takeWhile((x) {
      // 对当前元素进行判断，不满足条件则取消监听
      return x <= 3;
    });

    await for (var i in stream) {
      print(i);
    }
  });

  test("test stream skip", () async {
    // 可以在回调函数中对值进行处理，这里直接返回了
    int callback(int value) {
      return value;
    }

    Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
    stream = stream.take(5);
    // 表示从Stream中跳过两个元素
    stream = stream.skip(2);

    await for (var i in stream) {
      print(i);
    }
  });

  test("test stream toList", () async {
    // 可以在回调函数中对值进行处理，这里直接返回了
    int callback(int value) {
      return value;
    }

    Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
    stream = stream.take(5);
    var len = await stream.length;
    print(len);
    List<int> data = await stream.toList();
    for (var i in data) {
      print(i);
    }
  });

  test("test stream broadcast", () {
    // 调用 Stream 的 asBroadcastStream 方法创建
    Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (e) => e).asBroadcastStream();
    stream = stream.take(5);

    stream.listen((v) => print("=1=>$v"));
    stream.listen((v) => print("=2=>$v"));
  });

  test('test stream controller', () {
//    任意类型的流
//    StreamController controller = StreamController();
//    controller.sink.add(123);
//    controller.sink.add("xyz");
//    controller.sink.add("b");
    StreamController<int> controller = StreamController<int>();
    controller.sink.add(123);
    final transformer = StreamTransformer<int, String>.fromHandlers(handleData: (value, sink) {
      if (value == 100) {
        sink.add("你猜对了");
      } else {
        sink.addError('还没猜中，再试一次吧');
      }
    });

    controller.stream.transform(transformer).listen((data) => print(data), onError: (err) => print(err));

    controller.sink.add(23);
    //controller.sink.add(100);
  });

  test("test stream controller 2", () async {
    // 创建
    StreamController sc = StreamController(
        onListen: () => print("onListen"),
        onPause: () => print("onPause"),
        onResume: () => print("onResume"),
        onCancel: () => print("onCancel"),
        sync: false);
    StreamSubscription ss = sc.stream.listen(print);
    sc.add('element_1');
    // 暂停
    ss.pause();
    // 恢复
    ss.resume();
    // 取消
    ss.cancel();
    // 关闭流
    sc.close();
  });

  test("test stream controller broadcast", () async {
    // 创建广播流
    StreamController sc = StreamController.broadcast();

    sc.stream.listen(print);
    sc.stream.listen(print);

    sc.add("event1");
    sc.add("event2");
  });

  test("test stream controller transformer", () async {
    StreamController sc = StreamController<int>();


    // 创建 StreamTransformer对象
    StreamTransformer stf = StreamTransformer<int, double>.fromHandlers(
      handleData: (int data, EventSink sink) {
        // 操作数据后，转换为 double 类型
        sink.add((data * 2).toDouble());
      },
      handleError: (error, stacktrace, sink) {
        sink.addError('wrong: $error');
      },
      handleDone: (sink) {
        sink.close();
      },
    );

    // 调用流的transform方法，传入转换对象
    Stream stream = sc.stream.transform(stf);

    stream.listen(print);

    // 添加数据，这里的类型是int
    sc.add(1);
    sc.add(2);
    sc.add(3);

    // 调用后，触发handleDone回调
    // sc.close();
  });
}
