import 'dart:io';
import 'dart:isolate';

main(args, SendPort sp) {
  ReceivePort port = ReceivePort();
  SendPort sp1 = port.sendPort;
  port.listen((message) {
    print('主main 发送过来的 数据$message');
    final type = message[0];
    if (type == 'end') {
      sp.send(['end', '结束']);
    }
  });

  sp.send([0, sp1]);
  sleep(Duration(seconds: 1));
  sp.send([1, '其他数据']);
}
