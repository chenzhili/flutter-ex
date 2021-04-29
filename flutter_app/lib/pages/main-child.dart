import 'package:flutter/material.dart';

class MainChild extends StatefulWidget {
  MainChild({Key key}) : super(key: key);

  @override
  _MainChildState createState() => _MainChildState();
}

class _MainChildState extends State<MainChild>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      print('${_tabController.index}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TabBar(controller: _tabController, tabs: [
          Text('热榜'),
          Text('热搜'),
        ])),
        body: TabBarView(controller: _tabController, children: [
          Center(child: Text('热榜234234234')),
          Center(child: Text('热搜234234')),
        ]));
  }
}

/// 用默认的 tabController 进行操作
// class MainChild extends StatelessWidget {
//   static const name = 'mainChild';
//   const MainChild({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//             appBar: AppBar(
//                 title: TabBar(tabs: [
//               Text('热榜'),
//               Text('热搜'),
//             ])),
//             body: TabBarView(children: [
//               Center(child: Text('热榜')),
//               Center(child: Text('热搜')),
//             ])));
//   }
// }
