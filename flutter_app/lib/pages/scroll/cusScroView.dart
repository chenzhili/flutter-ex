import 'dart:math';

import 'package:flutter/material.dart';

class CusScrolPage extends StatelessWidget {
  const CusScrolPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: CusScrolViewCom());
  }
}

class CusScrolViewCom extends StatefulWidget {
  CusScrolViewCom({Key key}) : super(key: key);

  @override
  _CusScrolViewComState createState() => _CusScrolViewComState();
}

class _CusScrolViewComState extends State<CusScrolViewCom> {
  List<Widget> list = List.generate(
      6,
      (index) => Padding(
            padding: EdgeInsets.all(4),
            child: Container(
              width: 50,
              height: 50,
              color: _randomColor(),
            ),
          ));
  Widget renderTile(String title) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Center(child: Text(title)),
    ));
  }

  static Color _randomColor() =>
      Color(0xffffffff & Random().nextInt(0xffffffff));
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: CustomScrollView(
      slivers: <Widget>[
        renderTile('SliverAppBar'),
        SliverAppBar(
          pinned: true, // 当滑动会固定在 顶部
          floating: true,
          expandedHeight: 200,
          snap: false,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('收缩appbar'),
            background: Image.asset('images/lake.jpg'),
          ),
        ),

        /// SliverList 和 SliverFixedExtentList 的区别
        ///  SliverList 的 item 项 是 高度自适应，根据内容 使用
        /// SliverFixedExtentList的item 是根据 itemExtent 设置的高度 定死的，不能超出；
        renderTile('SliverList'),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return UnconstrainedBox(
            child: Container(
                width: 100,
                height: 100,
                color: Color(0xffffffff & Random().nextInt(0xffffffff))),
          );
        }, childCount: 10)),
        renderTile('SliverAppBar实现 固定'),
        SliverAppBar(
          pinned: true,
          // floating: true,
          expandedHeight: 200,
          automaticallyImplyLeading: false,
          // snap: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('收缩appbar'),
            background: Image.asset('images/lake.jpg'),
          ),
        ),
        renderTile('SliverFixedExtentList'),
        SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Color(0xffffffff & Random().nextInt(0xffffffff))),
              );
            }, childCount: 20),
            itemExtent: 40),
        renderTile('SliverGrid.count'),
        SliverGrid.count(
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: list,
        )
      ],
    ));
  }
}
