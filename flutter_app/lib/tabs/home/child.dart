import 'package:flutter/material.dart';
import 'package:flutter_app/pages/componentComm/inheritedWidgetEx.dart';

class HomeChild extends StatelessWidget {
  static const name = 'homeChild';
  final arguments;
  const HomeChild({Key key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'child-home${this.arguments != null ? this.arguments['title'] : ''}'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.of(context).pop(); // 不能往回传参
                Navigator.pop(context, 'child返回值');
              }),
        ),
        body: Center(
            child: Row(
          children: [
            Text('HOME-Child'),
            Text('名字：${UserInfoWidget.of(context).userBean.name}'),
            Text('地址：${UserInfoWidget.of(context).userBean.address}')
          ],
        )));
  }
}
