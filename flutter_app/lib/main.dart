import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/globalNavIns.dart';
import 'package:flutter_app/pages/futureBuilderAndStreambuilder/futurebuilderEx.dart';
import 'package:flutter_app/pages/futureBuilderAndStreambuilder/streambuilderEx.dart';
import 'package:flutter_app/pages/scroll/cusScroView.dart';
import 'package:flutter_app/pages/scroll/cusScroltoPersistendHeader.dart';
import 'package:flutter_app/pages/scroll/gridViewCom.dart';
import 'package:flutter_app/pages/scroll/infinateScroll.dart';
import 'package:flutter_app/providerModel/themeColor.dart';
import 'package:flutter_app/theme.dart';
import 'package:provider/provider.dart';

import 'tabs/home/index.dart';
import 'tabs/search/search.dart';

import './utils/onGenerateRoute.dart' show genGenerateRoute;
import './pages/main-child.dart';
import './pages/animationsEx.dart';
import './pages/gestureEx.dart' show GesturePage;
import './pages/testUpdateUi.dart';
import './pages/Echarts/echarts.dart';
import './pages/Echarts/lineChart.dart';
import './pages/canvas/demo1.dart';
import './pages/componentComm/inheritedWidgetEx.dart';
import './pages/componentComm/User_Bean.dart';
import './pages/componentComm/notifcation.dart';
import './pages/componentComm/eventbus.dart';
import './pages/componentComm/provider/provider_base_page.dart';

/* 实现底部的菜单切换 以及 路由 和 导航 */
/// 20210508 加入 Provider 来做 数据共享
void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider.value(value: ThemeColorModel())],
    child: App()));

class App extends StatelessWidget {
  final routesConfig = {
    'mainChild': (BuildContext context, {parentContext}) => MainChild(),
    'animationEX': (BuildContext context, {parentContext}) =>
        AnimationExComplex(),
    'updateUi': (BuildContext context, {parentContext}) => UpdateUi(),
    'echartsPage': (BuildContext context, {parentContext}) => EchartsPage(),
    'linePage': (BuildContext context, {parentContext}) => LinePage(),
    'demo1Page': (BuildContext context, {parentContext}) => Demo1Page(),
    'notificationWidget': (BuildContext context, {parentContext}) =>
        NotificationWidget(),
    'eventBusWidget': (BuildContext context, {parentContext}) =>
        EventBusWidget(),
    'providerBasePage': (BuildContext context, {parentContext}) =>
        ProviderBasePage(),
    'futureBldPage': (BuildContext context, {parentContext}) => FutureBldPage(),
    'streamBldPage': (BuildContext context, {parentContext}) => StreamBldPage(),
    'infinateScrollPage': (BuildContext context, {parentContext}) =>
        InfinateScrollPage(),
    'gridViewCom': (BuildContext context, {parentContext}) => GridViewCom(),
    'cusScrolPage': (BuildContext context, {parentContext}) => CusScrolPage(),
    'sliverPersistentHeaderPage': (BuildContext context, {parentContext}) =>
        SliverPersistentHeaderPage(),
    // SliverPersistentHeaderPage
    'gesturePage': (BuildContext context, {parentContext}) => GesturePage(),
    'tabs': (BuildContext context, {parentContext}) => Tab()
  };

  @override
  Widget build(BuildContext context) {
    return UserInfoWidget(
        userBean: UserBean(name: 'flutter', address: 'china'),
        child: Consumer<ThemeColorModel>(builder: (context, value, child) {
          return MaterialApp(
            // navigatorKey: GlobalNavIns.navKey,
            theme: ThemeData(
                primaryColor: value.theme,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: value.theme)),
            debugShowCheckedModeBanner: false,
            onGenerateRoute:
                genGenerateRoute(this.routesConfig, parentContext: null),
            initialRoute: 'tabs',
          );
        }));
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

  // 存储当前时间
  DateTime _prevT;

  /// flustars 做 主题的 持久化
  @override
  void initState() {
    super.initState();
    _initTheme();
  }

  Future<void> _initTheme() async {
    await SpUtil.getInstance();
    SpUtil.getString('cus_theme_color');
    final _key = SpUtil.getString('key_theme_color', defValue: 'blue');
    // 设置初始化主题颜色
    Provider.of<ThemeColorModel>(context, listen: false).changeTheme(_key);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 处理 对于 子 路由 有 历史栈的处理
        if (GlobalNavIns.navKey.currentState.canPop()) {
          GlobalNavIns.navKey.currentState.pop();
          return false;
        } else {
          // 一定时间点击两次在退出
          if (_prevT == null ||
              DateTime.now().difference(_prevT) > Duration(milliseconds: 400)) {
            _prevT = DateTime.now();
            return false;
          } else {
            return true;
          }
        }
      },
      child: Scaffold(
        // appBar: AppBar(title: Text('首页'), centerTitle: true),
        bottomNavigationBar: BottomNavigationBar(
          onTap: this.changeTabs,
          currentIndex: curIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '搜索')
          ],
        ),
        body: tabs[curIndex],
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.palette),
            onPressed: () {
              print('切换主题');
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Text(
                    '起换主题',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ThemeWidget()
            ],
          ),
        ),
      ),
    );
  }

  changeTabs(index) {
    setState(() {
      this.curIndex = index;
    });
  }
}
