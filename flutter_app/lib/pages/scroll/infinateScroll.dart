import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class InfinateScrollPage extends StatelessWidget {
  const InfinateScrollPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('无限滚动列表')),
      body: ScrollCom(),
    );
  }
}

class ScrollCom extends StatefulWidget {
  ScrollCom({Key key}) : super(key: key);

  @override
  _ScrollComState createState() => _ScrollComState();
}

class _ScrollComState extends State<ScrollCom> {
  static const String noContent = '======无更多内容了========';
  var list = <String>[];
  static const int len = 1000;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              // index 是跟着 页面的 滚动位置
              final l = list.length - 1;
              print('$index======$l');
              if (index == l) {
                if (l < len) {
                  // 还能加载
                  getData();
                  return SizedBox(
                    width: 100,
                    height: 40,
                    child: Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )),
                  );
                } else {
                  // 已到最后
                  return ListTile(title: Text('$noContent'));
                }
              }
              return ListTile(title: Text('1323--$index'));
            }));
  }

  // 模拟请求
  void getData() async {
    // 这样没有形成异步，会阻塞
    /* sleep(Duration(seconds: 10));
    int i = 20;
    while (i-- != 0) {
      list.add('${Random()}$i');
    }
    setState(() {}); */
    Future.delayed(Duration(seconds: 2), () {
      int i = 20;
      while (i-- != 0) {
        list.add('${Random()}$i');
      }
      setState(() {});
    });
  }
}
