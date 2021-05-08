import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providerModel/themeColor.dart';
import 'package:provider/provider.dart';

Map<String, Color> themeColorMap = {
  'gray': Colors.grey,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.purple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'deepOrange': Colors.orange,
  'green': Colors.green,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'teal': Colors.teal,
  'black': Colors.black,
};

class ThemeWidget extends StatefulWidget {
  ThemeWidget({Key key}) : super(key: key);

  @override
  _ThemeWidgetState createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  String _colorKey = 'blue';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: themeColorMap.keys.map((k) {
          return Padding(
              padding: EdgeInsets.all(5),
              child: InkWell(
                onTap: () {
                  _colorKey = k;
                  // listen 不需要 去 做 相关依赖的变化，优势是 当 实例 发生变化，这个组件也不会重新build
                  Provider.of<ThemeColorModel>(context, listen: false)
                      .changeTheme(k);

                  /// 重置 缓存
                  SpUtil.putString('key_theme_color', k);
                  setState(() {});
                },
                child: Container(
                  width: 40,
                  height: 40,
                  color: themeColorMap[k],
                  child: _colorKey == k
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : null,
                ),
              ));
        }).toList(),
      ),
    );
  }
}
