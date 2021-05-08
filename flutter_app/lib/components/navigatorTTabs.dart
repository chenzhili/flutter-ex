import 'package:flutter/material.dart';
import '../globalNavIns.dart';
import '../utils/onGenerateRoute.dart' show genGenerateRoute;

class NavigatorTTabs extends StatefulWidget {
  final initRoute;
  final Map configRoutes;
  NavigatorTTabs(
      {Key key, @required this.initRoute, @required this.configRoutes})
      : super(key: key);

  @override
  _NavigatorTTabsState createState() => _NavigatorTTabsState();
}

class _NavigatorTTabsState extends State<NavigatorTTabs> {
  // GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: GlobalNavIns.navKey,
        initialRoute: widget.initRoute,
        onGenerateRoute:
            genGenerateRoute(widget.configRoutes, parentContext: context));
  }
}

/* class NavigatorTTabs extends StatelessWidget {
  final initRoute;
  final Map configRoutes;
  NavigatorTTabs(
      {@required this.initRoute, @required this.configRoutes, Key key})
      : super(key: key);

  @override
  // 这里的 context 是 MaterialApp 的 context，指向 根的 Navigator
  Widget build(BuildContext context) {
    return Navigator(
        initialRoute: this.initRoute,
        onGenerateRoute:
            genGenerateRoute(this.configRoutes, parentContext: context));
  }
} */
