import 'dart:math';

import 'package:flutter/material.dart';

class GridViewCom extends StatelessWidget {
  const GridViewCom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('测试gridView')),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: GirdViewCount(), // 这种如果有嵌套，由于不知道 实际 的 区域，需要 显示的 指定
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: GirdViewExtend(), // 这种如果有嵌套，由于不知道 实际 的 区域，需要 显示的 指定
            ),
            Expanded(child: Container(child: GridViewLaszy()))
            // SizedBox(
            //   width: double.infinity,
            //   height: 300,
            //   child: GridViewLaszy(), // 这种如果有嵌套，由于不知道 实际 的 区域，需要 显示的 指定
            // )
          ],
        ));
  }
}

class GirdViewCount extends StatefulWidget {
  GirdViewCount({Key key}) : super(key: key);

  @override
  _GirdViewCountState createState() => _GirdViewCountState();
}

// Flutter中提供了两个SliverGridDelegate的子类SliverGridDelegateWithFixedCrossAxisCount和SliverGridDelegateWithMaxCrossAxisExtent
class _GirdViewCountState extends State<GirdViewCount> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
    /* 等价与 GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, //横轴三个子widget
      childAspectRatio: 1.0 //宽高比为1时，子widget
  )) */
  }
}

class GirdViewExtend extends StatefulWidget {
  GirdViewExtend({Key key}) : super(key: key);

  @override
  _GirdViewExtendState createState() => _GirdViewExtendState();
}

class _GirdViewExtendState extends State<GirdViewExtend> {
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 100,
      childAspectRatio: 2,
      children: [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
  }
}

/// 跟 listView 一样，如果要做成 sliver 模式下的 加载，而不是 所有的 直接加载

class GridViewLaszy extends StatefulWidget {
  GridViewLaszy({Key key}) : super(key: key);

  @override
  _GridViewLaszyState createState() => _GridViewLaszyState();
}

class _GridViewLaszyState extends State<GridViewLaszy> {
  List<String> list = [];
  static int limit = 200;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final len = list.length - 1;
              if (index == len) {
                getData();
              }
              return Container(
                  color: Color(0xffffffff & Random().nextInt(0xffffffff)),
                  padding: EdgeInsets.all(10),
                  width: 100,
                  height: 100,
                  child: UnconstrainedBox(
                      child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Text('${list[index]}'),
                  )));
            }));
  }

  Future<void> getData() async {
    Future.delayed(Duration(seconds: 2), () {
      int i = 20;
      while (i-- != 0) {
        list.add('${Random()}$i');
      }
      setState(() {});
    });
  }
}
