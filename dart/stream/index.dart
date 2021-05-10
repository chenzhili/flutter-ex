import 'dart:async';
import 'dart:io';

void main() {
  // test1();
  // test2();
  // test3();
  // test22();
  test111();
}

///
///
///stream 可以 是 单广播，多广播（理解为 多订阅的方式）
///
///

/// 单广播
/// 创建 Stream => periodic，fromFuture，fromFutures,fromIterable,value
// 1、使用 periodic
test1() async {
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (value) {
    return value;
  });
  await for (var i in stream) {
    print(i);
  }
}

//2、 fromFutures 是否按照顺序执行的
test2() async {
  Stream<int> stream = Stream<int>.fromFutures([
    // 这里的 event 加入时间的 顺序，第二个->第一个->第三个
    Future.delayed(Duration(seconds: 2), () {
      print('第一个');
      return 1;
    }),
    Future(() {
      sleep(Duration(seconds: 3)); // 这里是阻塞性质
      return 4;
    }),
    Future(() {
      return 2;
    })
  ]);
  await for (var i in stream) {
    print(i);
  }
}

/// stream 的 监听获取数据的方式 , await for，forEach，listen

/// stream 实例的方法和方法 限制方法（take,takeWhile），跳过方法(skip,skipWhile),转换成list(Future<>=> await stream.tolist()),length属性(Future<>=> await stream.length)

///  StreamController 控制 流的 方式

test3() async {
  StreamController sc = StreamController(
      /* {void onListen()?,
      void onPause()?,
      void onResume()?,
      FutureOr<void> onCancel()?,
      bool sync = false} */
      );
  sc.add(1232323);
  sc.stream.listen((event) {
    print(event);
  });
}

/// 多广播
/// 有两种方式创建广播流，一种直接从Stream创建，另一种使用StreamController创建
// 第一种方式
test11() async {
  // 调用 Stream 的 asBroadcastStream 方法创建
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (e) => e)
      .asBroadcastStream(); // 这里 让他变成 多监听
  stream = stream.take(5);

  stream.listen(print);
  stream.listen(print);
}

// 第二种方式
test22() async {
  // 这种发布订阅模式，还是必须先订阅在分发的 才能收到
  StreamController sc = StreamController.broadcast();
  sc.stream.listen(print);
  sc.stream.listen(print);
  sc.add(12323);
  sc.add(3434);
}

/// 转换数据流 的格式，并且返回新的 stream
void test111() {
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
}
