import 'dart:io';

import 'dart:isolate';

void main() {
  // print(1);
  // test('123', p: 1, b: 1);
  // posTest('12');

  // var temp = 'why';
  // // var temp = null;
  // var name = temp ?? 'kobe';
  // print(name);

  // var name1 = 'coderwhy';
  // print(name1);
  // var name2 = 'kobe';
  // // var name2 = null;
  // name2 ??= 'james';
  // print(name2);

  // var a;
  // if (a == null) {
  //   print(1213);
  // }

  // print(new A('name', 23));
  // print(T.red);

  // print(2);
  // Future.value(2).then((value) {
  //   print(value);
  // });
  // print(3);

  // var a = new CO();
  // a.a();
  //
  // Aa abc = new Aa(1);
  // print(abc.aa);
  //
  // List TA = [];
  // TA.add(() => Test);
  // Test a;
  // TA.forEach((e) {
  //   a = e();
  //   print('sdfsdfsf${a.age}');
  // });
  // final ab = Tt(12);
  /* final child = Child();
  print('${child.a}${child.b}'); */
  /* var aa = Testa();
  print(aa.b);
  print(aa is Test); */
  // print(a.toUpperCase());
  /* var sb = StringBuffer();
  sb
    ..write('Use a StringBuffer for ')
    ..writeAll(['efficient', 'string', 'creation'], ' ')
    ..write('.');

  var fullString = sb.toString(); */
  // 执行表达式是返回 Test 的 实例
  /* print(Test()
    ..a = 1
    ..b = 3
    ..c = 3);
  // 执行对象方法返回的是 方法的 值
  var sortedColors =
      ['red', 'green', 'orange', 'blue', 'black', 'pink'].sublist(1, 4)..sort();
  print(sortedColors);
  a.substring(0, 1);
  var testL = [1, 2, 3, 4];
  print(testL[0]); */
  /* final test = [1, 2, 32, 3, 5, 5];
  print(test.fold(0, (prev, int nextEl) {
    return ((prev as int) + nextEl);
  })); */

  /**
   * 20210510
   */

  /// future 和 stream 的 理解
  ///
  /// Future
  ///
  ///
  /// 这里的 任务队列 是  main 主任务，microtask，event(跟js的下一个宏任务差不多)
  print('first');
  // 这里是指 等待 1s 将，当前 任务 压入 event中
  Future.delayed(Duration(seconds: 1), () {
    print('这里的顺序');
  });
  Future.microtask(() => {print('添加的 microTask')});
  // 这是 直接将 当前 future 直接 压入 event，在 同一个 event中 是同步执行的
  ///当Future中的任务完成后，我们往往需要一个回调，这个回调立即执行，不会被添加到事件队列
  Future(() {
    sleep(Duration(seconds: 5));
    print('这是 Promise 结构体？');
  }).then((value) {
    print('这是 promise的返回？');
  });

  /// 测试 多个 回调，加入 future
  Future(() {
    /// 这里 压入 event 时间 在 下面的后面，等到 所有的 回调完成后，下一个 event才算 执行完成(前提是 没有生成新的 event)
    return Future.delayed(Duration(seconds: 1));
  }).then((value) {
    print('加入延迟的输出');
  });
  Future(() {}).then((value) {
    print('第一个回掉');
  }).then((value) {
    print('第二个回调');

    ///第一种情况
    // return sleep(Duration(seconds: 3));
    /// 第二种情况
    /* return Future(() {
      print('形成新的 event');
    }); */
    /// 第三种情况，返回跟 第二个一样的
    return Future.delayed(Duration(
        seconds:
            1)); // 这里注意 延时 delayed的操作的 等待时间，会 决定 压入的 event 的时间，如果 改成 milliseconds 这个时间就比，前面的块
  }).then((value) {
    print('第三个会掉');
  });

  /// 对于 Future 的 api 的 理解
  /// 1、对于 Future.sync 是 同步还是 异步的 ====> 得到的 答案是 同步的；
  Future.sync(() {
    sleep(Duration(seconds: 2));
    print('两秒后才打印');
  });
  print('影响 主函数吗');

  /// 2、Future.wait 等价于 Promise.all

  Future<int> getData() async {
    return 1;
  }

  void showData() async {
    final a = await getData();
    print(a);
  }

  showData();
}

doWork(SendPort port1) {
  print("new isolate start");
  ReceivePort rp2 = new ReceivePort();
  SendPort port2 = rp2.sendPort;

  rp2.listen((message) {
    print("doWork message: $message");
  });

  // 将新isolate中创建的SendPort发送到主isolate中用于通信
  port1.send([0, port2]);
  // 模拟耗时5秒
  sleep(Duration(seconds: 5));
  port1.send([1, "doWork 任务完成"]);

  print("new isolate end");
}
/* String a = 'asdff sfdfsdf';

// 级联调用
class Test {
  late int a;
  late int b;
  late int c;
} */

/* abstract class Test {
  late String a;
  String b = '123';
  void Testaa();
}

class Testa extends Test {
  String a = '1';
  void Testaa() {
    print('12323');
  }
} */

/* 函数 不能 承载 class */
/* class Tt {
  int b = 1;
  Tt(int v) : b = v {
    // b = v 表达式的 赋值 执行在 这个之前；
    print('实际的 b的值$b');
  }
}

class Parent {
  final b;
  Parent(this.b);
  Parent.a(this.b);
}

class Child extends Parent {
  final a = 2;
  Child() : super(null);
} */

// /* 函数 的 测试 */
// // 命名可选
// test(String a, {int? b, double? p}) {
//   print('$a, $b, $p');
// }

// // 位置可选
// posTest(String a, [int? c = 1, double? d = 2]) {
//   print('$a,$c,$d');
// }

// var a = null ?? 1;

// /* 类和 对象 */
// class A {
//   String name;
//   int age;
//   // 构造函数 赋值的 语法糖
//   A(this.name, this.age);
// }

// Set<String> aaa = {'1', '2'};
// var ab = {'a': 1, 'c': 2};

// enum T { red, green }

// abstract class AB<T> {
//   T a(T a) {
//     return a;
//   }
// }

// class O {
//   void a() {
//     print('aaaa');
//   }
// }

// class CO extends O {
//   @override
//   void a() {
//     print('bbbb');
//   }
// }

// T test_a<T>(T a) {
//   return a;
// }
// class Test {
//   static const name = 'test';
//   int age = 11;
// }
