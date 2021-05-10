import 'dart:io';

import 'package:flutter/foundation.dart';

/// 耗时 操作, 内部就是 用 isolate 实现的
void computeCoop() async {
  const str = 'test';
  final result = await compute(dosomething, str);
  print(result);
}

String dosomething(args) {
  print('开始计算');
  sleep(Duration(seconds: 3));
  return '这是返回的$args';
}
