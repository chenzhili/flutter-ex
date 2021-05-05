import 'package:flutter/material.dart';

import 'User_Bean.dart';

class UserInfoInheritedWidget extends InheritedWidget {
  UserBean userBean;
  Function updateInfo;

  UserInfoInheritedWidget(
      {this.userBean, Key key, Widget child, this.updateInfo})
      : super(key: key, child: child);

  void updateUserBean(String name, String address) {
    updateInfo(name, address);
  }

  @override
  bool updateShouldNotify(covariant UserInfoInheritedWidget oldWidget) {
    print('$oldWidget====$userBean');
    // return true; // 这样 判定 可能导致 重复渲染
    /// 这里是 同一个 引用 对象，导致 判断没意义
    if (oldWidget.userBean.name != userBean.name ||
        oldWidget.userBean.address != userBean.address) {
      return true;
    }
    return false;
  }
}

class UserInfoWidget extends StatefulWidget {
  UserBean userBean;
  Widget child;
  UserInfoWidget({Key key, this.userBean, this.child}) : super(key: key);

  static UserInfoInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UserInfoInheritedWidget>();
  }

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  void update(String name, String address) {
    setState(() {
      // widget.userBean.name = name;
      // widget.userBean.address = address;
      /// 需要新生成一个 地址
      widget.userBean = UserBean(name: name, address: address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserInfoInheritedWidget(
        userBean: widget.userBean, child: widget.child, updateInfo: update);
  }
}
