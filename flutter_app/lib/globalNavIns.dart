import 'package:flutter/cupertino.dart';

/// 用于获取 tab 的 子Navigator 实例，用于  做 退出操作
class GlobalNavIns {
  static GlobalKey<NavigatorState> navKey = GlobalKey();
}
