import 'dart:io';
import 'dart:isolate';

main() {
  print('isolate start');
  create_isolate();
  print('isolate end');
}

/// isolate 的通信是通过  ReceivPort 形成 接受和发送消息的 单管道
create_isolate() async {
  ReceivePort port1 = ReceivePort();
  SendPort SP = port1.sendPort;

  var SP2;
  // 声明 一个 sendPort 从 子 Isolate 中 拿到，用于 和 子Isolate进行 通信
  // 链接 isolate 的方式
  Isolate isolate =
      await Isolate.spawnUri(Uri(path: './child_isolate.dart'), [], SP);

  port1.listen((message) {
    print('获取到的数据$message');
    print('${message[0]}');
    final int i = message[0];
    if (i == 0) {
      SP2 = message[1];
    } else {
      /* 接受到 消息的 回访 */
      SP2?.send(['a', '消息']);

      final String mess = message[1];
      if (mess == 'end') {
        SP2?.send(['end', '消息']);
        isolate.kill(priority: Isolate.immediate);
      } else {
        print(mess);
      }
    }
  });
}

/// spawnUri 相对 用的不多，用 spawn 作为 处理
create_isolate_new() async {
  ReceivePort port1 = ReceivePort();
  SendPort SP = port1.sendPort;

  var SP2;
  // 声明 一个 sendPort 从 子 Isolate 中 拿到，用于 和 子Isolate进行 通信
  // 链接 isolate 的方式
  Isolate isolate = await Isolate.spawn(doWork, SP);

  port1.listen((message) {
    print('获取到的数据$message');
    print('${message[0]}');
    final int i = message[0];
    if (i == 0) {
      SP2 = message[1];
    } else {
      /* 接受到 消息的 回访 */
      SP2?.send(['a', '消息']);

      final String mess = message[1];
      if (mess == 'end') {
        SP2?.send(['end', '消息']);
        isolate.kill(priority: Isolate.immediate);
      } else {
        print(mess);
      }
    }
  });
}

// 这里做 耗时比较久的任务
void doWork(SendPort port1) {
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

///
///
///
///在 flutter 中 对于 isolate 进行了 封装；====> compute
///
///
///
