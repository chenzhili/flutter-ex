import 'package:flutter/material.dart';

class ScrollControlCom extends StatefulWidget {
  ScrollControlCom({Key key}) : super(key: key);

  @override
  _ScrollControlComState createState() => _ScrollControlComState();
}

class _ScrollControlComState extends State<ScrollControlCom> {
  bool showToTop = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ScrollController测试')),
      body: ScrollCon(updateStatus: changeTopBtn),
      floatingActionButton:
          !showToTop ? null : Icon(Icons.arrow_circle_up, size: 50),
    );
  }

  void changeTopBtn(bool status) {
    print(status);
    showToTop = status;
    setState(() {});
  }
}

class ScrollCon extends StatefulWidget {
  final Function updateStatus;
  ScrollCon({Key key, this.updateStatus}) : super(key: key);

  @override
  _ScrollConState createState() => _ScrollConState();
}

class _ScrollConState extends State<ScrollCon> {
  List list = List.filled(100, 1);
  /* controller 是为了 获取 当前 滚动的 相关信息 */
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      // print(_controller.offset);
      if (_controller.offset > 1000) {
        widget.updateStatus(true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        controller: _controller,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(title: Text('组件列表$index')));
        });
  }
}
