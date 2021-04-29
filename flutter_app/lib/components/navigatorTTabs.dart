import 'package:flutter/material.dart';
import '../utils/onGenerateRoute.dart' show genGenerateRoute;

class NavigatorTTabs extends StatelessWidget {
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
}
