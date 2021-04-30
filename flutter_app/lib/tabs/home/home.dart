import 'package:flutter/material.dart';
// import '../../pages/main-child.dart';

class Home extends StatefulWidget {
  static const name = 'home';
  final parentContext;
  Home({Key key, this.parentContext}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(parentContext: parentContext);
}

class _HomeState extends State<Home> {
  String backValue = '';
  final parentContext;
  _HomeState({this.parentContext});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('HOME'), centerTitle: true),
        body: ListView(
          children: [
            Column(
              children: [
                Center(
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('homeChild',
                              arguments: {'title': '1sfdsf'}).then((value) {
                            // print(value);
                            setState(() => {backValue = value});
                          });
                        },
                        child: Text('跳转到 home-child,返回的值$backValue'))),
                Center(
                    child: RaisedButton(
                  onPressed: () {
                    Navigator.of(parentContext).pushNamed('mainChild');
                  },
                  child: Text('跳转到 main-child'),
                )),
                InkWell(
                  onTap: () {
                    Navigator.of(parentContext).pushNamed('animationEX');
                  },
                  child: Center(
                    child: Text('跳转到 动画练习页'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(parentContext).pushNamed('gesturePage');
                  },
                  child: Center(
                    child: Text('跳转到 手势训练页面'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(parentContext).pushNamed('updateUi');
                  },
                  child: Center(
                    child: Text('跳转到 更新测试页面'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(parentContext).pushNamed('echartsPage');
                  },
                  child: Center(
                    child: Text('跳转到 echarts测试页面'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(parentContext).pushNamed('linePage');
                  },
                  child: Center(
                    child: Text('跳转到 echarts测试折线页面'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(parentContext).pushNamed('demo1Page');
                  },
                  child: Center(
                    child: Text('跳转到 canvasDemo1'),
                  ),
                )
                // demo1Page
              ],
            )
          ],
        ));
  }
}
