import 'package:flutter/material.dart';

import '../../components/navigatorTTabs.dart';

import './home.dart';
import './child.dart';

class HomeNav extends StatefulWidget {
  HomeNav({Key key}) : super(key: key);

  @override
  _HomeNavState createState() => _HomeNavState();
}

final routes = [Home, HomeChild].toList();

class _HomeNavState extends State<HomeNav> {
  final initialRoute = Home.name;

  Map routeConfig = {
    Home.name: (BuildContext context, {parentContext}) =>
        Home(parentContext: parentContext),
    HomeChild.name: (BuildContext context, {parentContext, arguments}) =>
        HomeChild(arguments: arguments)
  };
  @override
  Widget build(BuildContext context) {
    return NavigatorTTabs(
        initRoute: this.initialRoute, configRoutes: this.routeConfig);
  }
}
