/**
 * 这是错误的
 * 生成 统一的 routes
 * 不能将 class 作为 function 的 参数传入
 */
Map<String, dynamic> genRoutes(List routesWidget) {
  final routesConfig = {};
  print('routesWidget$routesWidget');
  routesWidget.forEach((element) {
    print('element${element['name']}');
    // routesConfig[element['name'] != null ? element['name'] : 'unknow'] =
    //     (BuildContext context, {arguments}) => element(arguments: arguments);
  });
  return routesConfig;
}
