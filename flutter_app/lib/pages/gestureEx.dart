import 'package:flutter/material.dart';

class GesturePage extends StatelessWidget {
  const GesturePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('手势页面')), body: GestureEx());
  }
}

class GestureEx extends StatefulWidget {
  GestureEx({Key key}) : super(key: key);

  @override
  _GestureExState createState() => _GestureExState();
}

class _GestureExState extends State<GestureEx> {
  double conWidth;
  double conHeight;
  Alignment _alignment = Alignment.center;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        height: 400,
        child: Align(
          // Alignment 的 x 和y 方向都是 从 -1 1,中间 为 0
          alignment: _alignment,
          child: GestureDetector(
              onPanStart: (details) {
                // print(details);
                // print(context.size.height);
                // print(context.size.width);
                conWidth = context.size.width;
                conHeight = context.size.height;
              },
              onPanUpdate: (details) {
                // print(details.delta.dx);
                // 当用户在屏幕上滑动时，会触发多次Update事件，delta指一次Update事件的滑动的偏移量
                setState(() {
                  /// 等比例 来的 返回是 -1 ~ 1，导致 1-(-1)/width = x/dis ==>x = dis*2/width
                  _alignment += Alignment(details.delta.dx / (conWidth / 2),
                      details.delta.dy / (conHeight / 2));
                });
              },
              onPanEnd: (details) {
                setState(() {
                  if (_alignment.y > 1) {
                    _alignment = Alignment(_alignment.x, 1);
                  }
                });
              },
              child: Container(
                // width: 100,
                // height: 100,
                constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
                color: Colors.red,
                child: Center(
                  child: Text('拖动模块', style: TextStyle(color: Colors.white)),
                ),
              )),
        ));
  }
}
