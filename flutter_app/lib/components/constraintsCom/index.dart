import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 对于盒模型的 的 限制 相关的；

/* class ConstraiComs extends StatelessWidget {
  const ConstraiComs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: ConstrainedBox(
              // 最小值 min 取得是 并集，满足所有的条件
              constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
                child: Container(
                  color: Colors.red,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: ConstrainedBox(
              // 最大值 max 取得是 交集，满足所有的条件
              constraints: BoxConstraints(maxWidth: 90.0, minHeight: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 60.0, minHeight: 60.0),
                child: Container(
                  color: Colors.red,
                ),
              )),
        ),
        Padding(
            padding: EdgeInsets.all(10),
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(100, 100)),
              child: Container(
                color: Colors.red,
              ),
            )),
        SizedBox(
          width: 10,
          height: 10,
          child: Container(color: Colors.red),
        )
      ],
    );
  }
} */

class ConstraiComs extends StatefulWidget {
  ConstraiComs({Key key}) : super(key: key);

  @override
  _ConstraiComsState createState() => _ConstraiComsState();
}

class _ConstraiComsState extends State<ConstraiComs> {
  final List list = List.filled(1000, 10);
  double h = 40000.0;
  @override
  void initState() {
    super.initState();
    h = list.length.toDouble() * 40;
    print(h);
    setState(() {});
  }

  @override

  /// 没有 开启 sliver 模式
  /* Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView(
      // listView 是否 开启 sliver 的 标志是否 用的 ListView.builder, 当用 children 的时候就是 全部创建，如果是 builder 就是 按需创建（viewPort为单位的创建）
      // itemExtent: h,
      shrinkWrap: false,
      children: genCom(),
    ));
  } */

  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView.builder(
            itemExtent: 80, // 当个itme 的 高度
            shrinkWrap: false,
            itemBuilder: (context, index) {
              return UnconstrainedBox(
                  child: SizedBox(
                width: 40,
                height: 40,
                child: Container(
                    color: Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF))),
              ));
            }));
  }

  List<Widget> genCom() {
    return list
        .map((e) => UnconstrainedBox(
              // 为了不受 祖先上的 相关限制盒子的影响
              child: SizedBox(
                width: 40,
                height: 40,
                child: Container(
                    color: Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF))),
              ),
            ))
        .toList();
  }
}
