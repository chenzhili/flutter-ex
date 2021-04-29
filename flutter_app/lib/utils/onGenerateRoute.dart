import 'package:flutter/material.dart';
import '../pages/404.dart';

/// 统一 对于 onGenerateRoute 方法 的 处理
/// parentContext为 上级Navigator 的 上下文；
Function genGenerateRoute(Map configRoutes, {parentContext}) {
  return (RouteSettings settings) {
    // print('settings$settings$configRoutes');
    WidgetBuilder builder;
    // final routeNameArr = this.configRoutes.keys.toList();
    // print('routeNameArr===$routeNameArr');
    final routeName = settings.name;
    final arguments = settings.arguments;
    if (configRoutes[routeName] != null) {
      /* 这里动态 不能是 class 只能 传入 function 的 方式 */
      /* 
        这里的 builder 内的 context 是 当前 子Navigator 的 context；
       */
      final PageBuilder = configRoutes[routeName];
      if (arguments != null) {
        builder = (BuildContext context) => PageBuilder(context,
            parentContext: parentContext, arguments: arguments);
      } else {
        builder = (BuildContext context) {
          return PageBuilder(
            context,
            parentContext: parentContext,
          );
        };
      }
    } else {
      builder = (BuildContext context) => NotFound();
    }
    return new MaterialPageRoute(builder: builder, settings: settings);
  };
}
