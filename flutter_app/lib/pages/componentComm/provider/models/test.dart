import 'package:flutter/cupertino.dart';

class GoldItem {
  GoldItem({this.price, this.name});
  int price;
  String name;
}

/// 简单的做 个 列表数据
class TestModel extends ChangeNotifier {
  List<GoldItem> items = [];

  int get totalPrice =>
      items.fold(0, (previousValue, nextEl) => (previousValue) + nextEl.price);

  /// 唯一 可以更新 items 的 地方
  void addItem(GoldItem item) {
    items.add(item);
    notifyListeners();
  }
}
