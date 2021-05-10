import 'package:flutter/material.dart';

import 'isloateToCompute.dart';

class FutureBldPage extends StatelessWidget {
  const FutureBldPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('futureBldPage')),
        body: Center(child: FutureBldEx()));
  }
}

// 测试 futureBuilder
Future getData() async {
  await Future.delayed(Duration(seconds: 2));
  return 3;
}

class FutureBldEx extends StatefulWidget {
  FutureBldEx({Key key}) : super(key: key);

  @override
  _FutureBldExState createState() => _FutureBldExState();
}

class _FutureBldExState extends State<FutureBldEx> {
  @override
  void initState() {
    super.initState();
    computeCoop();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        initialData: 1323232,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text('当前状态获取到值${snapshot.data}');
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
