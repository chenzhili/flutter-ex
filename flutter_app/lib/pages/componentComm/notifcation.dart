import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'User_Bean.dart';

// 这种 用法 需要 注意 上下文
class CusNotifcation extends Notification {
  UserBean userbean;

  CusNotifcation(this.userbean);
}

class NotificationWidget extends StatefulWidget {
  NotificationWidget({Key key}) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  UserBean userbean = UserBean(name: 'default', address: 'default');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('测试 notification')),
        body: Container(
            padding: EdgeInsets.all(10),
            // 需要 拿到 这个 组件后面的上下文
            child: NotificationListener<CusNotifcation>(
                onNotification: (data) {
                  setState(() {
                    userbean = data.userbean;
                  });
                  return true;
                },
                child: Builder(
                  builder: (context) => Center(
                      child: Column(
                    children: [
                      Text(userbean.name),
                      Text(userbean.address),
                      RaisedButton(
                          onPressed: () {
                            CusNotifcation(UserBean(
                                    name: 'flutter notification',
                                    address: 'china notification'))
                                .dispatch(context);
                          },
                          child: Text('改变值'))
                    ],
                  )),
                ))));
  }
}
