import 'package:flutter/material.dart';

import 'tabs/home/index.dart';
import 'tabs/search/search.dart';

import './utils/onGenerateRoute.dart' show genGenerateRoute;
import './pages/main-child.dart';
import './pages/animationsEx.dart';
import './pages/gestureEx.dart' show GesturePage;
import './pages/testUpdateUi.dart';
import './pages/Echarts/echarts.dart';

/* 实现底部的菜单切换 以及 路由 和 导航 */

void main() => runApp(App());

class App extends StatelessWidget {
  final routesConfig = {
    'mainChild': (BuildContext context, {parentContext}) => MainChild(),
    'animationEX': (BuildContext context, {parentContext}) =>
        AnimationExComplex(),
    'updateUi': (BuildContext context, {parentContext}) => UpdateUi(),
    'echartsPage': (BuildContext context, {parentContext}) => EchartsPage(),
    // EchartsPage
    'gesturePage': (BuildContext context, {parentContext}) => GesturePage(),
    'tabs': (BuildContext context, {parentContext}) => Tab()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: genGenerateRoute(this.routesConfig, parentContext: null),
      initialRoute: 'tabs',
    );
  }
}

class Tab extends StatefulWidget {
  Tab({Key key}) : super(key: key);

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
  int curIndex = 0;
  final tabs = [HomeNav(), Search()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('首页'), centerTitle: true),
        bottomNavigationBar: BottomNavigationBar(
          onTap: this.changeTabs,
          currentIndex: curIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '搜索')
          ],
        ),
        body: tabs[curIndex]);
  }

  changeTabs(index) {
    setState(() {
      this.curIndex = index;
    });
  }
}
