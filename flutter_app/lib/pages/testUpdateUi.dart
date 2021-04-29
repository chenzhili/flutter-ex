import 'package:flutter/material.dart';

class UpdateUi extends StatelessWidget {
  const UpdateUi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('测试setState')),
        body: /* TestState() */ ImplementTestState());
  }
}

/* 看看对于 setState 组件刷新的问题 
  这里的问题是 ：其实 传入的 textName只有 TestChild 跟他相关，应该只 刷新 TestChild，但是现在 刷新的问题出现在了 SecChild 和 TestChild 两个都刷新了，这个浪费性能
*/
class TestState extends StatefulWidget {
  TestState({Key key}) : super(key: key);

  @override
  _TestStateState createState() => _TestStateState();
}

class _TestStateState extends State<TestState> {
  String textName = 'sfsdfsdfsdf';
  final GlobalKey _key = GlobalKey<_TestStateState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          RaisedButton(
              onPressed: () {
                print('_key$_key');
                setState(() {
                  textName = '1232323';
                });
              },
              child: Text('更新')),
          SecChild(),
          TestChild(textName: textName)
        ],
      ),
    );
  }
}

class SecChild extends StatelessWidget {
  SecChild({Key key}) : super(key: key) {
    print('sec-child更新');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('sec-child'),
    );
  }
}

class TestChild extends StatelessWidget {
  String textName;
  TestChild({Key key, this.textName}) : super(key: key) {
    print('刷新2');
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(textName));
  }
}

/* 将上面的 问题 通过 globalKeys 进行 改造， globalKeys 中 可以 通过 key 找到 所有 存储的 State
  要实现 局部刷新；
  1、不能在 根 Widget 中 调用 setState；(setState 其实 也是 获取 从 当前 widget 以及 下面的 所有 子Widget 当做 所有 依赖，统一 build 刷新)
  2、利用 globalKeys 获取到 子组件的 实例（这个是有条件的，只有是 继承至 StatefullWidget 才能拿到实例，不然是 null）
 */

class ImplementTestState extends StatefulWidget {
  ImplementTestState({Key key}) : super(key: key);

  @override
  _ImplementTestStateState createState() => _ImplementTestStateState();
}

class _ImplementTestStateState extends State<ImplementTestState> {
  GlobalKey<_ImplementTestChildState> _key = GlobalKey();
  String textName;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          RaisedButton(
              onPressed: () {
                textName = '更新值';
                // setState(() {
                //   textName = textName;
                // });
                print('${_key.currentState.change}');
                _key.currentState.change(textName);
              },
              child: Text('更新')),
          SecChild(),
          ImplementTestChild(_key)
        ],
      ),
    );
    ;
  }
}

class ImplementTestChild extends StatefulWidget {
  ImplementTestChild(Key key) : super(key: key);

  @override
  _ImplementTestChildState createState() => _ImplementTestChildState();
}

class _ImplementTestChildState extends State<ImplementTestChild> {
  _ImplementTestChildState() {
    print('刷新');
  }
  String textName;
  @override
  void initState() {
    textName = '12313';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: Text(textName),
    ));
  }

  void change(String aaa) {
    setState(() {
      print(aaa);
      textName = aaa;
    });
  }
}
