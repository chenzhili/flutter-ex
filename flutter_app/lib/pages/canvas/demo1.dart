import 'package:flutter/material.dart';

/* 
  自定义 canvas 绘制：
  1、实际 实现 绘制的 CustomPainter => 内部需要 有  画笔 Paint => 在 实际 实例会 调用 paint中有 canvas
  2、承载 自定义 绘图的 class 为 CustomPaint 

 */
class Demo1Page extends StatelessWidget {
  const Demo1Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('canvas-demo1')),
      body: CustomPaint(
          painter: Demo(), // 自定义绘制的基础类绘制效果会显示在child的下面,
          // foregroundPainter: Demo(), // 自定义绘制的基础类绘制效果会显示在child的上面,
          size: Size.infinite,
          child: Container(
              width: double.infinity, height: 400, color: Colors.transparent)),
    );
  }
}

class Demo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('size$size');
    final paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.red;
    canvas.drawLine(
        Offset(size.width / 2, size.height / 2), Offset(90, 1), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
